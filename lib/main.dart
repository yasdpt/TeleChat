import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:telechat/core/consts/app_consts.dart';

import 'core/cubit/app_theme_cubit.dart';
import 'core/styles/theme.dart';
import 'core/utils/hive_controller.dart';
import 'core/utils/router.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setupHive();
  runApp(MyApp());
}

Future<void> _setupHive() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox(sHiveBoxKey);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final controller = HiveController();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppThemeCubit>(
          create: (BuildContext context) => AppThemeCubit(),
        ),
      ],
      child: BlocBuilder<AppThemeCubit, bool>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Portal(
            child: MaterialApp(
              title: 'TeleChat',
              debugShowCheckedModeBanner: false,
              builder: (context, widget) => ResponsiveWrapper.builder(
                widget,
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
            ),
          );
        },
      ),
    );
  }
}
