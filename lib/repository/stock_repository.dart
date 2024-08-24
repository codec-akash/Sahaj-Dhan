import 'package:sahaj_dhan/models/deal_filter_model.dart';
import 'package:sahaj_dhan/models/stock_deal_model.dart';
import 'package:sahaj_dhan/network/api_provider.dart';
import 'package:sahaj_dhan/utils/strings.dart';

class StockRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<List<Deal>> getStockDealList() async {
    List<Deal> stockDealList = [];
    var response = await apiProvider.get(ApiUrls.getBulkDeals);

    try {
      if (response['result']['result'] != null) {
        StockDeals stockDeals = StockDeals.fromJson(response['result']);
        stockDealList = stockDeals.result ?? [];
      }

      return stockDealList;
    } catch (e) {
      rethrow;
    }
  }

  Future<StockDeals> getStockDealListPaginated(int skip) async {
    var response = await apiProvider.get(ApiUrls.getBulkDeals, queryParam: {
      "skip": skip,
      "limit": 20,
    });

    try {
      if (response['result'] != null) {
        StockDeals stockDeals = StockDeals.fromJson(response['result']);
        return stockDeals;
      } else {
        throw response['error'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<SymbolFilter> loadDealFilter() async {
    var response = await apiProvider.get(ApiUrls.getDealsFilter);

    try {
      if (response['error'] != null) {
        throw response['error'];
      }

      SymbolFilter dealFilter = SymbolFilter.fromJson(response['result'][0]);

      return dealFilter;
    } catch (e) {
      rethrow;
    }
  }
}
