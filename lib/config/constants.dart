/// App-wide constants for DwellWise.
class AppConstants {
  AppConstants._();

  static const String appName = 'DwellWise';
  static const String appVersion = '1.0.0';

  // Supabase keys / endpoints placeholder
  static const String supabaseUrl = 'https://your-project.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key';

  // Shared preferences keys
  static const String keyUserToken = 'user_token';
  static const String keyThemeMode = 'theme_mode';
  static const String keyIsOnboarded = 'is_onboarded';

  // API Endpoints or other config constants
  static const int apiTimeoutSeconds = 30;
}
