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
    DateTime formattedDate = DateFormat('dd-MMM-yyyy').parse(val);
    return dateFormat(formattedDate);
  }
}
