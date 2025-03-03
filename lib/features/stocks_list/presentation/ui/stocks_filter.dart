import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/bloc/stocks_bloc.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/ui/widget/stock_date_list.dart';

class StocksFilterMain extends StatefulWidget {
  const StocksFilterMain({super.key});

  @override
  State<StocksFilterMain> createState() => _StocksFilterMainState();
}

class _StocksFilterMainState extends State<StocksFilterMain> {
  int page = 0;
  final ScrollController _scrollController = ScrollController();
  Map<String, List<Stock>> stocks = {};

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _setupScrollListener();
  }

  void _loadInitialData() {
    context.read<StocksBloc>().add(GetStockListEvent(page: page));
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  void _loadMore() {
    setState(() {
      page++;
    });
    context.read<StocksBloc>().add(GetStockListEvent(page: page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Stocks Data")),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildBlocListener(),
          SliverList.builder(
            itemCount: stocks.entries.length,
            itemBuilder: (context, index) => StockDateList(
              date: stocks.entries.elementAt(index).key,
              dateStocks: stocks.entries.elementAt(index).value,
            ),
          ),
          BlocBuilder<StocksBloc, StocksState>(
            builder: (context, state) {
              if (state is StocksLoadingState) {
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
          ),
        ],
      ),
    );
  }

  Widget _buildBlocListener() {
    return BlocListener<StocksBloc, StocksState>(
      listener: (context, state) {
        if (state is StocksListLoaded) {
          setState(() {
            stocks = state.stocks;
          });
        }
      },
      child: SliverToBoxAdapter(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
