import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persian_tools/persian_tools.dart' as persianTools;

import '../../../../core/consts/app_enums.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/style_consts.dart';
import '../../../../core/utils/time_util.dart';
import '../../../../core/utils/triangle_clipper.dart';

class GroupChatItem extends StatelessWidget {
  final MessageSender messageSender;
  final Map<String, dynamic> message;
  String senderName;
  String messageText;
  DateTime time;
  bool isForwarded;
  bool isReplied;
  String forwardedFrom;
  String repliedFrom;
  String repliedMessage;

  GroupChatItem({
    Key key,
    @required this.messageSender,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (messageSender == MessageSender.me) {
      senderName = 'Me';
      forwardedFrom = 'Martin';
      repliedFrom = 'Montana';
      repliedMessage = 'Hey how are you doing?';
    } else {
      senderName = 'Jasmine';
      forwardedFrom = 'Jacob';
      repliedFrom = 'Emmet';
      repliedMessage = 'Yeah i know that';
    }
    messageText = message['msg'];
    time = TimeUtil.convertDateToLocal(message['created_at']);
    isForwarded = message['forwarded_from_id'] != null;
    isReplied = message['reply_message_id'] != null;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
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
                  senderName[0].toUpperCase(),
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
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
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
                    senderName,
                    style: TextStyle(
                      color: getRandomColor(),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Vazir',
                    ),
                  ),
                if (isForwarded)
                  Container(
                    margin: const EdgeInsetsDirectional.only(bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Forwarded message',
                          style: TextStyle(
                            color: cForwardColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Vazir',
                          ),
                        ),
                        Text(
                          'From ' + forwardedFrom,
                          style: TextStyle(
                            color: cForwardColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Vazir',
                          ),
                        )
                      ],
                    ),
                  ),
                if (isReplied)
                  Container(
                    margin: const EdgeInsetsDirectional.only(
                      bottom: 6,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: 8),
                          width: 3,
                          height: 35,
                          color: cForwardColor,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              repliedFrom,
                              style: TextStyle(
                                color: cForwardColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Vazir',
                              ),
                            ),
                            Text(
                              repliedMessage,
                              style: TextStyle(
                                color: Theme.of(context).backgroundColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Vazir',
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ],
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
                                  ? '     ${TimeUtil.getChatTime(time)}'
                                  : '${TimeUtil.getChatTime(time)}',
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
                        style: Theme.of(context).textTheme.headline3,
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
                                ? '${TimeUtil.getChatTime(time)} '
                                : '${TimeUtil.getChatTime(time)}',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(
                                    color: Theme.of(context).backgroundColor),
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
      ),
    );
  }
}
