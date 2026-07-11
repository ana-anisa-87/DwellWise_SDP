import 'package:flutter/material.dart';
import '../services/auth_service.dart';

/// Provider handling global Authentication status and state changes.
class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  
  AppAuthUser? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  AppAuthUser? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  AuthProvider();

  /// Attempts user login.
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();
    try {
      _currentUser = await _authService.signInWithEmail(email, password);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Registers user account.
  Future<bool> register(String email, String password) async {
    _setLoading(true);
    _clearError();
    try {
      _currentUser = await _authService.registerWithEmail(email, password);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Verification OTP code sent to user phone.
  Future<void> sendOtp(String phoneNumber, Function(String, int?) codeSent) async {
    _setLoading(true);
    try {
      await _authService.sendOtpToPhone(phoneNumber, codeSent);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Sign out current user session.
  Future<void> logout() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void _setError(String msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
