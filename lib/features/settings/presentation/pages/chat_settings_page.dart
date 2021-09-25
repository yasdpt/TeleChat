import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persian_tools/persian_tools.dart' as persianTools;
import 'package:telechat/core/styles/style_consts.dart';

import '../../../../core/consts/app_consts.dart';
import '../../../../core/consts/app_enums.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utils/hive_controller.dart';
import '../../../../core/utils/time_util.dart';
import '../../../../core/utils/triangle_clipper.dart';

class ChatSettingsPage extends StatefulWidget {
  static const String routeName = '/chatSettings';
  ChatSettingsPage({Key key}) : super(key: key);

  @override
  _ChatSettingsPageState createState() => _ChatSettingsPageState();
}

class _ChatSettingsPageState extends State<ChatSettingsPage> {
  HiveController _controller;
  double _currentSliderValue;
  String _currentBackground = '';
  AppLocalizations _locale;

  @override
  void initState() {
    super.initState();
    _controller = HiveController();
    _currentSliderValue = _controller.getFontSize;
    _currentBackground = _controller.getBackgroundImage;
  }

  List<Map<String, dynamic>> chatList = [
    {
      'private_message_id': 1,
      'msg': "It's morning in Tokyo 😎",
      'chat_hash': 'vdokdok',
      'file_url': 'vdkdovkd',
      'meta': 'vdokvdo',
      'sender_id': 1,
      'reply_message_id': null,
      'forwarded_from_id': null,
      'is_seen': false,
      'created_at': '2021-08-19T10:21:17.621089',
      'updated_at': '2021-08-19T07:41:17.621089',
      'delete_code': 0,
      'reply_message_text': null,
      'forwarded_from_name': null
    },
    {
      'private_message_id': 3,
      'msg': 'Do you know what time it is?',
      'chat_hash': 'dvoddo',
      'file_url': 'vdovkdo',
      'meta': 'vdovkd',
      'sender_id': 2,
      'reply_message_id': 22,
      'forwarded_from_id': null,
      'is_seen': false,
      'created_at': '2021-08-19T10:06:50.847779',
      'updated_at': '2021-08-19T08:10:50.847779',
      'delete_code': 0,
      'reply_message_text': null,
      'forwarded_from_name': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    _locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat settings',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              _controller.upFontSize(_currentSliderValue.round().toDouble());
              _controller.upBackgroundImage(_currentBackground);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsetsDirectional.only(
              start: 24,
              top: 12,
            ),
            child: Text(
              'Message text size',
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: cTitleBlue,
                  ),
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.only(end: 18, bottom: 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Slider.adaptive(
                    value: _currentSliderValue,
                    activeColor: _controller.getAppTheme == ThemeMode.dark
                        ? Colors.blue
                        : null,
                    inactiveColor: _controller.getAppTheme == ThemeMode.dark
                        ? Colors.white
                        : null,
                    min: 10.0,
                    max: 24.0,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  _currentSliderValue.round().toString(),
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                repeat: ImageRepeat.repeat,
                image: AssetImage(_currentBackground),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: Column(
              children: <Widget>[
                _buildChatItem(
                  context,
                  MessageSender.other,
                  chatList[1],
                  _currentSliderValue.round().toDouble(),
                ),
                _buildChatItem(
                  context,
                  MessageSender.me,
                  chatList[0],
                  _currentSliderValue.round().toDouble(),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(
              start: 18,
              top: 12,
              bottom: 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  MdiIcons.imageSizeSelectActual,
                  color: cTitleBlue,
                  size: 24,
                ),
                SizedBox(width: 6),
                Text(
                  'Chat background',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: cTitleBlue,
                      ),
                ),
              ],
            ),
          ),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildChatBackground(
                background3,
                _currentBackground == background3,
              ),
              _buildChatBackground(
                background1,
                _currentBackground == background1,
              ),
              _buildChatBackground(
                background2,
                _currentBackground == background2,
              ),
              _buildChatBackground(
                background4,
                _currentBackground == background4,
              ),
              _buildChatBackground(
                background5,
                _currentBackground == background5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatBackground(String image, bool isSelected) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _currentBackground = image;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
        child: isSelected
            ? Center(
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.5),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              )
            : const Offstage(),
      ),
    );
  }

  Widget _buildChatItem(
    BuildContext context,
    MessageSender messageSender,
    Map<String, dynamic> message,
    double fontSize,
  ) {
    String messageText;

    DateTime time;

    bool isForwarded;

    bool isReplied;

    String forwardedFrom;

    String repliedFrom;

    String repliedMessage;

    if (messageSender == MessageSender.me) {
      forwardedFrom = 'Martin';
      repliedFrom = 'Montana';
      repliedMessage = 'Hey how are you doing?';
    } else {
      forwardedFrom = 'Jacob';
      repliedFrom = 'Bob Harris';
      repliedMessage = 'Good morning!👋';
    }
    bool isLight = _controller.getAppTheme == ThemeMode.light;
    Color tickColor = isLight ? Color(0xff9fc386) : Color(0xff92c8f4);
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
            Directionality(
              textDirection: TextDirection.ltr,
              child: ClipPath(
                clipper: TriangleClipperOther(),
                child: Container(
                  margin: const EdgeInsetsDirectional.only(start: 6),
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
                if (isForwarded)
                  Container(
                    margin: const EdgeInsetsDirectional.only(bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _locale.forwardedMessage,
                          style: TextStyle(
                            color: cForwardColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Vazir',
                          ),
                        ),
                        Text(
                          '${_locale.from} ' + forwardedFrom,
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
                              fontSize: fontSize,
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
                        style: Theme.of(context).textTheme.headline3.copyWith(
                              fontSize: fontSize,
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
                                ? '${TimeUtil.getChatTime(time)} '
                                : '${TimeUtil.getChatTime(time)}',
                            style:
                                Theme.of(context).textTheme.headline3.copyWith(
                                    color: !isLight
                                        ? tickColor
                                        : messageSender == MessageSender.me
                                            ? tickColor
                                            : cDarkGrey),
                          ),
                          if (messageSender == MessageSender.me)
                            Icon(
                              MdiIcons.checkAll,
                              color: !isLight
                                  ? tickColor
                                  : messageSender == MessageSender.me
                                      ? tickColor
                                      : cDarkGrey,
                              size: 19,
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
