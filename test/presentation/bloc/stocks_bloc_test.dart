import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sahaj_dhan/core/errors/failure.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/services/stocks_service.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/usecases/get_filterlist_usecase.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/usecases/get_stockslist_usecase.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/bloc/stocks_bloc.dart';

class MockGetStocks extends Mock implements GetStocksList {}

class MockGetStockFilter extends Mock implements GetFilterlistUsecase {}

void main() {
  late GetStocksList getStocksList;
  late GetFilterlistUsecase getFilterlistUsecase;
  late StocksBloc stocksBloc;
  late StocksService stocksService;

  const ApiFailure apiFailure =
      ApiFailure(message: "something went wrong", errorCode: 505);

  setUp(() {
    getStocksList = MockGetStocks();
    getFilterlistUsecase = MockGetStockFilter();
    stocksService = StocksService();
    stocksBloc = StocksBloc(
      getStockList: getStocksList,
      getStockFilter: getFilterlistUsecase,
      stocksService: stocksService,
    );
  });

  tearDown(() => stocksBloc.close());

  group("stocks bloc unit test", () {
    test("Initial state should be [Stocks Initial]", () async {
      expect(stocksBloc.state, StockInitialState());
    });

    blocTest<StocksBloc, StocksState>(
      "should emit [StocksLoading, StocksLoaded] when success",
      build: () {
        when(() => getStocksList(0)).thenAnswer((_) async => const Right([]));
        return stocksBloc;
      },
      act: (bloc) => bloc.add(GetStockListEvent(page: 0)),
      expect: () => [
        StocksLoadingState(),
        StocksListLoaded(stocks: {}),
      ],
      verify: (bloc) {
        verify(() => getStocksList(0)).called(1);
        verifyNoMoreInteractions(getStocksList);
      },
    );

    blocTest(
      "should emit [StocksLoading, StocksFailure] when failed",
      build: () {
        when(() => getStocksList.call(0))
            .thenAnswer((_) async => const Left(apiFailure));
        return stocksBloc;
      },
      act: (bloc) => bloc.add(GetStockListEvent(page: 0)),
      expect: () => [
        StocksLoadingState(),
        StocksFailure(message: apiFailure.errorMessgae)
      ],
      verify: (bloc) {
        verify(() => getStocksList(0)).called(1);
        verifyNoMoreInteractions(getStocksList);
      },
    );
  });
}
