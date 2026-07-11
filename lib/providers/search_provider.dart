import 'package:flutter/material.dart';
import '../models/property_model.dart';

/// Provider handling search query values, category filter chips and budget range selections.
class SearchProvider with ChangeNotifier {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  RangeValues _priceRange = const RangeValues(10000, 150000);
  int _selectedBeds = 0;

  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  RangeValues get priceRange => _priceRange;
  int get selectedBeds => _selectedBeds;

  /// Updates text query parameters.
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Sets active listing filter category.
  void updateCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  /// Updates range bounds.
  void updatePriceRange(RangeValues range) {
    _priceRange = range;
    notifyListeners();
  }

  /// Updates bedroom count constraints.
  void updateBeds(int beds) {
    _selectedBeds = beds;
    notifyListeners();
  }

  /// Resets filter inputs back to defaults.
  void resetFilters() {
    _searchQuery = '';
    _selectedCategory = 'All';
    _priceRange = const RangeValues(10000, 150000);
    _selectedBeds = 0;
    notifyListeners();
  }

  /// Filters property list based on user selections.
  List<PropertyModel> filterListings(List<PropertyModel> source) {
    return source.where((p) {
      final matchesQuery = _searchQuery.isEmpty ||
          p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.area.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesCategory = _selectedCategory == 'All' || 
          p.facilities.any((f) => f.toLowerCase() == _selectedCategory.toLowerCase()) ||
          p.description.toLowerCase().contains(_selectedCategory.toLowerCase());

      final matchesPrice = p.price >= _priceRange.start && p.price <= _priceRange.end;
      final matchesBeds = _selectedBeds == 0 || p.beds == _selectedBeds;

      return matchesQuery && matchesCategory && matchesPrice && matchesBeds;
    }).toList();
  }
}
