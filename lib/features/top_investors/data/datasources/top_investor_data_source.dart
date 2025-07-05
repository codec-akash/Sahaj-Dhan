import 'package:dio/dio.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';
import 'package:sahaj_dhan/core/network/network_helper.dart';
import 'package:sahaj_dhan/core/utils/urls.dart';
import 'package:sahaj_dhan/features/top_investors/data/model/investor_holding_model.dart';
import 'package:sahaj_dhan/features/top_investors/data/model/top_investor_model.dart';

abstract class TopInvestorDataSource {
  Future<List<TopInvestorModel>> getTopInvestors();

  Future<InvestorHoldingModel> getInvestorHoldings(String clientName,
      {String? holdingType});

  Future<List<TopInvestorModel>> getStocksHoldingInvestors(String stockName);
}

class TopInvestorDataSourceImpl implements TopInvestorDataSource {
  final ApiHelper _apiHelper;

  const TopInvestorDataSourceImpl({required ApiHelper apihelper})
      : _apiHelper = apihelper;

  @override
  Future<List<TopInvestorModel>> getTopInvestors() async {
    try {
      final Response response = await _apiHelper.execute(
          method: Method.get, url: ApiUrl.topInvestors);

      if (response.data != null) {
        var responseData = response.data;

        List<TopInvestorModel> topInvestor = (responseData['data'] as List)
            .map((elementJson) => TopInvestorModel.fromJson(elementJson))
            .toList();

        return topInvestor;
      }
      return [];
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: "something went wrong $e", errorCode: -1);
    }
  }

  @override
  Future<InvestorHoldingModel> getInvestorHoldings(String clientName,
      {String? holdingType}) async {
    try {
      final Response response = await _apiHelper.execute(
          method: Method.get,
          url: ApiUrl.investorHolding(clientName),
          queryParameters: {"holding": holdingType});

      if (response.data != null) {
        var responseData = response.data;

        InvestorHoldingModel investorHoldingModel =
            InvestorHoldingModel.fromJson(responseData);

        return investorHoldingModel;
      }
      throw ApiException(message: "No Data", errorCode: -1);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: "something went wrong $e", errorCode: -1);
    }
  }

  @override
  Future<List<TopInvestorModel>> getStocksHoldingInvestors(
      String stockName) async {
    try {
      final Response response = await _apiHelper.execute(
          method: Method.get,
          url: ApiUrl.investor,
          queryParameters: {'stock-name': stockName});

      if (response.data != null) {
        var responseData = response.data;

        List<TopInvestorModel> topInvestor = (responseData['data'] as List)
            .map((elementJson) => TopInvestorModel.fromJson(elementJson))
            .toList();

        return topInvestor;
      }
      throw ApiException(message: "No Data", errorCode: -1);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: "something went wrong $e", errorCode: -1);
    }
  }
}
