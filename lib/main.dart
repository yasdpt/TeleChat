import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/cubit/app_theme_cubit.dart';
import 'core/styles/theme.dart';
import 'core/utils/get_shared_pref.dart';
import 'core/utils/router.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SharedPrefController());
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppThemeCubit>(
          create: (BuildContext context) => AppThemeCubit(),
        ),
      ],
      child: BlocBuilder<AppThemeCubit, bool>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return MaterialApp(
            title: 'TeleChat',
            debugShowCheckedModeBanner: false,
            builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget),
              maxWidth: 1200,
              minWidth: 390,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(390, name: MOBILE),
                ResponsiveBreakpoint.autoScale(480, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
              background: Container(
                color: Colors.white,
              ),
            ),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', ''), // English, no country code
              Locale('fa', ''), // Farsi, no country code
            ],
            localeResolutionCallback: (locale, supportedLocales) =>
                Locale(controller.getLanguage, ''),
            locale: Locale(controller.getLanguage, ''),
            onGenerateRoute: generateRoutes,
            theme: CustomTheme.lightTheme,
            darkTheme: CustomTheme.darkTheme,
            themeMode: controller.getAppTheme,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
