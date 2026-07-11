import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/property_provider.dart';
import '../../widgets/property_card.dart';

/// Screen listing properties uploaded by owner.
class OwnerMyListingsScreen extends StatelessWidget {
  const OwnerMyListingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final propertyProvider = context.watch<PropertyProvider>();
    // Simulating landlord filter
    final myListings = propertyProvider.properties;

    return Scaffold(
      appBar: AppBar(title: const Text('My Listings')),
      body: myListings.isEmpty
          ? const Center(child: Text('You have not uploaded any property listings.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: myListings.length,
              itemBuilder: (context, index) {
                final property = myListings[index];
                return PropertyCard(
                  property: property,
                  onTap: () {
                    propertyProvider.selectProperty(property);
                    context.push('/owner-listing-details/${property.id}');
                  },
                );
              },
            ),
    );
  }
}
