import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_bloc.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_event.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_state.dart';
import 'package:sahaj_dhan/models/deal_filter_model.dart';
import 'package:sahaj_dhan/models/stock_deal_model.dart';
import 'package:sahaj_dhan/screens/homescreen/deal_card.dart';
import 'package:sahaj_dhan/utils/date_utils.dart';
import 'package:sahaj_dhan/utils/text_theme.dart';

class StockDealMore extends StatefulWidget {
  const StockDealMore({super.key});

  @override
  State<StockDealMore> createState() => _StockDealMoreState();
}

class _StockDealMoreState extends State<StockDealMore> {
  final ScrollController _scrollController = ScrollController();

  List<String> buyType = ["BUY", "SELL", "BOTH"];
  String? selectedTradeType;

  StockDeals stockDeals = StockDeals(result: [], isEndOfList: false);
  int skip = 0;

  bool isLoading = true;
  bool showFilter = false;

  SymbolFilter? dealFilter;
  String? selectedSymbol;

  Map<String, List<Deal>> dealByDate = {};

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<StockBloc>().loadedStockDeals = null;
      _loadStockDeals();
      context.read<StockBloc>().add(LoadStockDealFilters());
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          skip++;
          _loadFilteredDeal();
        }
      });
    });
  }

  void _loadStockDeals() {
    context.read<StockBloc>().add(LoadPaginationStockDeal(
          skip: skip,
          isEndOfList: stockDeals.isEndOfList!,
          symbolName: selectedSymbol,
          tradeTypes: selectedTradeType,
        ));
  }

  void _loadFilteredDeal({bool? isEndOfList}) {
    // setState(() {
    //   dealByDate = {};
    // });
    // context.read<StockBloc>().loadedStockDeals = null;
    context.read<StockBloc>().add(
          LoadPaginationStockDeal(
            skip: skip,
            isEndOfList: isEndOfList ?? stockDeals.isEndOfList!,
            symbolName: selectedSymbol,
            tradeTypes: selectedTradeType,
            executedAt: _startDate,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    showFilter = !showFilter;
                  });
                },
                icon: const Icon(Icons.filter_alt_outlined),
              ),
            ],
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
                        if (state.stockDeals.result != null) {
                          for (var element in stockDeals.result!) {
                            String dealDate = element.executedAt!;
                            if (!dealByDate.containsKey(dealDate)) {
                              dealByDate[dealDate] = [];
                            }
                            dealByDate[dealDate]!.add(element);
                          }
                        }
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
              child: AnimatedSize(
                duration: const Duration(milliseconds: 400),
                alignment: Alignment.topCenter,
                child: !showFilter
                    ? Container()
                    : Container(
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
                                    Text("Symbols:",
                                        style: TextUtil.text14Bold),
                                    DropdownButton<String>(
                                      value: selectedSymbol,
                                      items: dealFilter!.values
                                          .map(
                                            (e) => DropdownMenuItem<String>(
                                              value: e.value,
                                              child: Text(
                                                e.value,
                                                style: TextUtil.subTitleText,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (val) {
                                        if (val != selectedSymbol) {
                                          setState(() {
                                            selectedSymbol = val;
                                          });
                                          _loadFilteredDeal(isEndOfList: false);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Deal Type:",
                                        style: TextUtil.text14Bold),
                                    DropdownButton<String>(
                                      value: selectedTradeType,
                                      items: buyType
                                          .map(
                                            (e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(
                                                e,
                                                style: TextUtil.subTitleText,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (val) {
                                        if (val != selectedTradeType) {
                                          setState(() {
                                            if (selectedTradeType == "BOTH") {
                                              selectedTradeType = null;
                                            } else {
                                              selectedTradeType = val;
                                            }
                                          });
                                          _loadFilteredDeal(isEndOfList: false);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text("Date:", style: TextUtil.text14Bold),
                            Row(
                              children: [
                                Expanded(
                                  child: DateRangePickerWidget(
                                    onDateRangeSelected: (start, end) {
                                      // Handle selected date range
                                      if (_startDate != start ||
                                          _endDate != end) {
                                        setState(() {
                                          _startDate = start;
                                          _endDate = end;
                                        });
                                        _loadFilteredDeal(isEndOfList: false);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
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
              itemCount: dealByDate.keys.length,
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                    child: Text(
                      DateTimeUtils.dateFormat(
                              DateTime.parse(dealByDate.keys.elementAt(index)))
                          .toString(),
                      style: TextUtil.subTitleTextBold,
                    ),
                  ),
                  Column(
                    children: [
                      ...dealByDate[dealByDate.keys.elementAt(index)]!
                          .map(
                            (stock) => DealCard(stockDeal: stock),
                          )
                          .toList()
                    ],
                  )
                ],
              ),
            )
          ],
        ],
      ),
    );
  }
}

class DateRangePickerWidget extends StatefulWidget {
  final Function(DateTime?, DateTime?) onDateRangeSelected;

  const DateRangePickerWidget({Key? key, required this.onDateRangeSelected})
      : super(key: key);

  @override
  State<DateRangePickerWidget> createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: _startDate ?? DateTime.now(),
        end: _endDate ?? DateTime.now(),
      ),
    );
    if (picked != null
        // &&
        // picked != DateTimeRange(start: _startDate!, end: _endDate!)
        ) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      widget.onDateRangeSelected(picked.start, picked.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text(
              _startDate != null && _endDate != null
                  ? '${_startDate!.toLocal()}'.split(' ')[0] +
                      ' - ' +
                      '${_endDate!.toLocal()}'.split(' ')[0]
                  : 'Select Date Range',
            ),
          ),
        ),
        if (_startDate != null || _endDate != null) ...[
          IconButton(
            onPressed: () {
              setState(() {
                _startDate = null;
                _endDate = null;
              });
              widget.onDateRangeSelected(null, null);
            },
            icon: const Icon(Icons.close),
          )
        ]
      ],
    );
  }
}
