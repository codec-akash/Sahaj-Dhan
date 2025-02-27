import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sahaj_dhan/core/errors/failure.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/usecases/get_stockslist_usecase.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/bloc/stocks_bloc.dart';

class MockGetStocks extends Mock implements GetStocksList {}

void main() {
  late GetStocksList getStocksList;
  late StocksBloc stocksBloc;

  const ApiFailure apiFailure =
      ApiFailure(message: "something went wrong", errorCode: 505);

  setUp(() {
    getStocksList = MockGetStocks();
    stocksBloc = StocksBloc(getStockList: getStocksList);
  });

  tearDown(() => stocksBloc.close());

  group("stocks bloc unit test", () {
    test("Initial state should be [Stocks Initial]", () async {
      expect(stocksBloc.state, StockInitialState());
    });

    blocTest<StocksBloc, StocksState>(
      "should emit [StocksLoading, StocksLoaded] when success",
      build: () {
        when(() => getStocksList()).thenAnswer((_) async => const Right([]));
        return stocksBloc;
      },
      act: (bloc) => bloc.add(GetStockListEvent()),
      expect: () => [
        StocksLoadingState(),
        StocksListLoaded(stocks: const []),
      ],
      verify: (bloc) {
        verify(() => getStocksList()).called(1);
        verifyNoMoreInteractions(getStocksList);
      },
    );

    blocTest(
      "should emit [StocksLoading, StocksFailure] when failed",
      build: () {
        when(() => getStocksList.call())
            .thenAnswer((_) async => const Left(apiFailure));
        return stocksBloc;
      },
      act: (bloc) => bloc.add(GetStockListEvent()),
      expect: () => [
        StocksLoadingState(),
        StocksFailure(message: apiFailure.errorMessgae)
      ],
      verify: (bloc) {
        verify(() => getStocksList()).called(1);
        verifyNoMoreInteractions(getStocksList);
      },
    );
  });
}
