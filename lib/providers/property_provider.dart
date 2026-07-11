import 'package:flutter/material.dart';
import '../models/property_model.dart';
import '../services/supabase_service.dart';

/// Provider handling Property listings retrieval, insertion, and detail focus updates.
class PropertyProvider with ChangeNotifier {
  final SupabaseService _dbService = SupabaseService();

  List<PropertyModel> _properties = [];
  PropertyModel? _selectedProperty;
  bool _isLoading = false;

  List<PropertyModel> get properties => _properties;
  PropertyModel? get selectedProperty => _selectedProperty;
  bool get isLoading => _isLoading;

  /// Loads properties list.
  Future<void> fetchProperties() async {
    _isLoading = true;
    notifyListeners();
    try {
      _properties = await _dbService.getProperties();
      // If list is empty, initialize mock data for presentation reliability
      if (_properties.isEmpty) {
        _loadMockProperties();
      }
    } catch (e) {
      debugPrint('Error listing properties: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Registers a new property listing.
  Future<bool> addProperty(PropertyModel newProperty) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _dbService.createProperty(newProperty);
      _properties.insert(0, newProperty);
      return true;
    } catch (e) {
      debugPrint('Error creating listing: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sets selected property focus.
  void selectProperty(PropertyModel property) {
    _selectedProperty = property;
    notifyListeners();
  }

  void _loadMockProperties() {
    _properties = [
      PropertyModel(
        id: 'p1',
        title: 'Premium Glass Penthouse',
        description: 'Stunning luxury penthouse in Gulshan. Direct lake view, smart automation and dual parking.',
        price: 125000,
        area: 'Gulshan',
        address: 'Road 55, Gulshan 2, Dhaka',
        latitude: 23.7925,
        longitude: 90.4078,
        beds: 3,
        baths: 4,
        sizeSqFt: 3200,
        imageUrls: ['https://placeholder.com/600'],
        isVerified: true,
        ownerId: 'o1',
        facilities: ['Wifi', 'Parking', 'Lift', 'Backup'],
        createdAt: DateTime.now(),
      ),
      PropertyModel(
        id: 'p2',
        title: 'Modern Skyline Studio',
        description: 'Fully furnished studio in Banani commercial blocks. Perfect for executives.',
        price: 62000,
        area: 'Banani',
        address: 'Kemal Ataturk Avenue, Banani, Dhaka',
        latitude: 23.7937,
        longitude: 90.4033,
        beds: 1,
        baths: 1,
        sizeSqFt: 850,
        imageUrls: ['https://placeholder.com/600'],
        isVerified: true,
        ownerId: 'o2',
        facilities: ['Wifi', 'Parking', 'Lift'],
        createdAt: DateTime.now(),
      ),
    ];
  }
}
