import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/utils/get_shared_pref.dart';
import 'language_page.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settingsPage';
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ScrollController scrollController;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SharedPrefController());
    final locale = AppLocalizations.of(context);
    bool isLight = controller.getAppTheme == ThemeMode.light;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              floating: true,
              pinned: true,
              actions: [
                IconButton(
                  icon: Icon(MdiIcons.pencilOutline),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(MdiIcons.dotsVertical),
                  onPressed: () {},
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Mr YaS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  background: Image.asset(
                    'assets/images/ic_avatar.png',
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(
                start: 18,
                top: 18,
                bottom: 4,
              ),
              child: Text(
                locale.account,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: cTitleBlue,
                    ),
              ),
            ),
            _buildSettingsItemWithoutIcon(
              isLight: isLight,
              title: '+98 939 776 3639',
              subtitle: locale.phoneNumer,
              onTap: () {},
            ),
            _buildSettingsItemWithoutIcon(
              isLight: isLight,
              title: '@MrYaS',
              subtitle: locale.username,
              onTap: () {},
            ),
            _buildSettingsItemWithoutIcon(
              isLight: isLight,
              title: '21 year old Programmer',
              subtitle: locale.bio,
              onTap: () {},
            ),
            Container(
              height: 15,
              color: Theme.of(context).dividerColor,
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(
                start: 18,
                top: 18,
                bottom: 4,
              ),
              child: Text(
                'Settings',
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: cTitleBlue,
                    ),
              ),
            ),
            _buildSettingsItemWithIcon(
              isLight: isLight,
              icon: MdiIcons.bellOutline,
              title: locale.notificationSettings,
              onTap: () {},
            ),
            _buildSettingsItemWithIcon(
              isLight: isLight,
              icon: MdiIcons.chatOutline,
              title: locale.chatSettings,
              onTap: () {},
            ),
            _buildSettingsItemWithIcon(
              isLight: isLight,
              icon: MdiIcons.web,
              title: locale.language,
              onTap: () {
                Navigator.of(context).pushNamed(LanguagePage.routeName);
              },
            ),
            SizedBox(height: 10),
            Container(
              height: 30,
              child: Center(
                child: Text(
                  'Telechat for Android v0.0.1',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontSize: 15)
                      .copyWith(color: cDarkGrey),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItemWithIcon({
    @required bool isLight,
    @required IconData icon,
    @required String title,
    @required VoidCallback onTap,
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
                children: <Widget>[
                  SizedBox(width: 18),
                  Icon(
                    icon,
                    color: cDarkGrey,
                    size: 26,
                  ),
                  SizedBox(width: 12),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(fontSize: 15),
                  ),
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

  Widget _buildSettingsItemWithoutIcon({
    @required bool isLight,
    @required String title,
    @required VoidCallback onTap,
    String subtitle,
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
                children: <Widget>[
                  SizedBox(width: 18),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Text(
                        subtitle ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  )
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
