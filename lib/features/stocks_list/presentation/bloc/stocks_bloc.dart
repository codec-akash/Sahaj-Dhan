import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/core/errors/failure.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/filter.dart';

import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/services/stocks_service.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/usecases/get_filterlist_usecase.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/usecases/get_stockslist_usecase.dart';

part 'stocks_event.dart';
part 'stocks_state.dart';

class StocksBloc extends Bloc<StocksEvent, StocksState> {
  final GetStocksList _getStocksList;
  final GetFilterlistUsecase _getStockFilter;
  final StocksService _stocksService;
  final Map<String, List<Stock>> _stocks = {};

  StocksBloc({
    required GetStocksList getStockList,
    required GetFilterlistUsecase getStockFilter,
    required StocksService stocksService,
  })  : _getStocksList = getStockList,
        _getStockFilter = getStockFilter,
        _stocksService = stocksService,
        super(StockInitialState()) {
    on<StocksEvent>(_emitLoader);
    on<GetStockListEvent>(_getStocksListHandler);
    on<GetStockFilter>(_getStockFilterHandler);
  }

  Future<void> _getStocksListHandler(
      GetStockListEvent event, Emitter<StocksState> emit) async {
    final result = await _getStocksList.call(event.page);
    try {
      result.fold(
        (left) => emit(StocksFailure(
          message: left.errorMessgae,
          event: event,
        )),
        (stocks) {
          if (event.page == 0) {
            _stocks.clear();
          }
          Map<String, List<Stock>> mappedStock =
              _stocksService.mapToDateTimeStocks(stocks);
          _stocks.addAll(mappedStock);
          emit(StocksListLoaded(stocks: _stocks));
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      throw ApiFailure(message: "$e", errorCode: -1);
    }
  }

  Future<void> _getStockFilterHandler(
      GetStockFilter event, Emitter<StocksState> emit) async {
    final result = await _getStockFilter();
    result.fold(
      (left) => emit(StocksFailure(
        message: left.errorMessgae,
        event: event,
      )),
      (filter) => emit(StockFilterLoaded(filter)),
    );
  }

  Future<void> _emitLoader(StocksEvent event, Emitter<StocksState> emit) async {
    await Future.delayed(const Duration(milliseconds: 500));
    emit(StocksLoadingState());
  }
}
