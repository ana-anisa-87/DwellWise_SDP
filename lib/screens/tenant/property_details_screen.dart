import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/property_provider.dart';
import '../../providers/chat_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/verified_badge.dart';
import '../../widgets/rating_widget.dart';

/// Detail screen for a selected property listing.
class TenantPropertyDetailsScreen extends StatelessWidget {
  final String propertyId;

  const TenantPropertyDetailsScreen({
    Key? key,
    required this.propertyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final propertyProvider = context.watch<PropertyProvider>();
    final property = propertyProvider.selectedProperty;

    if (property == null || property.id != propertyId) {
      return Scaffold(
        appBar: AppBar(title: const Text('Property Details')),
        body: const Center(child: Text('Loading property details...')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Header block placeholder
                Container(
                  height: 280,
                  color: const Color(0xff0F766E).withOpacity(0.1),
                  child: const Center(
                    child: Icon(Icons.home_work_rounded, size: 80, color: Color(0xff0F766E)),
                  ),
                ),
                
                // Detailed data
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            property.area.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xff0F766E),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          if (property.isVerified) const VerifiedBadge(),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        property.title,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff1E293B)),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const RatingWidget(rating: 4.8),
                          const SizedBox(width: 8),
                          Text('(${property.beds} beds, ${property.baths} baths)', style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),
                      Text(
                        '৳${property.price.toInt()} / month',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff0F766E)),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        property.description,
                        style: const TextStyle(fontSize: 15, height: 1.6),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Facilities Included:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      
                      // Facilities list
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: property.facilities.map((f) {
                          return Chip(
                            label: Text(f),
                            backgroundColor: const Color(0xff0F766E).withOpacity(0.08),
                            side: BorderSide.none,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Floating Back arrow
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xff1E293B)),
                onPressed: () => context.pop(),
              ),
            ),
          ),

          // Sticky Footer Actions
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: Colors.white,
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Calling property manager...')),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xff0F766E), width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Call Owner', style: TextStyle(color: Color(0xff0F766E))),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: 'Chat Now',
                        onPressed: () {
                          // Navigate to messaging
                          context.read<ChatProvider>().loadChatHistory(property.id);
                          context.push('/chat/${property.id}');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
