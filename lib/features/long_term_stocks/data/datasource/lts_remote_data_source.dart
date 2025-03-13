import 'package:dio/dio.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';
import 'package:sahaj_dhan/core/network/network_helper.dart';
import 'package:sahaj_dhan/core/pagination/model/pagination_response.dart';
import 'package:sahaj_dhan/core/utils/urls.dart';
import 'package:sahaj_dhan/features/long_term_stocks/data/model/long_term_holding_model.dart';

abstract class LongTermStocksRemoteDataSource {
  Future<List<LongTermHoldingModel>> getLongTermStocks(
      {required bool isHistoric, required int page});
}

class LongTermStocksRemoteDataSourceImpl
    extends LongTermStocksRemoteDataSource {
  final ApiHelper _apiHelper;

  LongTermStocksRemoteDataSourceImpl(this._apiHelper);

  @override
  Future<List<LongTermHoldingModel>> getLongTermStocks(
      {required bool isHistoric, required int page}) async {
    try {
      final Response response = await _apiHelper.execute(
          method: Method.get,
          url: ApiUrl.longTermHolding,
          queryParameters: {
            "historical": isHistoric,
            "page": page,
          });

      if (response.data != null) {
        var responseData = response.data;

        PaginatedResponse<LongTermHoldingModel> paginatedResponse =
            PaginatedResponse.fromJson(
                responseData, (json) => LongTermHoldingModel.fromJson(json));

        return paginatedResponse.data;
      }
      return [];
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: "something went wrong $e", errorCode: -1);
    }
  }
}
