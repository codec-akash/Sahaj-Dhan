import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          BlocBuilder<StocksBloc, StocksState>(
            builder: (context, state) {
              if (state is StocksListLoaded) {
                return SliverList.builder(
                  itemCount: state.stocks.entries.length,
                  itemBuilder: (context, index) => StockDateList(
                    date: state.stocks.entries.elementAt(index).key,
                    dateStocks: state.stocks.entries.elementAt(index).value,
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
        if (state is StocksListLoaded) {}
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
