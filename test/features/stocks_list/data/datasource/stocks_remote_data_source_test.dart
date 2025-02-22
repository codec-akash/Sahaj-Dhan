import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';
import 'package:sahaj_dhan/core/network/network_helper.dart';
import 'package:sahaj_dhan/core/utils/urls.dart';
import 'package:sahaj_dhan/features/stocks_list/data/datasource/stocks_remote_data_source.dart';
import 'package:sahaj_dhan/features/stocks_list/data/models/stock_model.dart';

class MockClient extends Mock implements ApiHelper {}

void main() {
  late ApiHelper apiHelper;
  late StocksRemoteDataSource stocksRemoteDataSource;

  setUp(() {
    apiHelper = MockClient();
    stocksRemoteDataSource = StocksRemoteDataSourceImpl(apiHelper);
  });
  group("getStockList", () {
    final tStocks = [const StockModel.empty()];
    test("should return [List<User>] when status code is 200 || 201", () async {
      // arrange
      when(
        () => apiHelper.execute(method: Method.get, url: any(named: "url")),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: jsonEncode([tStocks.first.toJson()]),
        ),
      );

      // act
      final result = await stocksRemoteDataSource.getStocksList();

      //assert --
      expect(result, equals(tStocks));
      verify(() => apiHelper.execute(method: Method.get, url: ApiUrl.stockList))
          .called(1);
      verifyNoMoreInteractions(apiHelper);
    });

    const ApiException apiException =
        ApiException(message: "Not Found: ", errorCode: 404);
    test("should throw [NotFoundException] when status code is 404", () async {
      // arrange
      when(
        () => apiHelper.execute(method: Method.get, url: any(named: "url")),
      ).thenThrow(apiException);

      // act
      final call = stocksRemoteDataSource.getStocksList;

      // assert
      expect(() => call(), throwsA(equals(apiException)));
      verify(() => apiHelper.execute(method: Method.get, url: ApiUrl.stockList))
          .called(1);
      verifyNoMoreInteractions(apiHelper);
    });
  });
}
