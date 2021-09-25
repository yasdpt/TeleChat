// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/utils/hive_controller.dart';
import '../widgets/group_member_item.dart';

class GroupProfilePage extends StatefulWidget {
  static const String routeName = '/groupProfilePage';
  const GroupProfilePage({Key key}) : super(key: key);

  @override
  _GroupProfilePageState createState() => _GroupProfilePageState();
}

class _GroupProfilePageState extends State<GroupProfilePage>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
                      "Dev Experts",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Vazir',
                      ),
                    ),
                    Text(
                      '22 members, 2 online',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
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
              ),
              child: Text(
                'Info', // TODO: ADD LOCALIZATION
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: cTitleBlue,
                    ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              child: Text(
                'Welcome to this group',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(fontSize: 15),
              ),
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
            TabBar(
              controller: _tabController,
              indicatorPadding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Theme.of(context).accentColor,
              labelColor: Theme.of(context).accentColor,
              unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
              labelPadding: EdgeInsets.zero,
              labelStyle: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: Theme.of(context).accentColor),
              unselectedLabelStyle: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: Theme.of(context).colorScheme.onSecondary),
              tabs: [
                Tab(
                  iconMargin: EdgeInsets.zero,
                  child: Text(
                    'Members', // TODO: ADD LOCALIZATION
                  ),
                ),
                Tab(
                  iconMargin: EdgeInsets.zero,
                  child: Text(
                    'Media', // TODO: ADD LOCALIZATION
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 20,
                    itemBuilder: (context, index) =>
                        GroupMemberItem(onTap: () {}),
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      20,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/ic_avatar.jpg'),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
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
