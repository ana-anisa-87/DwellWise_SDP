import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/search_provider.dart';
import '../../providers/property_provider.dart';
import '../../widgets/property_card.dart';
import '../../widgets/filter_chip.dart';

/// Screen representing tenant search query results and filters.
class TenantSearchScreen extends StatelessWidget {
  const TenantSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();
    final propertyProvider = context.watch<PropertyProvider>();

    final filteredListings = searchProvider.filterListings(propertyProvider.properties);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search & Filter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => searchProvider.resetFilters(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Text query field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (val) => searchProvider.updateSearchQuery(val),
              decoration: const InputDecoration(
                labelText: 'Type area, title, or details...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          
          // Category selection chips
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                'All',
                'Wifi',
                'Parking',
                'Lift',
                'Backup',
              ].map((category) {
                final isSelected = searchProvider.selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: DwellFilterChip(
                    label: category,
                    isSelected: isSelected,
                    onSelected: (val) {
                      if (val) searchProvider.updateCategory(category);
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // Price range display
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Budget: ৳${searchProvider.priceRange.start.toInt()}'),
                    Text('৳${searchProvider.priceRange.end.toInt()}'),
                  ],
                ),
                RangeSlider(
                  values: searchProvider.priceRange,
                  min: 10000,
                  max: 150000,
                  divisions: 14,
                  onChanged: (val) => searchProvider.updatePriceRange(val),
                ),
              ],
            ),
          ),

          // Results count header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Matches Found: ${filteredListings.length}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Search results
          Expanded(
            child: filteredListings.isEmpty
                ? const Center(child: Text('No matches found for your filter criteria.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredListings.length,
                    itemBuilder: (context, index) {
                      final property = filteredListings[index];
                      return PropertyCard(
                        property: property,
                        onTap: () {
                          propertyProvider.selectProperty(property);
                          context.push('/property-details/${property.id}');
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
