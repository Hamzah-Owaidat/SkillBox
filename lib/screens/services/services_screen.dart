import 'package:flutter/material.dart';
import '../../models/service.dart';
import '../../services/services_service.dart';
import 'service_details_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late Future<List<Service>> _futureServices;

  @override
  void initState() {
    super.initState();
    _futureServices = ServicesService.getServices();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<Service>>(
        future: _futureServices,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Failed to load services",
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          final services = snapshot.data!;

          return LayoutBuilder(
            builder: (context, constraints) {
              // Responsive grid columns based on screen width
              int crossAxisCount = 2;
              double childAspectRatio = 0.75; // Reduced from 0.85 to give more height
              
              if (constraints.maxWidth > 600) {
                crossAxisCount = 3;
                childAspectRatio = 0.8; // Reduced from 0.9
              } else if (constraints.maxWidth < 350) {
                crossAxisCount = 1;
                childAspectRatio = 1.1; // Reduced from 1.2
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "What We Offer",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Transform your business with our premium creative services",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: services.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: childAspectRatio,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemBuilder: (context, index) {
                        final service = services[index];
                        return _buildServiceCard(context, service);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, Service service) {
    return Container(
      padding: const EdgeInsets.all(12), // Reduced from 16
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Changed from default
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top section: Icon and Title
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 24, // Reduced from 28
                backgroundColor: Colors.cyan[50],
                child: Text(
                  service.image,
                  style: const TextStyle(fontSize: 20), // Reduced from 24
                ),
              ),
              const SizedBox(height: 8), // Reduced from 12
              Text(
                service.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04, // Responsive
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Description section - flexible
          Flexible(
            child: Text(
              service.description,
              maxLines: 2, // Reduced from 3
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.032, // Responsive
                color: Colors.grey[700],
              ),
            ),
          ),
          const SizedBox(height: 8), // Reduced spacing
          // Button section
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8), // Reduced from 10
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ServiceDetailsScreen(serviceId: service.id),
                  ),
                );
              },
              child: Text(
                "Get Started",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035, // Responsive
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
