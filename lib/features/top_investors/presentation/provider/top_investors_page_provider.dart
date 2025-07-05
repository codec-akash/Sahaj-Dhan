import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/core/services/injection.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/bloc/top_investor_bloc.dart';

class TopInvestorsPageProvider extends StatelessWidget {
  final Widget child;

  const TopInvestorsPageProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopInvestorBloc(
        topInvestorUsecase: di(),
        getInvestorHoldings: di(),
        getStocksHoldingInvestors: di(),
      ),
      child: child,
    );
  }
}
