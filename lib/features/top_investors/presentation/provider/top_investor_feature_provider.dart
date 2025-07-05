import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/core/services/injection.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/bloc/top_investor_bloc.dart';

/// A shared provider for all screens that use TopInvestorBloc
/// This ensures we have a single instance of the bloc across related screens
class TopInvestorFeatureProvider extends StatelessWidget {
  final Widget child;

  const TopInvestorFeatureProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Using BlocProvider.value if a parent already provides the bloc
    if (context.read<TopInvestorBloc?>() != null) {
      return child;
    }

    // Create new bloc instance only if one doesn't exist
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
