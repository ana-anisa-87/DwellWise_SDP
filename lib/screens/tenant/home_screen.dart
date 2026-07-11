import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/property_provider.dart';
import '../../providers/user_provider.dart';
import '../../models/user_model.dart';
import '../../widgets/property_card.dart';
import '../../widgets/bottom_navigation.dart';

/// Seeker Home Screen showing listings feed and role perspective switch shortcut.
class TenantHomeScreen extends StatefulWidget {
  const TenantHomeScreen({Key? key}) : super(key: key);

  @override
  State<TenantHomeScreen> createState() => _TenantHomeScreenState();
}

class _TenantHomeScreenState extends State<TenantHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PropertyProvider>().fetchProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    final propertyProvider = context.watch<PropertyProvider>();
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('DwellWise Seeker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_pin),
            onPressed: () => context.push('/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              userProvider.switchPerspective(UserRole.owner);
              context.go('/owner-home');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Banner search prompt
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              readOnly: true,
              onTap: () => context.push('/search'),
              decoration: InputDecoration(
                hintText: 'Search by neighborhood (e.g. Gulshan)',
                prefixIcon: const Icon(Icons.search, color: Color(0xff0F766E)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          
          Expanded(
            child: propertyProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: propertyProvider.properties.length,
                    itemBuilder: (context, index) {
                      final property = propertyProvider.properties[index];
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
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
    );
  }
}
