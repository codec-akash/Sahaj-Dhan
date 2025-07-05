import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/investor_holding.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/top_investor.dart';
import 'package:sahaj_dhan/features/top_investors/domain/usercases/get_investor_holdings.dart';
import 'package:sahaj_dhan/features/top_investors/domain/usercases/get_top_investor_usecase.dart';
import 'package:sahaj_dhan/features/top_investors/domain/usercases/get_stocks_holding_investors.dart';

part 'top_investor_state.dart';
part 'top_investor_event.dart';

class TopInvestorBloc extends Bloc<TopInvestorEvent, TopInvestorState> {
  final GetTopInvestorUsecase _getTopInvestorUsecase;
  final GetInvestorHoldings _getInvestorHoldings;
  final GetStocksHoldingInvestorsUsecase _getStocksHoldingInvestors;
  TopInvestorBloc({
    required GetTopInvestorUsecase topInvestorUsecase,
    required GetInvestorHoldings getInvestorHoldings,
    required GetStocksHoldingInvestorsUsecase getStocksHoldingInvestors,
  })  : _getTopInvestorUsecase = topInvestorUsecase,
        _getInvestorHoldings = getInvestorHoldings,
        _getStocksHoldingInvestors = getStocksHoldingInvestors,
        super(TopInvestorInitialState()) {
    on<TopInvestorEvent>(_emitLoader);
    on<LoadTopInvestors>(_getTopInvestorListHandler);
    on<LoadInvestorHoldings>(_getInvestorHoldindsHandler);
    on<LoadStocksHoldingInvestors>(_getStocksHoldingInvestorsHandler);
  }

  Future<void> _emitLoader(
      TopInvestorEvent event, Emitter<TopInvestorState> emit) async {
    emit(TopInvestorLoadingState(topInvestorEvent: event));
  }

  Future<void> _getTopInvestorListHandler(
      LoadTopInvestors event, Emitter<TopInvestorState> emit) async {
    final result = await _getTopInvestorUsecase.call();

    result.fold(
        (left) => emit(TopInvestorFailedState(left.errorMessgae, event)),
        (topInvestor) => emit(TopInvestorLoadedState(topInvestor)));
  }

  Future<void> _getInvestorHoldindsHandler(
      LoadInvestorHoldings event, Emitter<TopInvestorState> emit) async {
    final result = await _getInvestorHoldings.call(GetInvestorHoldingsParams(
        event.clientName,
        holdingType: event.holdingType));

    result.fold(
        (left) => emit(TopInvestorFailedState(left.errorMessgae, event)),
        (investorHoldings) => emit(InvestorHoldingLoaded(investorHoldings)));
  }

  Future<void> _getStocksHoldingInvestorsHandler(
      LoadStocksHoldingInvestors event, Emitter<TopInvestorState> emit) async {
    final result = await _getStocksHoldingInvestors.call(event.stockName);

    result.fold(
        (left) => emit(TopInvestorFailedState(left.errorMessgae, event)),
        (stocksHoldingInvestors) => emit(StocksHoldingInvestorsLoaded(
            stocksHoldingInvestors: stocksHoldingInvestors)));
  }
}
