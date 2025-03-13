import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/core/errors/failure.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/services/long_term_stock_service.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/usecases/get_long_term_stocks_usecase.dart';

part 'long_term_event.dart';
part 'long_term_state.dart';

class LongTermBloc extends Bloc<LongTermEvent, LongTermState> {
  final GetLongTermStocksUsecase _getLongTermStocksUsecase;
  final LongTermStockService _longTermStockService;

  final Map<String, List<LongTermStock>> _longTermStocks = {};

  LongTermBloc({
    required GetLongTermStocksUsecase getLongTermStocksUsecase,
    required LongTermStockService longTermStockService,
  })  : _getLongTermStocksUsecase = getLongTermStocksUsecase,
        _longTermStockService = longTermStockService,
        super(LongTermInitialState()) {
    on<LongTermEvent>(_emitLoader);
    on<GetLongTermStockListEvent>(_getLongTermStocksHandler);
  }

  Future<void> _getLongTermStocksHandler(
      GetLongTermStockListEvent event, Emitter<LongTermState> emit) async {
    try {
      final result = await _getLongTermStocksUsecase.call(
          GetLongTermStocksUsecaseParams(
              isHistorical: event.isHistorical, page: event.page));
      result.fold(
        (left) => emit(LongTermFailedState(left.errorMessgae)),
        (longTermStocks) {
          if (event.page == 0) {
            _longTermStocks.clear();
          }
          Map<String, List<LongTermStock>> mappedStock =
              _longTermStockService.mapToDateTimeStocks(longTermStocks);
          _longTermStocks.addAll(mappedStock);
          emit(LongTermListLoaded(_longTermStocks));
        },
      );
    } catch (e) {
      throw ApiFailure(message: "$e", errorCode: -1);
    }
  }

  Future<void> _emitLoader(
      LongTermEvent event, Emitter<LongTermState> emit) async {
    await Future.delayed(const Duration(milliseconds: 500));
    emit(LongTermLoadingState());
  }
}
