import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/navigation/route_config.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/bloc/top_investor_bloc.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/screen/top_investor_card.dart';

class StocksHoldingInvestors extends StatefulWidget {
  final String stockName;
  final String symbol;
  const StocksHoldingInvestors({
    super.key,
    required this.stockName,
    required this.symbol,
  });

  static const String routeName = RouteConfig.stocksHoldingInvestors;

  @override
  State<StocksHoldingInvestors> createState() => _StocksHoldingInvestorsState();
}

class _StocksHoldingInvestorsState extends State<StocksHoldingInvestors> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<TopInvestorBloc>()
          .add(LoadStocksHoldingInvestors(widget.stockName));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stockName),
      ),
      body: BlocBuilder<TopInvestorBloc, TopInvestorState>(
        buildWhen: (previous, current) {
          if (current is StocksHoldingInvestorsLoaded ||
              (current is TopInvestorFailedState &&
                  (current.topInvestorEvent is LoadStocksHoldingInvestors)) ||
              (current is TopInvestorLoadingState &&
                  (current.topInvestorEvent is LoadStocksHoldingInvestors))) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is StocksHoldingInvestorsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Investors",
                    style: CustomTextTheme.text16.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.stocksHoldingInvestors.length,
                    itemBuilder: (context, index) {
                      return TopInvestorCard(
                          topInvestor: state.stocksHoldingInvestors[index]);
                    },
                  ),
                ),
              ],
            );
          }
          if (state is TopInvestorLoadingState &&
              (state.topInvestorEvent is LoadStocksHoldingInvestors)) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is TopInvestorFailedState &&
              (state.topInvestorEvent is LoadStocksHoldingInvestors)) {
            return Center(
                child: Text(state.message, style: CustomTextTheme.text16));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
