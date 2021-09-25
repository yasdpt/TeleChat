import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:telechat/core/consts/app_consts.dart';
import 'package:telechat/core/styles/colors.dart';

import '../../../../core/styles/text_field_decoration.dart';
import '../../../../core/utils/hive_controller.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/searchPage';
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final controller = HiveController();
    bool isLight = controller.getAppTheme == ThemeMode.light;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          maxLines: null,
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(fontWeight: FontWeight.w400),
          textInputAction: TextInputAction.search,
          autofocus: true,
          decoration: defaultInputDecorationSuffix(
              context, 'Search', // TODO: ADD LOCALIZATION
              backgroudColor: Theme.of(context).appBarTheme.backgroundColor,
              textStyle: TextStyle(
                  color: isLight ? Colors.white : cDarkGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Vazir'),
              suffixIcon: Icon(
                MdiIcons.magnify,
                color: Colors.white,
                size: 24,
              )),
        ),
      ),
      body: Container(
        child: Center(
          child: Text(
            'Type and click search button...',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
    );
  }
}
