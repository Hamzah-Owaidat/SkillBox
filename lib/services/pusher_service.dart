import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:skillbox/models/notification.dart';

class PusherService {
  static final PusherService _instance = PusherService._internal();
  factory PusherService() => _instance;
  PusherService._internal();

  PusherChannelsFlutter? pusher;
  bool _isInitialized = false;
  String? _userId;

  // Callback for new notifications
  Function(NotificationModel)? onNotificationReceived;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print('❌ No token found, cannot initialize Pusher');
        return;
      }

      // Decode JWT to get user ID (simple base64 decode)
      _userId = _getUserIdFromToken(token);

      if (_userId == null) {
        print('❌ Could not extract user ID from token');
        return;
      }

      pusher = PusherChannelsFlutter.getInstance();

      await pusher!.init(
        apiKey: dotenv.env['PUSHER_APP_KEY']!,
        cluster: dotenv.env['PUSHER_CLUSTER']!,
        useTLS: true,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onAuthorizer: onAuthorizer,
      );

      await pusher!.subscribe(channelName: 'private-user-$_userId');
      await pusher!.connect();

      _isInitialized = true;
      print('✅ Pusher initialized for user: $_userId');
    } catch (e) {
      print('❌ Error initializing Pusher: $e');
    }
  }

  String? _getUserIdFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(decoded);

      return payloadMap['data']?['id']?.toString();
    } catch (e) {
      print('Error decoding token: $e');
      return null;
    }
  }

  dynamic onAuthorizer(
    String channelName,
    String socketId,
    dynamic options,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) return null;

      final response = await http.post(
        Uri.parse(dotenv.env['PUSHER_AUTH_ENDPOINT']!),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'socket_id': socketId, 'channel_name': channelName}),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        // Ensure exactly what Pusher expects
        if (body['auth'] != null && body['shared_secret'] != null) {
          return {
            'auth': body['auth'].toString(),
            'shared_secret': body['shared_secret'].toString(),
          };
        } else {
          print('❌ Auth response missing required fields: $body');
          return null;
        }
      } else {
        print('❌ Auth failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('❌ Auth error: $e');
      return null;
    }
  }

  void onEvent(PusherEvent event) {
    print('📩 Pusher event received: ${event.eventName}');
    print('📦 Raw event data: ${event.data}'); // See the raw data
    print('📡 Channel: ${event.channelName}');

    if (event.eventName == 'notification.received') {
      try {
        final data = json.decode(event.data);
        print('🔍 Decoded data: $data'); // See decoded structure
        print('🔍 Data type: ${data.runtimeType}');

        final notification = NotificationModel.fromJson(data);
        print('✅ Notification parsed: ${notification.title}');

        

        if (onNotificationReceived != null) {
          onNotificationReceived!(notification);
        }
      } catch (e, stackTrace) {
        print('❌ Error parsing notification: $e');
        print('Stack trace: $stackTrace');
        print('Raw event data: ${event.data}');
      }
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print('✅ Subscribed to: $channelName');
  }

  void onSubscriptionError(String message, dynamic e) {
    print('❌ Subscription error: $message');
  }

  void onDecryptionFailure(String event, String reason) {
    print('❌ Decryption failure: $event - $reason');
  }

  void onMemberAdded(String channelName, PusherMember member) {
    print('👤 Member added: ${member.userId}');
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    print('👤 Member removed: ${member.userId}');
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print('🔄 Connection state: $currentState');
  }

  void onError(String message, int? code, dynamic e) {
    print('❌ Pusher error: $message (code: $code)');
  }

  Future<void> disconnect() async {
    if (_userId != null) {
      await pusher?.unsubscribe(channelName: 'private-user-$_userId');
    }
    await pusher?.disconnect();
    _isInitialized = false;
    print('🔌 Pusher disconnected');
  }
}
