import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_event.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_state.dart';
import 'package:sahaj_dhan/models/deal_filter_model.dart';
import 'package:sahaj_dhan/models/stock_deal_model.dart';
import 'package:sahaj_dhan/repository/stock_repository.dart';
import 'package:sahaj_dhan/utils/date_utils.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockRepository stockRepository = StockRepository();

  StockDeals? loadedStockDeals;
  Filters? filter;

  StockBloc() : super(Uninitialized()) {
    on<LoadStockDeals>(_loadStockDeals);
    on<LoadPaginationStockDeal>(_loadPaginatedStockDeals);
    on<LoadStockDealFilters>(_loadDealFilter);
  }

  Future<void> _loadStockDeals(
      LoadStockDeals event, Emitter<StockState> emit) async {
    try {
      emit(StockStateLoading(currentEvent: event));
      List<Deal> stockDeals = await stockRepository.getStockDealList();
      emit(StockDealsLoaded(stockDeals));
    } catch (e) {
      emit(StockStateFailed(currentEvent: event, errorMsg: e.toString()));
    }
  }

  Future<void> _loadPaginatedStockDeals(
      LoadPaginationStockDeal event, Emitter<StockState> emit) async {
    try {
      StockDeals stockDeals = StockDeals(result: []);
      if (event.hasNextPage) {
        emit(StockStateLoading(currentEvent: event));
        stockDeals = await stockRepository.getStockDealListPaginated(
          event.page,
          tradeType: event.tradeTypes,
          symbolName: event.symbolName,
          clientName: event.clientName,
          executedDate: event.executedAt != null
              ? DateTimeUtils.yearMonthDateToString(event.executedAt!)
              : null,
          endDate: event.endDate != null
              ? DateTimeUtils.yearMonthDateToString(event.endDate!)
              : null,
        );

        if (loadedStockDeals == null) {
          loadedStockDeals = stockDeals;
        } else {
          loadedStockDeals!.result!.addAll(stockDeals.result!);
          loadedStockDeals!.hasNextPage = stockDeals.hasNextPage;
        }
      }

      emit(PaginatedStockDealsLoaded(stockDeals: stockDeals));
    } catch (e) {
      emit(StockStateFailed(currentEvent: event, errorMsg: e.toString()));
    }
  }

  Future<void> _loadDealFilter(
      LoadStockDealFilters event, Emitter<StockState> emit) async {
    try {
      emit(StockStateLoading(currentEvent: event));
      filter ??= await stockRepository.loadDealFilter();
      emit(StockDealFilterLoaded(dealFilter: filter!));
    } catch (e) {
      emit(StockStateFailed(currentEvent: event, errorMsg: e.toString()));
    }
  }
}
