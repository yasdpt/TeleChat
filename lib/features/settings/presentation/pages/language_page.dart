import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/cubit/app_theme_cubit.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utils/get_shared_pref.dart';

class LanguagePage extends StatelessWidget {
  static const String routeName = '/languagePage';
  const LanguagePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SharedPrefController());
    bool isLight = controller.getAppTheme == ThemeMode.light;
    final locale = AppLocalizations.of(context);
    String selectedLanguage = controller.getLanguage;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.language,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          _buildLanguageItem(
              context: context,
              isLight: isLight,
              title: 'English',
              subtitle: 'English',
              onTap: () {
                if (selectedLanguage == 'en') {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  controller.updateLanguage('en');
                  BlocProvider.of<AppThemeCubit>(context).toggleLanguage();
                }
              },
              isSelected: selectedLanguage == 'en'),
          _buildLanguageItem(
              context: context,
              isLight: isLight,
              title: 'فارسی',
              subtitle: 'Persian',
              onTap: () {
                if (selectedLanguage == 'fa') {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  controller.updateLanguage('fa');
                  BlocProvider.of<AppThemeCubit>(context).toggleLanguage();
                }
              },
              isSelected: selectedLanguage == 'fa'),
        ],
      ),
    );
  }

  Widget _buildLanguageItem({
    @required BuildContext context,
    @required bool isLight,
    @required String title,
    @required String subtitle,
    @required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 60,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 28),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          subtitle,
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(color: cDarkGrey),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check,
                      size: 26,
                      color: cTitleBlue,
                    ),
                  SizedBox(width: 28)
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 1,
          color: Theme.of(context).dividerColor,
        ),
      ],
    );
  }
}
