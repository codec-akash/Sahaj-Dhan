import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_bloc.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_event.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_state.dart';
import 'package:sahaj_dhan/models/stock_deal_model.dart';
import 'package:sahaj_dhan/screens/homescreen/deal_card.dart';
import 'package:sahaj_dhan/utils/text_theme.dart';

class StockDealMore extends StatefulWidget {
  const StockDealMore({super.key});

  @override
  State<StockDealMore> createState() => _StockDealMoreState();
}

class _StockDealMoreState extends State<StockDealMore> {
  final ScrollController _scrollController = ScrollController();

  StockDeals stockDeals = StockDeals(result: [], isEndOfList: false);
  int skip = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadStockDeals();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          skip++;
          _loadStockDeals();
        }
      });
    });
  }

  void _loadStockDeals() {
    context.read<StockBloc>().add(LoadPaginationStockDeal(
        skip: skip, isEndOfList: stockDeals.isEndOfList!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(
              "Stock Deals",
              style: TextUtil.titleText,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                BlocListener<StockBloc, StockState>(
                  listener: (context, state) {
                    if (state is StockStateLoading &&
                        state.currentEvent is LoadPaginationStockDeal) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                    if (state is PaginatedStockDealsLoaded) {
                      setState(() {
                        stockDeals.result = state.stockDeals.result;
                        stockDeals.isEndOfList = state.stockDeals.isEndOfList;
                        isLoading = false;
                      });
                    }
                    if (state is StockStateFailed) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: Container(),
                ),
              ],
            ),
          ),
          if (stockDeals.result!.isEmpty) ...[
            const SliverToBoxAdapter(
              child: Text("Empty"),
            ),
          ] else ...[
            SliverList.builder(
              itemCount: stockDeals.result!.length,
              itemBuilder: (context, index) => DealCard(
                stockDeal: stockDeals.result![index],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
