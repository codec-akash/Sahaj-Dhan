class NumberUtils {
  static String addIndianCommas(num number) {
    String numStr = number.toString();

    // Handle decimal numbers
    List<String> parts = numStr.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

    // Handle negative numbers
    bool isNegative = integerPart.startsWith('-');
    if (isNegative) {
      integerPart = integerPart.substring(1);
    }

    // Add commas
    int len = integerPart.length;
    String result = '';

    for (int i = 0; i < len; i++) {
      if (i == 0) {
        result = integerPart[len - 1 - i];
      } else if (i == 1 || i == 2) {
        result = '${integerPart[len - 1 - i]}$result';
      } else {
        if ((i - 2) % 2 == 1) {
          result = '${integerPart[len - 1 - i]},$result';
        } else {
          result = '${integerPart[len - 1 - i]}$result';
        }
      }
    }

    return '${isNegative ? '-' : ''}$result$decimalPart';
  }
}
