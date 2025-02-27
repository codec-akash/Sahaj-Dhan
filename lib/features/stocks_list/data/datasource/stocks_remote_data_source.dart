import 'package:dio/dio.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';
import 'package:sahaj_dhan/core/network/network_helper.dart';
import 'package:sahaj_dhan/core/pagination/model/pagination_response.dart';
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
      final Response response =
          await _apiHelper.execute(method: Method.get, url: ApiUrl.stockList);

      if (response.data != null) {
        var responseData = (response.data);

        PaginatedResponse<StockModel> paginatedResponse =
            PaginatedResponse.fromJson(
                responseData, (json) => StockModel.fromJson(json));
        return paginatedResponse.data;
      }
      return [];
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: "something went wrong $e", errorCode: 505);
    }
  }
}
