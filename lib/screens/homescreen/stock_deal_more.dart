import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_bloc.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_event.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_state.dart';
import 'package:sahaj_dhan/models/deal_filter_model.dart';
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

  List<String> buyType = ["BUY", "SELL"];
  String? selectedBuyType;

  StockDeals stockDeals = StockDeals(result: [], isEndOfList: false);
  int skip = 0;
  bool isLoading = true;

  SymbolFilter? dealFilter;
  String? selectedSymbol;

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
    context.read<StockBloc>().add(LoadStockDealFilters());
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
                    if (state is StockDealFilterLoaded) {
                      setState(() {
                        dealFilter = state.dealFilter;
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
          if (dealFilter != null) ...[
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      "Filters",
                      style: TextUtil.text14Bold,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Symbols:", style: TextUtil.text14Bold),
                            DropdownButton<String>(
                              value: selectedSymbol,
                              items: dealFilter!.values
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      child: Text(e.value),
                                      value: e.value,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  selectedSymbol = val;
                                });
                              },
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text("Deal Type:", style: TextUtil.text14Bold),
                            DropdownButton<String>(
                              value: selectedBuyType,
                              items: buyType
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      child: Text(e),
                                      value: e,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  selectedBuyType = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
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
