import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:telechat/core/consts/app_consts.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/utils/hive_controller.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profilePage';
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ScrollController scrollController;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isNotificationOn = true;

  @override
  Widget build(BuildContext context) {
    final controller = HiveController();
    final locale = AppLocalizations.of(context);
    bool isLight = controller.getAppTheme == ThemeMode.light;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width / 1.4,
              floating: true,
              pinned: true,
              titleSpacing: 0,
              actions: [
                IconButton(
                  icon: Icon(MdiIcons.dotsVertical),
                  onPressed: () {},
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                titlePadding:
                    const EdgeInsetsDirectional.only(start: 65, bottom: 8),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 25),
                    Text(
                      "Martin",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Vazir',
                      ),
                    ),
                    Text(
                      'Last seen recently',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Vazir',
                      ),
                    )
                  ],
                ),
                background: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/ic_avatar.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.45),
                            Colors.transparent
                          ],
                          begin: Alignment(0.5, 1),
                          end: Alignment(0.5, 0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(
                start: 18,
                top: 12,
                bottom: 4,
              ),
              child: Text(
                'Info', // TODO: ADD LOCALIZATION
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: cTitleBlue,
                    ),
              ),
            ),
            _buildSettingsItemWithoutIcon(
              isLight: isLight,
              title: '+98 939 776 3639',
              subtitle: 'Mobile',
              onTap: () {},
            ),
            _buildSettingsItemWithoutIcon(
              isLight: isLight,
              title: '@martin_fowler',
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
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: 18),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              'Notifications',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(fontSize: 15),
                            ),
                          ),
                          Text(
                            'On',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Switch(
                        value: isNotificationOn,
                        onChanged: (value) {
                          setState(() {
                            isNotificationOn = value;
                          });
                        },
                      ),
                      SizedBox(width: 18),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 15,
              color: Theme.of(context).dividerColor,
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(
                start: 18,
                top: 12,
                bottom: 8,
              ),
              child: Text(
                locale.media,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: cTitleBlue,
                    ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: List.generate(
                  20,
                  (index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ic_avatar.jpg'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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
