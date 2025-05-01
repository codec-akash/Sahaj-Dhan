import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/extensions/context_extension.dart';
import 'package:sahaj_dhan/core/utils/constant.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/bloc/long_term_bloc.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/screen/filter_drawer.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/screen/long_term_stocks_datelist.dart';

class LongTermMain extends StatefulWidget {
  const LongTermMain({super.key});

  @override
  State<LongTermMain> createState() => _LongTermMainState();
}

class _LongTermMainState extends State<LongTermMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // * fitlers and pagination
  int page = 0;
  bool isHistorical = false;
  bool? profitOnly;
  bool? highestSort;
  bool? monthWiseTrade;

  final ScrollController _scrollController = ScrollController();
  Map<String, List<LongTermStock>> longTermStocks = {};

  @override
  void initState() {
    super.initState();
    _loadHodlStocks();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _loadHodlStocks();
        }
      });
    });
  }

  void _loadHodlStocks() {
    page++;
    context.read<LongTermBloc>().add(GetLongTermStockListEvent(
          page: page,
          isHistorical: isHistorical,
          profitType: profitOnly,
          monthlySortType: monthWiseTrade,
          showHighestSort: highestSort,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("HODL by sharks"),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: Icon(Icons.filter_alt_outlined),
          )
        ],
      ),
      endDrawer: FilterDrawer(
        openPositions: isHistorical,
        profitOnly: profitOnly,
        monthwiseTrade: monthWiseTrade,
        highest: highestSort,
        onApplyTap: (
            {highest,
            required isHistorical,
            profitOnly,
            tradeMonthWise}) async {
          setState(() {
            this.isHistorical = isHistorical;
            this.profitOnly = profitOnly;
            monthWiseTrade = tradeMonthWise;
            highestSort = highest;
            page = 0;
          });
          await _scrollController.animateTo(
            0,
            duration: Constant.duration500,
            curve: Curves.easeInOut,
          );
          _loadHodlStocks();
        },
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          BlocListener<LongTermBloc, LongTermState>(
            listener: (context, state) {
              if (state is LongTermListLoaded) {
                setState(() {
                  longTermStocks = state.longTermStocks;
                });
              }
              if (state is LongTermFailedState) {
                context.showSnackBar(title: state.message);
              }
            },
            child: SliverToBoxAdapter(),
          ),
          SliverList.builder(
            itemCount: longTermStocks.entries.length,
            itemBuilder: (context, index) => LongTermStocksDateList(
              date: longTermStocks.entries.elementAt(index).key,
              dateStocks: longTermStocks.entries.elementAt(index).value,
            ),
          ),
          BlocBuilder<LongTermBloc, LongTermState>(
            builder: (context, state) {
              if (state is LongTermLoadingState) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 50.h),
                      Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                );
              }
              return SliverToBoxAdapter();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
