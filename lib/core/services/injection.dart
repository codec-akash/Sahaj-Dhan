import 'package:get_it/get_it.dart';
import 'package:sahaj_dhan/core/network/api_client.dart';
import 'package:sahaj_dhan/core/network/network_helper.dart';
import 'package:sahaj_dhan/features/long_term_stocks/data/datasource/lts_remote_data_source.dart';
import 'package:sahaj_dhan/features/long_term_stocks/data/repository/long_term_stock_repo_impl.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/repositories/long_term_stocks_repo.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/usecases/get_long_term_stocks_usecase.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/bloc/long_term_bloc.dart';
import 'package:sahaj_dhan/features/stocks_list/data/datasource/stocks_remote_data_source.dart';
import 'package:sahaj_dhan/features/stocks_list/data/repository/stock_repo_impl.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/repositories/stock_repository.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/services/stocks_service.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/usecases/get_filterlist_usecase.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/usecases/get_stockslist_usecase.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/bloc/stocks_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  di
    ..registerFactory(() => StocksBloc(
          getStockList: di(),
          getStockFilter: di(),
          stocksService: di(),
        ))
    ..registerLazySingleton(() => GetStocksList(stockRepo: di()))
    ..registerLazySingleton(() => GetFilterlistUsecase(stocksRepository: di()))
    ..registerLazySingleton(() => StocksService())
    ..registerLazySingleton<StocksRepository>(
        () => StockRepoImpl(stocksRemoteDataSource: di()))
    ..registerLazySingleton<StocksRemoteDataSource>(
        () => StocksRemoteDataSourceImpl(di()))
    ..registerLazySingleton(() => ApiHelper(di()))
    ..registerSingleton<ApiClient>(ApiClient());

  di
    ..registerFactory(() => LongTermBloc(getLongTermStocksUsecase: di()))
    ..registerLazySingleton(() => GetLongTermStocksUsecase(di()))
    ..registerLazySingleton<LongTermStocksRepo>(
        () => LongTermStockRepoImpl(longTermStocksRemoteDataSource: di()))
    ..registerLazySingleton<LongTermStocksRemoteDataSource>(
        () => LongTermStocksRemoteDataSourceImpl(di()));
}
