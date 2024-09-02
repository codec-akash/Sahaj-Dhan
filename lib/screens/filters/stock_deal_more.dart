import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_bloc.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_event.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_state.dart';
import 'package:sahaj_dhan/models/deal_filter_model.dart';
import 'package:sahaj_dhan/models/stock_deal_model.dart';
import 'package:sahaj_dhan/screens/filters/filter_list_main.dart';
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

  final TextEditingController clientController = TextEditingController();
  final TextEditingController symbolController = TextEditingController();

  List<String> buyType = ["BUY", "SELL", "BOTH"];
  String? selectedTradeType;

  StockDeals stockDeals = StockDeals(result: [], isEndOfList: false);
  int skip = 0;

  bool isLoading = true;
  bool showFilter = false;

  Filters? dealFilter;
  String? selectedSymbol;
  String? selectedClientName;

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
          skip = stockDeals.result?.length ?? 0;
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
          clientName: selectedClientName,
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
            clientName: selectedClientName,
            tradeTypes: selectedTradeType,
            executedAt: _startDate,
            endDate: _endDate,
          ),
        );
  }

  void updateFilter({
    required String? selectedValue,
    required List<String> listToFilter,
    required Function(String val) onSelect,
  }) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => FilterNameSelector(clientsList: listToFilter),
      ),
    )
        .then((newValue) {
      if (selectedValue != newValue) {
        setState(() {
          onSelect(newValue);
        });
        resetFilter();
        _loadFilteredDeal(isEndOfList: false);
      }
    });
  }

  void resetFilter() {
    setState(() {
      skip = 0;
      stockDeals.isEndOfList = false;
      stockDeals.result = [];
      dealByDate = {};
    });
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
                        stockDeals.result!
                            .addAll(state.stockDeals.result ?? []);
                        stockDeals.isEndOfList = state.stockDeals.isEndOfList;
                        if (state.stockDeals.result != null) {
                          for (var element in state.stockDeals.result!) {
                            String dealDate = element.executedAt!;
                            if (!dealByDate.containsKey(dealDate)) {
                              dealByDate[dealDate] = [];
                            }
                            dealByDate[dealDate]!.add(element);
                          }
                        }
                        isLoading = false;
                      });
                      print(dealByDate);
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
                            Text("Investor Name :", style: TextUtil.text14Bold),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      updateFilter(
                                        selectedValue: selectedClientName,
                                        onSelect: (val) {
                                          selectedClientName = val;
                                        },
                                        listToFilter:
                                            dealFilter!.clientNames.values,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 10.h),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.blueAccent.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(20.h),
                                      ),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            selectedClientName ??
                                                "Filter by Investor",
                                            style: TextUtil.text14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (selectedClientName != null)
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        selectedClientName = null;
                                      });
                                      resetFilter();
                                      _loadFilteredDeal();
                                    },
                                    icon: const Icon(
                                      Icons.cancel,
                                    ),
                                  )
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Text("Stock :", style: TextUtil.text14Bold),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      updateFilter(
                                        selectedValue: selectedSymbol,
                                        onSelect: (val) {
                                          selectedSymbol = val;
                                        },
                                        listToFilter: dealFilter!
                                            .symbolFilter.values
                                            .map((e) => e.name.toString())
                                            .toList(),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 10.h),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.blueAccent.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(20.h),
                                      ),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            selectedSymbol ??
                                                "Filter by Stocks",
                                            style: TextUtil.text14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (selectedSymbol != null)
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedSymbol = null;
                                        });
                                        resetFilter();
                                        _loadFilteredDeal();
                                      },
                                      icon: const Icon(Icons.cancel))
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Column(
                              children: [
                                Text("Deal Type:", style: TextUtil.text14Bold),
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
                                        if (val == "BOTH") {
                                          selectedTradeType = null;
                                        } else {
                                          selectedTradeType = val;
                                        }
                                      });
                                      resetFilter();
                                      _loadFilteredDeal(isEndOfList: false);
                                    }
                                  },
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
                                        resetFilter();
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
              child: Text(
                "No Deals Found",
                textAlign: TextAlign.center,
              ),
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
                  ? '${'${_startDate!.toLocal()}'.split(' ')[0]} - ${'${_endDate!.toLocal()}'.split(' ')[0]}'
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
