import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_bloc.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_event.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_state.dart';
import 'package:sahaj_dhan/blocs/user_bloc/user_bloc.dart';
import 'package:sahaj_dhan/blocs/user_bloc/user_event.dart';
import 'package:sahaj_dhan/blocs/user_bloc/user_state.dart';
import 'package:sahaj_dhan/utils/firebase_api.dart';
import 'package:sahaj_dhan/utils/text_theme.dart';

import '../homescreen/stock_deals.dart';

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
      FirebaseApi().initNotifications().then((value) {
        // context.read<UserBloc>().add(CheckCanSendToken());
      });
      FirebaseApi().listenFcmToken();
      FirebaseApi().listenFcmMessage();
      // context.read<StockBloc>().add(LoadStockDealFilters());

      // TODO: uncomment after adding filter api from backend --
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const StockDealMain()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MultiBlocListener(
            listeners: [
              BlocListener<UserBloc, UserState>(
                listener: (context, state) {},
                child: Container(),
              ),
              BlocListener<StockBloc, StockState>(
                listener: (context, state) {
                  if (state is StockDealFilterLoaded) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const StockDealMain()));
                  }
                },
                child: Container(),
              ),
            ],
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
