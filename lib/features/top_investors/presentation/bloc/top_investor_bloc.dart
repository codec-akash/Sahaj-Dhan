import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/top_investor.dart';
import 'package:sahaj_dhan/features/top_investors/domain/usercases/get_top_investor_usecase.dart';

part 'top_investor_state.dart';
part 'top_investor_event.dart';

class TopInvestorBloc extends Bloc<TopInvestorEvent, TopInvestorState> {
  final GetTopInvestorUsecase _getTopInvestorUsecase;

  TopInvestorBloc({
    required GetTopInvestorUsecase topInvestorUsecase,
  })  : _getTopInvestorUsecase = topInvestorUsecase,
        super(TopInvestorInitialState()) {
    on<TopInvestorEvent>(_emitLoader);
    on<LoadTopInvestors>(_getTopInvestorListHandler);
  }

  Future<void> _getTopInvestorListHandler(
      LoadTopInvestors event, Emitter<TopInvestorState> emit) async {
    final result = await _getTopInvestorUsecase.call();

    result.fold((left) => emit(TopInvestorFailedState(left.errorMessgae)),
        (topInvestor) => emit(TopInvestorLoadedState(topInvestor)));
  }

  Future<void> _emitLoader(
      TopInvestorEvent event, Emitter<TopInvestorState> emit) async {
    emit(TopInvestorLoadingState(topInvestorEvent: event));
  }
}
