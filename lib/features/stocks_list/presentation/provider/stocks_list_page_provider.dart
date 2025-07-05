import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/core/services/injection.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/bloc/stocks_bloc.dart';

class StocksListPageProvider extends StatelessWidget {
  final Widget child;

  const StocksListPageProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StocksBloc(
        getStockList: di(),
        getStockFilter: di(),
        stocksService: di(),
      ),
      child: child,
    );
  }
}
