import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persian_tools/persian_tools.dart' as persianTools;
import 'package:telechat/core/utils/custom_toast.dart';
import 'package:telechat/core/utils/get_shared_pref.dart';

import '../../../../core/consts/app_consts.dart';
import '../../../../core/consts/app_enums.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utils/time_util.dart';
import '../../../../core/utils/triangle_clipper.dart';

class PrivateChatItem extends StatefulWidget {
  final MessageSender messageSender;
  final Map<String, dynamic> message;

  PrivateChatItem({
    Key key,
    @required this.messageSender,
    @required this.message,
  }) : super(key: key);

  @override
  _PrivateChatItemState createState() => _PrivateChatItemState();
}

class _PrivateChatItemState extends State<PrivateChatItem> {
  String senderName;

  String messageText;

  DateTime time;

  bool isForwarded;

  bool isReplied;

  String forwardedFrom;

  String repliedFrom;

  String repliedMessage;

  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final controller = Get.put(SharedPrefController());
    if (widget.messageSender == MessageSender.me) {
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
    bool isLight = controller.getAppTheme == ThemeMode.light;
    Color tickColor = isLight ? Color(0xff9fc386) : Color(0xff92c8f4);
    messageText = widget.message['msg'];
    time = TimeUtil.convertDateToLocal(widget.message['created_at']);
    isForwarded = widget.message['forwarded_from_id'] != null;
    isReplied = widget.message['reply_message_id'] != null;
    Color iconColor = isLight ? cDarkGrey : Color(0xff92c8f4);

    return PortalEntry(
      visible: isMenuOpen,
      portal: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragStart: (details) {
          setState(() {
            isMenuOpen = false;
          });
        },
        onTap: () {
          setState(() {
            isMenuOpen = false;
          });
        },
      ),
      child: PortalEntry(
        visible: isMenuOpen,
        childAnchor: Alignment.center,
        portalAnchor: Alignment.center,
        closeDuration: Duration(milliseconds: 100),
        portal: Material(
          color: Colors.transparent,
          child: IntrinsicWidth(
            child: Container(
              width: 220,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kBorderRadius)),
                color: isLight
                    ? Colors.white
                    : Theme.of(context).appBarTheme.backgroundColor,
                elevation: 26,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(kBorderRadius),
                          topRight: Radius.circular(kBorderRadius),
                        ),
                      ),
                      leading: Transform.rotate(
                        angle: -pi / 1.0,
                        child: Icon(
                          MdiIcons.subdirectoryArrowRight,
                          color: iconColor,
                        ),
                      ),
                      title: Text(
                        locale.reply,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        MdiIcons.contentCopy,
                        color: iconColor,
                      ),
                      title: Text(
                        locale.copy,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Transform.rotate(
                        angle: -pi / 1.0,
                        child: Icon(
                          MdiIcons.subdirectoryArrowLeft,
                          color: iconColor,
                        ),
                      ),
                      title: Text(
                        locale.forward,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(kBorderRadius),
                          bottomRight: Radius.circular(kBorderRadius),
                        ),
                      ),
                      leading: Icon(
                        MdiIcons.trashCanOutline,
                        color: iconColor,
                      ),
                      title: Text(
                        locale.delete,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isMenuOpen = true;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: widget.messageSender == MessageSender.me
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (widget.messageSender == MessageSender.other)
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: ClipPath(
                      clipper: TriangleClipperOther(),
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(start: 6),
                        color: widget.messageSender == MessageSender.other
                            ? Theme.of(context).primaryColorLight
                            : Theme.of(context).primaryColorDark,
                        //color: cDarkMessageOther,
                        height: 12,
                        width: 7,
                      ),
                    ),
                  ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  decoration: BoxDecoration(
                    color: widget.messageSender == MessageSender.other
                        ? Theme.of(context).primaryColorLight
                        : Theme.of(context).primaryColorDark,
                    //color: cDarkMessageOther,
                    borderRadius: widget.messageSender == MessageSender.other
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
                      if (isForwarded)
                        Container(
                          margin: const EdgeInsetsDirectional.only(bottom: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                locale.forwardedMessage,
                                style: TextStyle(
                                  color: cForwardColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Vazir',
                                ),
                              ),
                              Text(
                                '${locale.from} ' + forwardedFrom,
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
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            kShowToast('Reply clicked');
                          },
                          child: Container(
                            margin: const EdgeInsetsDirectional.only(
                              bottom: 6,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsetsDirectional.only(end: 8),
                                  width: 3,
                                  height: 35,
                                  color: cForwardColor,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                        color:
                                            Theme.of(context).backgroundColor,
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
                                    text: widget.messageSender ==
                                            MessageSender.me
                                        ? '     ${TimeUtil.getChatTime(time)}'
                                        : '${TimeUtil.getChatTime(time)}',
                                    style:
                                        TextStyle(color: Colors.transparent)),
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
                                  widget.messageSender == MessageSender.me
                                      ? '${TimeUtil.getChatTime(time)} '
                                      : '${TimeUtil.getChatTime(time)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      .copyWith(
                                          color: !isLight
                                              ? tickColor
                                              : widget.messageSender ==
                                                      MessageSender.me
                                                  ? tickColor
                                                  : cDarkGrey),
                                ),
                                if (widget.messageSender == MessageSender.me)
                                  Icon(
                                    MdiIcons.checkAll,
                                    color: !isLight
                                        ? tickColor
                                        : widget.messageSender ==
                                                MessageSender.me
                                            ? tickColor
                                            : cDarkGrey,
                                    size: 19,
                                  ),
                              ],
                            ),
                            start: persianTools.hasPersian(messageText)
                                ? null
                                : null,
                            end: persianTools.hasPersian(messageText)
                                ? 0.0
                                : 0.0,
                            bottom: -2.0,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                if (widget.messageSender == MessageSender.me)
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 6),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: ClipPath(
                        clipper: TriangleClipperMe(),
                        child: Container(
                          color: widget.messageSender == MessageSender.other
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
          ),
        ),
      ),
    );
  }
}
