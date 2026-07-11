import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/property_model.dart';
import '../models/user_model.dart';

/// Service handler interfacing with Supabase DB client operations.
class SupabaseService {
  SupabaseClient? get _client {
    try {
      return Supabase.instance.client;
    } catch (_) {
      return null;
    }
  }

  /// Fetches all property listings from Database.
  Future<List<PropertyModel>> getProperties() async {
    // Stub: Fetch data from supabase table 'properties'
    try {
      // final response = await _client.from('properties').select();
      // return (response as List).map((p) => PropertyModel.fromJson(p)).toList();
      return [];
    } catch (e) {
      rethrow;
    }
  }

  /// Inserts a new property listing.
  Future<void> createProperty(PropertyModel property) async {
    // Stub: Insert property into database
    try {
      // await _client.from('properties').insert(property.toJson());
    } catch (e) {
      rethrow;
    }
  }

  /// Fetches profile of a user.
  Future<UserModel?> getUserProfile(String userId) async {
    // Stub: Fetch user profile
    try {
      // final response = await _client.from('users').select().eq('id', userId).maybeSingle();
      // return response != null ? UserModel.fromJson(response) : null;
      return null;
    } catch (e) {
      rethrow;
    }
  }

  /// Updates profile details in DB.
  Future<void> updateUserProfile(UserModel user) async {
    // Stub: Update user details
    try {
      // await _client.from('users').update(user.toJson()).eq('id', user.id);
    } catch (e) {
      rethrow;
    }
  }
}
