import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateTime dateMonthYear(String val) {
    return DateFormat('dd/MM/YYYY').parse(val);
  }

  static String yearMonthDateToString(DateTime val) {
    return DateFormat('yyyy-MM-dd').format(val);
  }

  static String dateFormat(DateTime val) {
    return DateFormat('MMM dd, yyyy').format(val);
  }

  static String dateFormatddMMYYYY(String val) {
    final parts = val.split('-');
    final day = parts[0];
    final month = parts[1].substring(0, 1).toUpperCase() +
        parts[1].substring(1).toLowerCase();
    final year = parts[2];
    DateTime formattedDate =
        DateFormat('dd-MMM-yyyy').parse('$day-$month-$year');
    return dateFormat(formattedDate);
  }
}
