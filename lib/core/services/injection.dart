import 'package:get_it/get_it.dart';
import 'package:sahaj_dhan/core/network/api_client.dart';
import 'package:sahaj_dhan/core/network/network_helper.dart';
import 'package:sahaj_dhan/features/stocks_list/data/datasource/stocks_remote_data_source.dart';
import 'package:sahaj_dhan/features/stocks_list/data/repository/stock_repo_impl.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/repositories/stock_repository.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/usecases/get_stockslist_usecase.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/bloc/stocks_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  di
    ..registerFactory(() => StocksBloc(getStockList: di()))
    ..registerLazySingleton(() => GetStocksList(stockRepo: di()))
    ..registerLazySingleton<StocksRepository>(
        () => StockRepoImpl(stocksRemoteDataSource: di()))
    ..registerLazySingleton<StocksRemoteDataSource>(
        () => StocksRemoteDataSourceImpl(di()))
    ..registerLazySingleton(() => ApiHelper(di()))
    ..registerSingleton<ApiClient>(ApiClient());
}
