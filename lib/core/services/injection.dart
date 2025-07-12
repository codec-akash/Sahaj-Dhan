import 'package:get_it/get_it.dart';
import 'package:sahaj_dhan/core/network/api_client.dart';
import 'package:sahaj_dhan/core/network/network_helper.dart';
import 'package:sahaj_dhan/features/long_term_stocks/data/datasource/lts_remote_data_source.dart';
import 'package:sahaj_dhan/features/long_term_stocks/data/repository/long_term_stock_repo_impl.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/repositories/long_term_stocks_repo.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/services/long_term_stock_service.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/usecases/get_long_term_stocks_usecase.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/bloc/long_term_bloc.dart';
import 'package:sahaj_dhan/features/stocks_list/data/datasource/stocks_remote_data_source.dart';
import 'package:sahaj_dhan/features/stocks_list/data/repository/stock_repo_impl.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/repositories/stock_repository.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/services/stocks_service.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/usecases/get_filterlist_usecase.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/usecases/get_stockslist_usecase.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/bloc/stocks_bloc.dart';
import 'package:sahaj_dhan/features/top_investors/data/datasources/top_investor_data_source.dart';
import 'package:sahaj_dhan/features/top_investors/data/repository/top_investor_repo_impl.dart';
import 'package:sahaj_dhan/features/top_investors/domain/repositories/top_investor_repo.dart';
import 'package:sahaj_dhan/features/top_investors/domain/usercases/get_investor_holdings.dart';
import 'package:sahaj_dhan/features/top_investors/domain/usercases/get_stocks_holding_investors.dart';
import 'package:sahaj_dhan/features/top_investors/domain/usercases/get_top_investor_usecase.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/bloc/top_investor_bloc.dart';
import 'package:sahaj_dhan/core/navigation/navigation_service.dart';

import '../../features/app_update/data/datasource/android_update_source.dart';
import '../../features/app_update/data/datasource/update_data_source.dart';
import '../../features/app_update/data/repository/update_repository_impl.dart';
import '../../features/app_update/domain/repositories/update_repository.dart';
import '../../features/app_update/domain/usecases/check_update_usecase.dart';
import '../../features/app_update/domain/usecases/start_update_usecase.dart';
import '../../features/app_update/presentation/bloc/update_bloc.dart';

final di = GetIt.instance;

void setupUpdateFeature() {
  // Data Sources
  di.registerLazySingleton<UpdateDataSource>(
    () => AndroidUpdateDataSource(),
  );

  // Repositories
  di.registerLazySingleton<UpdateRepository>(
    () => UpdateRepositoryImpl(di()),
  );

  // Use Cases
  di.registerLazySingleton(() => CheckUpdateUseCase(di()));
  di.registerLazySingleton(() => StartUpdateUseCase(di()));

  // BLoC
  di.registerFactory(
    () => UpdateBloc(
      checkUpdateUseCase: di(),
      startUpdateUseCase: di(),
    ),
  );
}

Future<void> init() async {
  // * Stocks Trade Data
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

  // * Long Term Holding
  di
    ..registerFactory(() => LongTermBloc(
        getLongTermStocksUsecase: di(), longTermStockService: di()))
    ..registerLazySingleton(() => LongTermStockService())
    ..registerLazySingleton(() => GetLongTermStocksUsecase(di()))
    ..registerLazySingleton<LongTermStocksRepo>(
        () => LongTermStockRepoImpl(longTermStocksRemoteDataSource: di()))
    ..registerLazySingleton<LongTermStocksRemoteDataSource>(
        () => LongTermStocksRemoteDataSourceImpl(di()));

  // * Top Investors
  di
    ..registerFactory(() => TopInvestorBloc(
        topInvestorUsecase: di(),
        getInvestorHoldings: di(),
        getStocksHoldingInvestors: di()))
    ..registerLazySingleton(() => GetTopInvestorUsecase(di()))
    ..registerLazySingleton(() => GetInvestorHoldings(topInvestorRepo: di()))
    ..registerLazySingleton(
        () => GetStocksHoldingInvestorsUsecase(topInvestorRepo: di()))
    ..registerLazySingleton<TopInvestorRepo>(
        () => TopInvestorRepoImpl(topInvestorDataSource: di()))
    ..registerLazySingleton<TopInvestorDataSource>(
        () => TopInvestorDataSourceImpl(apihelper: di()));

  // Navigation
  di.registerLazySingleton<NavigationService>(() => NavigationServiceImpl());
  setupUpdateFeature();
}
