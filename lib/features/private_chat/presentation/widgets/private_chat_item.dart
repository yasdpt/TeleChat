import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:hive/hive.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persian_tools/persian_tools.dart' as persianTools;

import '../../../../core/consts/app_consts.dart';
import '../../../../core/consts/app_enums.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/style_consts.dart';
import '../../../../core/utils/custom_toast.dart';
import '../../../../core/utils/hive_controller.dart';
import '../../../../core/utils/time_util.dart';
import '../../../../core/utils/triangle_clipper.dart';
import 'image_viewer_dialog.dart';
import 'swipeable.dart';
import 'video_player_dialog.dart';

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
    final controller = HiveController();
    if (widget.messageSender == MessageSender.me) {
      senderName = 'Me';
      forwardedFrom = 'Martin';
      repliedFrom = 'Montana';
      repliedMessage = 'Hey how are you doing?';
    } else {
      senderName = 'Jasmine';
      forwardedFrom = 'Jacob';
      repliedFrom = 'Bob Harris';
      repliedMessage = 'Good morning!👋';
    }
    bool isImage = widget.message['meta'] == 'image';
    bool isVideo = widget.message['meta'] == 'video';
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
        portal: _msgMenu(
          isLight,
          context,
          iconColor,
          locale,
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isMenuOpen = true;
            });
          },
          child: Swipeable(
            onSwipeEnd: () {
              kShowToast('Swipe ended');
            },
            backgroundIcon: Icon(
              MdiIcons.reply,
              color: isLight ? Colors.black : Colors.white,
              size: 28,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: widget.messageSender == MessageSender.me
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  if (widget.messageSender == MessageSender.other)
                    if (!((isImage || isVideo) && messageText.isEmpty))
                      _msgOtherTriangle(context),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      start: ((isImage || isVideo) && messageText.isEmpty)
                          ? widget.messageSender == MessageSender.other
                              ? 7
                              : 0
                          : 0,
                      end: ((isImage || isVideo) && messageText.isEmpty)
                          ? widget.messageSender == MessageSender.me
                              ? 7
                              : 0
                          : 0,
                    ),
                    padding: EdgeInsetsDirectional.only(
                      top: (isForwarded || isReplied)
                          ? 8
                          : (isImage || isVideo)
                              ? 1
                              : 10,
                      bottom:
                          ((isImage || isVideo) && messageText.isEmpty) ? 0 : 8,
                    ),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration:
                        _msgDecoration(context, isImage, isVideo, messageText),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (isForwarded) _buildForwardedFrom(locale),
                        if (isReplied) _buildReplyMsg(context),
                        if (isVideo) _buildVideo(context, tickColor, isLight),
                        if (isImage) _buildImage(context, tickColor, isLight),
                        if (messageText.isNotEmpty)
                          _buildMessageAndTime(
                            controller,
                            context,
                            isLight,
                            tickColor,
                            (isImage || isVideo),
                          ),
                      ],
                    ),
                  ),
                  if (widget.messageSender == MessageSender.me)
                    if (!((isImage || isVideo) && messageText.isEmpty))
                      _buildMeTriangle(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideo(
    BuildContext context,
    Color tickColor,
    bool isLight,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => VideoViewerDialog(
            videoUrl: 'videoUrl',
          ),
        );
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(
            start: 2, end: 2, bottom: messageText.isEmpty ? 1 : 4),
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.asset(background1),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5)),
                  child: Icon(
                    MdiIcons.download,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.center,
              //   child: Container(
              //     width: 55,
              //     height: 55,
              //     decoration: BoxDecoration(
              //       color: Colors.black.withOpacity(0.5),
              //       shape: BoxShape.circle,
              //     ),
              //     child: Center(
              //       child: Icon(
              //         MdiIcons.play,
              //         color: Colors.white,
              //         size: 28,
              //       ),
              //     ),
              //   ),
              // ),
              if (messageText.isEmpty)
                PositionedDirectional(
                  end: 10,
                  bottom: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                              .copyWith(color: Colors.white),
                        ),
                        if (widget.messageSender == MessageSender.me)
                          Icon(
                            MdiIcons.checkAll,
                            color: Colors.white,
                            size: 18,
                          ),
                      ],
                    ),
                  ),
                ),
              PositionedDirectional(
                start: 10,
                top: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    '24 MB',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(
    BuildContext context,
    Color tickColor,
    bool isLight,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          HeroDialogRoute(
            builder: (BuildContext context) {
              return ImageViewerDialog(
                imagesList: [
                  background1,
                  background2,
                  background3,
                  background4,
                  background5,
                ],
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(
            start: 2, end: 2, bottom: messageText.isEmpty ? 1 : 4),
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Hero(
                tag: background1,
                child: Image.asset(background1),
              ),
              //..._buildImageBlur,
              if (messageText.isEmpty)
                PositionedDirectional(
                  end: 10,
                  bottom: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                              .copyWith(color: Colors.white),
                        ),
                        if (widget.messageSender == MessageSender.me)
                          Icon(
                            MdiIcons.checkAll,
                            color: Colors.white,
                            size: 18,
                          ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildImageBlur = [
    Container(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.1),
        ),
      ),
    ),
    Align(
      alignment: Alignment.center,
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.black.withOpacity(0.5)),
        child: Icon(
          MdiIcons.download,
          color: Colors.white,
          size: 28,
        ),
      ),
    ),
  ];

  BoxDecoration _msgDecoration(
    BuildContext context,
    bool isImage,
    bool isVideo,
    String messageText,
  ) {
    return BoxDecoration(
      color: widget.messageSender == MessageSender.other
          ? Theme.of(context).primaryColorLight
          : Theme.of(context).primaryColorDark,
      //color: cDarkMessageOther,
      borderRadius: widget.messageSender == MessageSender.other
          ? BorderRadiusDirectional.only(
              topEnd: Radius.circular(kBorderRadius),
              topStart: Radius.circular(kBorderRadius),
              bottomEnd: Radius.circular(kBorderRadius),
              bottomStart: ((isImage || isVideo) && messageText.isEmpty)
                  ? Radius.circular(kBorderRadius)
                  : Radius.zero,
            )
          : BorderRadiusDirectional.only(
              topEnd: Radius.circular(kBorderRadius),
              topStart: Radius.circular(kBorderRadius),
              bottomStart: Radius.circular(kBorderRadius),
              bottomEnd: ((isImage || isVideo) && messageText.isEmpty)
                  ? Radius.circular(kBorderRadius)
                  : Radius.zero,
            ),
    );
  }

  Directionality _msgOtherTriangle(BuildContext context) {
    return Directionality(
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
    );
  }

  Material _msgMenu(bool isLight, BuildContext context, Color iconColor,
      AppLocalizations locale) {
    return Material(
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
    );
  }

  Container _buildMeTriangle(BuildContext context) {
    return Container(
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
    );
  }

  Container _buildMessageAndTime(
    HiveController controller,
    BuildContext context,
    bool isLight,
    Color tickColor,
    bool isImageOrVideo,
  ) {
    return Container(
      width: isImageOrVideo ? double.infinity : null,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
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
                    fontSize: controller.getFontSize,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Vazir',
                  ),
                ),
                TextSpan(
                    text: widget.messageSender == MessageSender.me
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
              messageText.length < 20 ? messageText : messageText + "  " + '\n',
              style: Theme.of(context).textTheme.headline3.copyWith(
                    fontSize: controller.getFontSize,
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
                  widget.messageSender == MessageSender.me
                      ? '${TimeUtil.getChatTime(time)} '
                      : '${TimeUtil.getChatTime(time)}',
                  style: Theme.of(context).textTheme.headline3.copyWith(
                      color: !isLight
                          ? tickColor
                          : widget.messageSender == MessageSender.me
                              ? tickColor
                              : cDarkGrey),
                ),
                if (widget.messageSender == MessageSender.me)
                  Icon(
                    MdiIcons.checkAll,
                    color: !isLight
                        ? tickColor
                        : widget.messageSender == MessageSender.me
                            ? tickColor
                            : cDarkGrey,
                    size: 19,
                  ),
              ],
            ),
            end: 0.0,
            bottom: -2.0,
          )
        ],
      ),
    );
  }

  Container _buildForwardedFrom(AppLocalizations locale) {
    return Container(
      margin: const EdgeInsetsDirectional.only(
        bottom: 4,
        start: 12,
        end: 12,
      ),
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
    );
  }

  GestureDetector _buildReplyMsg(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        kShowToast('Reply clicked');
      },
      child: Container(
        margin: const EdgeInsetsDirectional.only(
          bottom: 6,
          start: 12,
          end: 12,
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
    );
  }
}
