import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:telechat/core/consts/app_consts.dart';

import '../../../../core/consts/app_enums.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utils/hive_controller.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../widgets/chat_footer.dart';
import '../widgets/private_chat_item.dart';

class PrivateChatPage extends StatefulWidget {
  static const String routeName = '/privateChatPage';
  const PrivateChatPage({Key key}) : super(key: key);

  @override
  _PrivateChatPageState createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  AutoScrollController scrollController;

  List<Map<String, dynamic>> chatList = [
    {
      'group_message_id': 1,
      'msg': 'I am wondering where everyone is?',
      'chat_hash': 'vdokdok',
      'file_url': 'vdkdovkd',
      'meta': 'vdokvdo',
      'sender_id': 1,
      'reply_message_id': null,
      'forwarded_from_id': 30,
      'is_seen': false,
      'created_at': '2021-08-19T07:41:17.621089',
      'updated_at': '2021-08-19T07:41:17.621089',
      'delete_code': 0,
      'reply_message_text': null,
      'forwarded_from_name': null
    },
    {
      'group_message_id': 3,
      'msg': 'I am sure you do',
      'chat_hash': 'dvoddo',
      'file_url': 'vdovkdo',
      'meta': 'image',
      'sender_id': 2,
      'reply_message_id': 22,
      'forwarded_from_id': null,
      'is_seen': false,
      'created_at': '2021-08-19T08:10:50.847779',
      'updated_at': '2021-08-19T08:10:50.847779',
      'delete_code': 0,
      'reply_message_text': null,
      'forwarded_from_name': null,
    },
    {
      'group_message_id': 1,
      'msg': 'Thank you im fine ',
      'chat_hash': 'vdokdok',
      'file_url': 'vdkdovkd',
      'meta': 'image',
      'sender_id': 1,
      'reply_message_id': 30,
      'forwarded_from_id': null,
      'is_seen': false,
      'created_at': '2021-08-19T07:41:17.621089',
      'updated_at': '2021-08-19T07:41:17.621089',
      'delete_code': 0,
      'reply_message_text': null,
      'forwarded_from_name': null
    },
    {
      'group_message_id': 1,
      'msg': 'Hey guys',
      'chat_hash': 'vdokdok',
      'file_url': 'vdkdovkd',
      'meta': 'image',
      'sender_id': 1,
      'reply_message_id': null,
      'forwarded_from_id': null,
      'is_seen': false,
      'created_at': '2021-08-19T07:41:17.621089',
      'updated_at': '2021-08-19T07:41:17.621089',
      'delete_code': 0,
      'reply_message_text': null,
      'forwarded_from_name': null
    },
    {
      'group_message_id': 2,
      'msg': 'We are fine friend how are you?',
      'chat_hash': 'dvoddo',
      'file_url': 'vdovkdo',
      'meta': 'image',
      'sender_id': 2,
      'reply_message_id': null,
      'forwarded_from_id': null,
      'is_seen': false,
      'created_at': '2021-08-19T08:10:50.847779',
      'updated_at': '2021-08-19T08:10:50.847779',
      'delete_code': 0,
      'reply_message_text': null,
      'forwarded_from_name': null,
    },
    {
      'group_message_id': 3,
      'msg': 'Yesterday i was sick',
      'chat_hash': 'dvoddo',
      'file_url': 'vdovkdo',
      'meta': 'image',
      'sender_id': 2,
      'reply_message_id': null,
      'forwarded_from_id': 33,
      'is_seen': false,
      'created_at': '2021-08-19T08:10:50.847779',
      'updated_at': '2021-08-19T08:10:50.847779',
      'delete_code': 0,
      'reply_message_text': null,
      'forwarded_from_name': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    scrollController = AutoScrollController();
    // scrollController.scrollToIndex(
    //   14,
    //   preferPosition: AutoScrollPosition.end,
    // );
  }

  @override
  Widget build(BuildContext context) {
    final controller = HiveController();
    bool isLight = controller.getAppTheme == ThemeMode.light;
    return Scaffold(
      backgroundColor: cDarkGreyBlue,
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 64,
        title: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ProfilePage.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: getRandomColor(), shape: BoxShape.circle),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Text(
                          'M',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Martin',
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(color: Colors.white),
                      ),
                      Text('Last seen recently',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(color: Colors.grey[300]))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(icon: Icon(MdiIcons.dotsVertical), onPressed: () {})
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            repeat: ImageRepeat.repeat,
            image: AssetImage(
              controller.getBackgroundImage,
            ),
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    padding:
                        const EdgeInsetsDirectional.only(top: 8, bottom: 4),
                    itemCount: chatList.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final chat = chatList[index];
                      if (chat['sender_id'] == 1) {
                        return PrivateChatItem(
                          messageSender: MessageSender.me,
                          message: chatList[index],
                        );
                      } else {
                        return PrivateChatItem(
                          messageSender: MessageSender.other,
                          message: chatList[index],
                        );
                      }
                    }),
              ),
              ChatFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _wrapScrollTag({@required int index, @required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: scrollController,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );
}
