import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_bloc.dart';
import 'package:sahaj_dhan/blocs/user_bloc/user_bloc.dart';
import 'package:sahaj_dhan/firebase_options.dart';
import 'package:sahaj_dhan/screens/splash_screen/splash_screen.dart';
import 'package:sahaj_dhan/utils/app_color.dart';
import 'package:sahaj_dhan/utils/mixpanel_manager.dart';
import 'package:sahaj_dhan/utils/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await MixpanelManager.init();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  runApp(const MyApp());
  await ScreenUtil.ensureScreenSize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColor.backgroundColorDark,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.notoSansTextTheme(baseTheme.textTheme),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<StockBloc>(
            create: (context) => StockBloc(),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(),
          ),
        ],
        child: MaterialApp(
          title: Strings.appName,
          theme: _buildTheme(Brightness.dark),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
