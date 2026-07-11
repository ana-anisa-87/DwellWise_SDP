import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/property_provider.dart';
import '../../widgets/property_card.dart';

/// Screen listing properties bookmarked by tenant.
class TenantSavedListingsScreen extends StatelessWidget {
  const TenantSavedListingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final propertyProvider = context.watch<PropertyProvider>();
    // Mock bookmark selection for presentation
    final bookmarked = propertyProvider.properties.take(1).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Listings')),
      body: bookmarked.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 48, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('No bookmarked listings yet.', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookmarked.length,
              itemBuilder: (context, index) {
                final property = bookmarked[index];
                return PropertyCard(
                  property: property,
                  onTap: () {
                    propertyProvider.selectProperty(property);
                    context.push('/property-details/${property.id}');
                  },
                );
              },
            ),
    );
  }
}
