import 'package:flutter/material.dart';
import '../models/property_model.dart';

/// Provider handling system moderation, approval pipelines, and reporting listings logs.
class AdminProvider with ChangeNotifier {
  final List<PropertyModel> _pendingListings = [];
  final List<PropertyModel> _reportedListings = [];
  bool _isLoading = false;

  List<PropertyModel> get pendingListings => _pendingListings;
  List<PropertyModel> get reportedListings => _reportedListings;
  bool get isLoading => _isLoading;

  /// Loads listings awaiting validation review.
  void fetchModerationQueues() {
    _isLoading = true;
    notifyListeners();

    _pendingListings.clear();
    _reportedListings.clear();

    // Load stubs
    _pendingListings.add(
      PropertyModel(
        id: 'p_pending_1',
        title: 'Unverified Studio Flat',
        description: 'New studio flat in Dhanmondi. Needs physical inspection.',
        price: 32000,
        area: 'Dhanmondi',
        address: 'Road 8A, Dhanmondi, Dhaka',
        latitude: 23.7461,
        longitude: 90.3742,
        beds: 1,
        baths: 1,
        sizeSqFt: 650,
        imageUrls: [],
        isVerified: false,
        ownerId: 'o3',
        facilities: ['Wifi'],
        createdAt: DateTime.now(),
      ),
    );

    _reportedListings.add(
      PropertyModel(
        id: 'p_reported_1',
        title: 'Dubious Duplex Listing',
        description: 'Reported for duplicate images and incorrect contact.',
        price: 90000,
        area: 'Uttara',
        address: 'Sector 4, Uttara, Dhaka',
        latitude: 23.8722,
        longitude: 90.3842,
        beds: 4,
        baths: 4,
        sizeSqFt: 2200,
        imageUrls: [],
        isVerified: true,
        ownerId: 'o4',
        facilities: ['Parking', 'Lift'],
        createdAt: DateTime.now(),
      ),
    );

    _isLoading = false;
    notifyListeners();
  }

  /// Sets listing verified indicator status.
  void approveListing(String propertyId) {
    _pendingListings.removeWhere((p) => p.id == propertyId);
    notifyListeners();
  }

  /// Discards / flags fraudulent property listings.
  void rejectListing(String propertyId) {
    _pendingListings.removeWhere((p) => p.id == propertyId);
    _reportedListings.removeWhere((p) => p.id == propertyId);
    notifyListeners();
  }
}
