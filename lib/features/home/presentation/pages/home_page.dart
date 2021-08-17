import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase/supabase.dart';

import '../../../../core/consts/app_config.dart';
import '../../../../core/cubit/app_theme_cubit.dart';
import '../../../../core/utils/get_shared_pref.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SupabaseClient client;
  @override
  void initState() {
    super.initState();
    client = SupabaseClient(AppConfig.supaBaseUrl, AppConfig.supaBaseKey);
  }

  // Future<void> getUsers() async {
  //   final response =
  //       await client.auth.signUp('fouladiyasin@gmail.com', 'yasin1234');
  //   print(response.error.message);
  //   final response2 = await client
  //       .from('messages')
  //       .select()
  //       .order('name', ascending: true)
  //       .execute();
  //   final response3 = await client.storage.createBucket('photos');
  //   final path = await _localPath;
  //   final file = File('$path/justafile.txt');
  //   file.writeAsStringSync('File content yas');
  //   final storageResponse =
  //       await client.storage.from('chatimages').upload('justafile.txt', file);
  //   print(storageResponse.data.toString());
  // }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SharedPrefController());
    //getUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
          style: TextStyle(color: Colors.white),
        ),
        // systemOverlayStyle:
        //     SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white),
      ),
      body: Center(
        // child: StreamBuilder(
        //   stream: client.from('messages').stream().limit(30).execute(),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     // print(snapshot.connectionState);
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return CircularProgressIndicator();
        //     } else {
        //       if (snapshot.hasData) {
        //         List<Map<String, dynamic>> listOfItems = snapshot.data;
        //         return Container(
        //           padding: const EdgeInsets.all(32.0),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Expanded(
        //                 child: ListView.builder(
        //                   itemCount: listOfItems.length,
        //                   itemBuilder: (context, index) =>
        //                       Text(listOfItems[index]['msg']),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         );
        //       } else {
        //         return Container(
        //           child: Text('No Data'),
        //         );
        //       }
        //     }
        //   },
        // ),
        child: ElevatedButton(
          onPressed: () {
            // Navigator.of(context).pushNamed(ChatPage.routeName, arguments: 5);
            if (controller.getAppTheme == ThemeMode.light) {
              controller.updateAppTheme('dark');
            } else {
              controller.updateAppTheme('light');
            }
            BlocProvider.of<AppThemeCubit>(context).toggleTheme();
          },
          child: Text(
            'Go to chat page',
          ),
        ),
      ),
    );
  }
}
