import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/core/errors/failure.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/usecases/get_long_term_stocks_usecase.dart';

part 'long_term_event.dart';
part 'long_term_state.dart';

class LongTermBloc extends Bloc<LongTermEvent, LongTermState> {
  final GetLongTermStocksUsecase _getLongTermStocksUsecase;

  LongTermBloc({
    required GetLongTermStocksUsecase getLongTermStocksUsecase,
  })  : _getLongTermStocksUsecase = getLongTermStocksUsecase,
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
        (longTermStocks) => emit(LongTermListLoaded(longTermStocks)),
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
