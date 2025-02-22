import 'dart:convert';
import 'package:sahaj_dhan/core/errors/exceptions.dart';
import 'package:sahaj_dhan/core/network/network_helper.dart';
import 'package:sahaj_dhan/core/utils/urls.dart';
import 'package:sahaj_dhan/features/stocks_list/data/models/stock_model.dart';

abstract class StocksRemoteDataSource {
  Future<List<StockModel>> getStocksList();
}

class StocksRemoteDataSourceImpl implements StocksRemoteDataSource {
  final ApiHelper _apiHelper;

  const StocksRemoteDataSourceImpl(this._apiHelper);

  @override
  Future<List<StockModel>> getStocksList() async {
    try {
      late List<StockModel> stocks;

      final response =
          await _apiHelper.execute(method: Method.get, url: ApiUrl.stockList);

      if (response.data != null) {
        var responseData = jsonDecode(response.data);
        stocks = (responseData as List)
            .map((element) => StockModel.fromJson(element))
            .toList();
        return stocks;
      }
      return [];
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(message: "something went wrong", errorCode: 505);
    }
  }
}
