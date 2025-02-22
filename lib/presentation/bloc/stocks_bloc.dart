import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/usecases/get_stockslist_usecase.dart';

part './stocks_event.dart';
part './stocks_state.dart';

class StocksBloc extends Bloc<StocksEvent, StocksState> {
  final GetStocksList _getStocksList;

  StocksBloc({required GetStocksList getStockList})
      : _getStocksList = getStockList,
        super(StockInitialState()) {
    on<StocksEvent>(_emitLoader);
    on<GetStockListEvent>(_getStocksListHandler);
  }

  Future<void> _getStocksListHandler(
      GetStockListEvent event, Emitter<StocksState> emit) async {
    final result = await _getStocksList.call();
    result.fold(
      (left) => emit(StocksFailure(message: left.errorMessgae)),
      (stocks) => emit(StocksListLoaded(stocks: stocks)),
    );
  }

  Future<void> _emitLoader(StocksEvent event, Emitter<StocksState> emit) async {
    emit(StocksLoadingState());
  }
}
