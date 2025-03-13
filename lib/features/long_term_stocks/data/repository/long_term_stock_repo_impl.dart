import 'package:dartz/dartz.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';
import 'package:sahaj_dhan/core/errors/failure.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/long_term_stocks/data/datasource/lts_remote_data_source.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/repositories/long_term_stocks_repo.dart';

class LongTermStockRepoImpl implements LongTermStocksRepo {
  final LongTermStocksRemoteDataSource _longTermStocksRemoteDataSource;

  const LongTermStockRepoImpl(
      {required LongTermStocksRemoteDataSource longTermStocksRemoteDataSource})
      : _longTermStocksRemoteDataSource = longTermStocksRemoteDataSource;

  @override
  FutureResult<List<LongTermStocks>> getLongTermStocksList(
      {required bool isHistorical, required int page}) async {
    try {
      List<LongTermStocks> longTermStocks =
          await _longTermStocksRemoteDataSource.getLongTermStocks(
              isHistoric: isHistorical, page: page);

      return Right(longTermStocks);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExpection(e));
    }
  }
}
