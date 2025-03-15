import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';

class StocksService {
  Map<String, List<Stock>> mapToDateTimeStocks(List<Stock> stocks) {
    final Map<String, List<Stock>> mappedStocks = {};

    for (final stock in stocks) {
      final String dateKey = stock.date; // Get date part only

      if (!mappedStocks.containsKey(dateKey)) {
        mappedStocks[dateKey] = [];
      }

      mappedStocks[dateKey]!.add(stock);
    }

    return mappedStocks;
  }
}
