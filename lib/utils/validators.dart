/// Utility class containing form validators.
class Validators {
  Validators._();

  /// Validates standard email addresses.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required.';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  /// Validates password strength length.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  }

  /// Validates Bangladeshi phone numbers.
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required.';
    }
    // Matches +8801XXXXXXXXX or 01XXXXXXXXX format
    final phoneRegex = RegExp(r'^(?:\+88)?01[3-9]\d{8}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid Bangladeshi phone number.';
    }
    return null;
  }
}
