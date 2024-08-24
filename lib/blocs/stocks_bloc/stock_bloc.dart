import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_event.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_state.dart';
import 'package:sahaj_dhan/models/stock_deal_model.dart';
import 'package:sahaj_dhan/repository/stock_repository.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockRepository stockRepository = StockRepository();

  StockDeals? loadedStockDeals;

  StockBloc() : super(Uninitialized()) {
    on<LoadStockDeals>(_loadStockDeals);
    on<LoadPaginationStockDeal>(_loadPaginatedStockDeals);
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
      loadedStockDeals = null;
      StockDeals stockDeals = StockDeals(result: []);
      if (!event.isEndOfList) {
        emit(StockStateLoading(currentEvent: event));
        stockDeals =
            await stockRepository.getStockDealListPaginated(event.skip);

        if (loadedStockDeals == null) {
          loadedStockDeals = stockDeals;
        } else {
          loadedStockDeals!.result!.addAll(stockDeals.result!);
          loadedStockDeals!.isEndOfList = stockDeals.isEndOfList;
        }
      }

      emit(PaginatedStockDealsLoaded(
          stockDeals: loadedStockDeals ?? stockDeals));
    } catch (e) {
      emit(StockStateFailed(currentEvent: event, errorMsg: e.toString()));
    }
  }
}
