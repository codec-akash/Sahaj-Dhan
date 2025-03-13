import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sahaj_dhan/core/services/injection.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/bloc/long_term_bloc.dart';
import 'package:sahaj_dhan/firebase_options.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/bloc/stocks_bloc.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/ui/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  runApp(const MyApp());
  await ScreenUtil.ensureScreenSize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => StocksBloc(
              getStockList: di(),
              getStockFilter: di(),
              stocksService: di(),
            ),
          ),
          BlocProvider(
            create: (context) => LongTermBloc(
              getLongTermStocksUsecase: di(),
              longTermStockService: di(),
            ),
          )
        ],
        child: MaterialApp(
          title: "Sahaj Dhan",
          debugShowCheckedModeBanner: false,
          theme: ThemeConfig.lightTheme(),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
