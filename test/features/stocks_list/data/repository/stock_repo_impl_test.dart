import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';
import 'package:sahaj_dhan/core/errors/failure.dart';
import 'package:sahaj_dhan/features/stocks_list/data/datasource/stocks_remote_data_source.dart';
import 'package:sahaj_dhan/features/stocks_list/data/repository/stock_repo_impl.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';

class MockStockRemoteDataSource extends Mock
    implements StocksRemoteDataSource {}

void main() {
  late StocksRemoteDataSource remoteDataSource;
  late StockRepoImpl stockRepoImpl;

  setUp(() {
    remoteDataSource = MockStockRemoteDataSource();
    stockRepoImpl = StockRepoImpl(stocksRemoteDataSource: remoteDataSource);
  });

  const tException = ApiException(
    message: "Something went wrong",
    errorCode: 505,
  );

  group("getStockList", () {
    test(
        "should call [RemoteDataSource.getStockList] and return [List<Stocks>] when success",
        () async {
      when(() => remoteDataSource.getStocksList()).thenAnswer((_) async => []);

      final result = await stockRepoImpl.getStocksList();

      expect(result, isA<Right<dynamic, List<Stock>>>());
      verify(() => remoteDataSource.getStocksList()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test("should return [APIFailure] when call to the remote fails", () async {
      when(() => remoteDataSource.getStocksList()).thenThrow(tException);

      final result = await stockRepoImpl.getStocksList();

      expect(
          result,
          equals(Left(ApiFailure(
              message: tException.message, errorCode: tException.errorCode))));
      verify(() => remoteDataSource.getStocksList()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
