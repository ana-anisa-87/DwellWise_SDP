import 'package:intl/intl.dart';

/// Utility class for formatting currency and date values.
class Formatters {
  Formatters._();

  /// Formats double values to BDT currency string representation.
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'bn_BD',
      symbol: '৳',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// Formats date values to simplified localized strings.
  static String formatDate(DateTime date) {
    return DateFormat.yMMMMd().format(date);
  }

  /// Formats relative time logs (e.g. 2 hours ago).
  static String formatRelativeTime(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 7) {
      return formatDate(date);
    } else if (diff.inDays > 0) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
