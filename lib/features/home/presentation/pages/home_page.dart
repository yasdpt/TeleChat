import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/src/copy/web_socket_impl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:realtime_client/src/constants.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase/supabase.dart';
import '../../../../core/consts/app_enums.dart';
import '../../../chat/presentation/widgets/group_chat_item.dart';

import '../../../../core/consts/app_config.dart';
import '../../../../core/cubit/app_theme_cubit.dart';
import '../../../../core/utils/get_shared_pref.dart';
import '../../../chat/presentation/pages/private_chat_page.dart';
import '../widgets/app_drawer.dart';
import '../widgets/chat_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SupabaseClient client;
  RealtimeSubscription privateMsgSubscription;
  RealtimeSubscription groupMsgSubscription;
  List<Map<String, dynamic>> initialData = [
    {
      'private_message_id': 1,
      'msg': 'kovkdo',
      'chat_hash': 'vdokdok',
      'file_url': 'vdkdovkd',
      'meta': 'vdokvdo',
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
      'private_message_id': 2,
      'msg': 'msg',
      'chat_hash': 'dvoddo',
      'file_url': 'vdovkdo',
      'meta': 'vdovkd',
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
  ];

  @override
  void initState() {
    super.initState();
    client = SupabaseClient(AppConfig.supaBaseUrl, AppConfig.supaBaseKey);
    client.realtime.obs.listen(
      (onData) {
        print("Socket state: " + onData.connState.name());
      },
    );

    // final response =
    //     await client.from('private_messages').select().limit(2).execute();

    // //initialData = response.data as List<Map<String, dynamic>>;
    // print(response.data);
    // privateMsgSubscription =
    //     client.from('private_messages').on(SupabaseEventTypes.all, (payload) {
    //   // Do something when there is an update
    //   if (payload.eventType == 'INSERT') {
    //     // TODO: Add rpc for adding one value to chat message count
    //   }
    // }).subscribe();

    // groupMsgSubscription =
    //     client.from('group_messages').on(SupabaseEventTypes.all, (payload) {
    //   // Do something when there is an update

    // }).subscribe();
  }

  @override
  void dispose() {
    // client.removeSubscription(privateMsgSubscription);
    // client.removeSubscription(groupMsgSubscription);
    super.dispose();
  }

  Future<void> getUsers() async {
    // final response =
    //     await client.auth.signUp('fouladiyasin@gmail.com', 'yasin1234');
    // print(response.error.message);
    // final query = client.from('private_messages').select("""
    //     sender_id,
    //     telechat_users (
    //       user_id
    //     )""").query;
    // final response2 = await client.from('private_messages').select("""
    //     *,
    //     telechat_users (
    //       *
    //     )""").execute();

    // //print(query.toString());
    // if (response2.error != null) {
    //   print(response2.error.message);
    // } else {
    //   final path = await _localPath;
    //   final file = File('$path/result.txt');
    //   file.writeAsStringSync(json.encode(response2.data));
    //   final storageResponse =
    //       await client.storage.from('chatimages').upload('result.txt', file);
    //   if (storageResponse.error != null) {
    //     print('Upload error= ' + storageResponse.error.message);
    //   } else {
    //     print('Upload successful' + storageResponse.data);
    //   }
    //   print(response2.data.toString());
    // }
    final sssUrl = client.storage.from('chatimages').getPublicUrl('result.txt');

    // client
    //     .from('messages')
    //     .stream()
    //     .order('created_at', ascending: true)
    //     .limit(30)
    //     .execute();
    // print(sssUrl.data);

    // final response3 = await client.storage.createBucket('photos');
    // final path = await _localPath;
    // final file = File('$path/justafile.txt');
    // file.writeAsStringSync('File content yas');
    // final storageResponse =
    //     await client.storage.from('chatimages').upload('justafile.txt', file);
    // print(storageResponse.data.toString());
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  int limit = 2;

  @override
  Widget build(BuildContext context) {
    // final locale = AppLocalizations.of(context).helloWorld;
    final controller = Get.put(SharedPrefController());
    // print(locale);
    //getUsers();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Chats',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.magnify),
            onPressed: () {
              if (controller.getLanguage == 'en') {
                controller.updateLanguage('fa');
              } else {
                controller.updateLanguage('en');
              }
              BlocProvider.of<AppThemeCubit>(context).toggleLanguage();
            },
          ),
        ],
        // systemOverlayStyle:
        //     SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white),
      ),
      drawer: AppDrawer(),
      body: Center(
        // child: StreamBuilder(
        //   initialData: initialData,
        //   stream: client
        //       .from('private_messages')
        //       .stream()
        //       .order('created_at')
        //       .limit(limit)
        //       .execute(),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     // print(snapshot.connectionState);

        //     if (snapshot.hasData) {
        //       List<Map<String, dynamic>> listOfItems = snapshot.data;
        //       return Container(
        //         padding: const EdgeInsets.all(32.0),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Expanded(
        //               child: ListView.builder(
        //                 itemCount: listOfItems.length,
        //                 itemBuilder: (context, index) => Text(
        //                   listOfItems[index]['msg'],
        //                 ),
        //               ),
        //             ),
        //             ElevatedButton(
        //                 onPressed: () {
        //                   setState(() {
        //                     limit = 3;
        //                   });
        //                 },
        //                 child: Text('UPDTE DATA'))
        //           ],
        //         ),
        //       );
        //     } else {
        //       return Container(
        //         child: Text('No Data'),
        //       );
        //     }
        //   },
        // ),
        // child: ElevatedButton(
        //   onPressed: () {
        //     // Navigator.of(context).pushNamed(ChatPage.routeName, arguments: 5);
        //     // if (controller.getLanguage == 'en') {
        //     //   controller.updateLanguage('fa');
        //     // } else {
        //     //   controller.updateLanguage('en');
        //     // }
        //     if (controller.getAppTheme == ThemeMode.light) {
        //       controller.updateAppTheme('dark');
        //     } else {
        //       controller.updateAppTheme('light');
        //     }
        //     BlocProvider.of<AppThemeCubit>(context).toggleLanguage();
        //   },
        //   child: Text(
        //     'Go to chat page',
        //   ),
        // ),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => ChatItemWidget(),
        ),
        // child: Directionality(
        //   textDirection: TextDirection.ltr,
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       GroupChatItem(
        //         messageSender: MessageSender.me,
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
