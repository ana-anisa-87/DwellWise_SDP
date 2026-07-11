/// Lightweight authenticated user representation used by the app.
class AppAuthUser {
  AppAuthUser({required this.email});

  final String email;
}

/// Service handler for local authentication stubs.
class AuthService {
  /// Authenticates user credentials using email/password.
  Future<AppAuthUser?> signInWithEmail(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw ArgumentError('Email and password are required.');
    }
    return AppAuthUser(email: email);
  }

  /// Registers user account with email and password credentials.
  Future<AppAuthUser?> registerWithEmail(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw ArgumentError('Email and password are required.');
    }
    return AppAuthUser(email: email);
  }

  /// Verification OTP code sent to user phone.
  Future<void> sendOtpToPhone(String phoneNumber, Function(String, int?) codeSent) async {
    if (phoneNumber.isEmpty) {
      throw ArgumentError('Phone number is required.');
    }
  }

  /// Submits verification OTP token.
  Future<AppAuthUser?> verifyOtp(String verificationId, String smsCode) async {
    if (verificationId.isEmpty || smsCode.isEmpty) {
      throw ArgumentError('Verification id and sms code are required.');
    }
    return AppAuthUser(email: 'otp-user@$verificationId');
  }

  /// Sign out current user.
  Future<void> signOut() async {
    return;
  }
}
