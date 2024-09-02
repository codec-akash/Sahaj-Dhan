import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_bloc.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_event.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_state.dart';
import 'package:sahaj_dhan/screens/homescreen/stock_deals.dart';
import 'package:sahaj_dhan/utils/text_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<StockBloc>().add(LoadStockDealFilters());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocListener<StockBloc, StockState>(
            listener: (context, state) {
              if (state is StockDealFilterLoaded) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const StockDealMain()));
              }
            },
            child: Container(),
          ),
          Text(
            "Stock OverFlow...",
            style: TextUtil.headingTitleText,
          ),
        ],
      ),
    );
  }
}
