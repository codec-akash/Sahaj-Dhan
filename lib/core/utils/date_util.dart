import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateTime dateMonthYear(String val) {
    return DateFormat('dd/MM/YYYY').parse(val);
  }

  static String formatDateToReadable(String dateStr) {
    final date = DateTime.parse(dateStr);
    return DateFormat('d\'${_getDayOfMonthSuffix(date.day)}\' MMM yyyy')
        .format(date);
  }

  static String _getDayOfMonthSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
