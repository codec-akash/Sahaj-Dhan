import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/core/services/injection.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/bloc/long_term_bloc.dart';

class LongTermPageProvider extends StatelessWidget {
  final Widget child;

  const LongTermPageProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LongTermBloc(
        getLongTermStocksUsecase: di(),
        longTermStockService: di(),
      ),
      child: child,
    );
  }
}
