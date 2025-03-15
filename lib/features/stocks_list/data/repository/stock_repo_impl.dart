import 'package:dartz/dartz.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';
import 'package:sahaj_dhan/core/errors/failure.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/stocks_list/data/datasource/stocks_remote_data_source.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/filter.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/repositories/stock_repository.dart';

class StockRepoImpl implements StocksRepository {
  final StocksRemoteDataSource _stocksRemoteDataSource;

  const StockRepoImpl({required StocksRemoteDataSource stocksRemoteDataSource})
      : _stocksRemoteDataSource = stocksRemoteDataSource;

  @override
  FutureResult<List<Stock>> getStocksList({required int page}) async {
    try {
      List<Stock> stocksList =
          await _stocksRemoteDataSource.getStocksList(page: page);
      return Right(stocksList);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExpection(e));
    }
  }

  @override
  FutureResult<Filter> getStockFilter() async {
    try {
      Filter filter = await _stocksRemoteDataSource.getStockFilter();
      return Right(filter);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExpection(e));
    }
  }
}
