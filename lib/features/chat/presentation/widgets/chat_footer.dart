import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_field_decoration.dart';
import '../../../../core/utils/get_shared_pref.dart';

class ChatFooter extends StatefulWidget {
  ChatFooter({Key key}) : super(key: key);

  @override
  _ChatFooterState createState() => _ChatFooterState();
}

class _ChatFooterState extends State<ChatFooter> {
  bool showSend = false;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SharedPrefController());
    bool isLight = controller.getAppTheme == ThemeMode.light;
    return Container(
        color: isLight
            ? Colors.white
            : Theme.of(context).appBarTheme.backgroundColor,
        constraints: BoxConstraints(maxHeight: 150),
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(
                  MdiIcons.emoticonOutline,
                  color: isLight ? cDarkGrey : Color(0xff92c8f4),
                  size: 29,
                ),
                onPressed: () {}),
            Expanded(
              child: TextField(
                maxLines: null,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(fontWeight: FontWeight.w400),
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      showSend = false;
                    });
                  } else {
                    setState(() {
                      showSend = true;
                    });
                  }
                },
                decoration: defaultInputDecoration(
                  context,
                  'Message',
                  backgroudColor: isLight
                      ? Colors.white
                      : Theme.of(context).appBarTheme.backgroundColor,
                ),
              ),
            ),
            if (showSend)
              IconButton(
                icon: Icon(
                  MdiIcons.send,
                  size: 28,
                  color: isLight ? cDarkGrey : Color(0xff92c8f4),
                ),
                onPressed: () {},
              ),
            if (!showSend)
              IconButton(
                icon: Transform.rotate(
                  angle: 0.8,
                  child: Icon(
                    MdiIcons.paperclip,
                    size: 28,
                    color: isLight ? cDarkGrey : Color(0xff92c8f4),
                  ),
                ),
                onPressed: () {},
              ),
          ],
        ));
  }
}
