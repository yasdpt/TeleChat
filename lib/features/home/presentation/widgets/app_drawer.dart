import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:telechat/core/consts/app_consts.dart';

import '../../../../core/cubit/app_theme_cubit.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utils/hive_controller.dart';
import '../../../contacts/presentation/pages/contacts_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = HiveController();
    final locale = AppLocalizations.of(context);
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: const EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsetsDirectional.only(
                top: 40,
                start: 20,
                end: 10,
              ),
              height: 170,
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrange[300],
                        ),
                        child: Center(
                            child: Text(
                          'M',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(color: Colors.white),
                        )),
                        // child: ClipRRect(
                        //   borderRadius: BorderRadius.circular(50),
                        //   child: Image.asset(
                        //     'assets/images/ic_avatar.jpg',
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                      ),
                      IconButton(
                        icon: Icon(
                          controller.getAppTheme == ThemeMode.light
                              ? MdiIcons.weatherNight
                              : MdiIcons.whiteBalanceSunny,
                          color: Colors.white,
                          size: 27,
                        ),
                        onPressed: () {
                          if (controller.getAppTheme == ThemeMode.light) {
                            controller.updateAppTheme('dark');
                          } else {
                            controller.updateAppTheme('light');
                          }
                          BlocProvider.of<AppThemeCubit>(context)
                              .toggleLanguage();
                        },
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(
                      bottom: 8,
                      start: 4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Mr YaS',
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              .copyWith(color: Colors.white),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(top: 1),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              '+98 939 776 3639',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 4),
            ListTile(
              leading: Icon(
                MdiIcons.accountMultipleOutline,
                color: cDarkGrey,
                size: 28,
              ),
              title: Text(
                locale.newGroup,
                style: Theme.of(context).textTheme.headline3,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(
                MdiIcons.accountOutline,
                color: cDarkGrey,
                size: 28,
              ),
              title: Text(
                locale.contacts,
                style: Theme.of(context).textTheme.headline3,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(ContactsPage.routeName);
              },
            ),
            ListTile(
              leading: Icon(
                MdiIcons.bookmarkOutline,
                color: cDarkGrey,
                size: 28,
              ),
              title: Text(
                locale.savedMessages,
                style: Theme.of(context).textTheme.headline3,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(
                MdiIcons.cogOutline,
                color: cDarkGrey,
                size: 28,
              ),
              title: Text(
                locale.settings,
                style: Theme.of(context).textTheme.headline3,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(SettingsPage.routeName);
              },
            ),
            ListTile(
              leading: Icon(
                MdiIcons.helpCircleOutline,
                color: cDarkGrey,
                size: 28,
              ),
              title: Text(
                locale.aboutUs,
                style: Theme.of(context).textTheme.headline3,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}
