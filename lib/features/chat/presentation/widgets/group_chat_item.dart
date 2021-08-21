import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persian_tools/persian_tools.dart' as persianTools;

import '../../../../core/consts/app_enums.dart';
import '../../../../core/styles/style_consts.dart';
import '../../../../core/utils/get_shared_pref.dart';
import '../../../../core/utils/triangle_clipper.dart';

class GroupChatItem extends StatelessWidget {
  final MessageSender messageSender;
  const GroupChatItem({
    Key key,
    this.messageSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //String messageText =
    //    'Hey nigga what\'s cooking? Im looking for you forever, where did you go? im glad i found you, praise Allah Hey nigga what\'s cooking? Im looking for you forever, where did you go? im glad i found you, praise Allah Hey nigga what\'s cooking? Im looking for you forever, where did you go? im glad i found you, praise Allah Hey nigga what\'s cooking? looking for you forever, where did you go? im glad i found you, praise \n\n Allah Hey nigga what\'s cooking? Im looking \n \n for you forever, where did you go? im glad i found you ';
    //String messageText = 'How Are you my dear?';
    int hi = 2;
    String messageText =
        'سلام چطوری؟ کجا بودی چهار ساعته دارم دنبالت میگردم کاکاسیاه، چطور جرعت کردی من رو تنها بذاری؟';
    //String messageText = 'Ok';
    //String messageText = 'سلام داش چطوری؟';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: messageSender == MessageSender.me
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (messageSender == MessageSender.other)
          Container(
            margin: const EdgeInsetsDirectional.only(start: 6),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurple[300],
            ),
            child: Center(
              child: Text(
                'M',
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        if (messageSender == MessageSender.other)
          Directionality(
            textDirection: TextDirection.ltr,
            child: ClipPath(
              clipper: TriangleClipperOther(),
              child: Container(
                color: messageSender == MessageSender.other
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).primaryColorDark,
                //color: cDarkMessageOther,
                height: 12,
                width: 7,
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          decoration: BoxDecoration(
            color: messageSender == MessageSender.other
                ? Theme.of(context).primaryColorLight
                : Theme.of(context).primaryColorDark,
            //color: cDarkMessageOther,
            borderRadius: messageSender == MessageSender.other
                ? BorderRadiusDirectional.only(
                    topEnd: Radius.circular(kBorderRadius),
                    topStart: Radius.circular(kBorderRadius),
                    bottomEnd: Radius.circular(kBorderRadius),
                  )
                : BorderRadiusDirectional.only(
                    topEnd: Radius.circular(kBorderRadius),
                    topStart: Radius.circular(kBorderRadius),
                    bottomStart: Radius.circular(kBorderRadius),
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (messageSender == MessageSender.other)
                Text(
                  'Martin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Vazir',
                  ),
                ),
              Stack(
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        //real message
                        TextSpan(
                          text: persianTools.hasPersian(messageText)
                              ? messageText.length < 20
                                  ? messageText + "    "
                                  : messageText
                              : messageText + "    ",
                          style: TextStyle(
                            color: Colors.transparent,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Vazir',
                          ),
                        ),
                        TextSpan(
                            text: messageSender == MessageSender.me
                                ? '     20:30'
                                : '20:30',
                            style: TextStyle(color: Colors.transparent)),
                      ],
                    ),
                  ),
                  Directionality(
                    textDirection: persianTools.hasPersian(messageText)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Text(
                      messageText.length < 20
                          ? messageText
                          : messageText + "  " + '\n',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Vazir',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  PositionedDirectional(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          messageSender == MessageSender.me
                              ? '20:30 '
                              : '20:30',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Vazir'),
                        ),
                        if (messageSender == MessageSender.me)
                          Icon(
                            MdiIcons.checkAll,
                            color: Colors.white,
                            size: 18,
                          ),
                      ],
                    ),
                    start: persianTools.hasPersian(messageText) ? null : null,
                    end: persianTools.hasPersian(messageText) ? 0.0 : 0.0,
                    bottom: -2.0,
                  )
                ],
              ),
            ],
          ),
        ),
        if (messageSender == MessageSender.me)
          Container(
            margin: const EdgeInsetsDirectional.only(end: 6),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: ClipPath(
                clipper: TriangleClipperMe(),
                child: Container(
                  color: messageSender == MessageSender.other
                      ? Theme.of(context).primaryColorLight
                      : Theme.of(context).primaryColorDark,
                  //color: cDarkMessageOther,
                  height: 12,
                  width: 7,
                ),
              ),
            ),
          )
      ],
    );
  }
}
