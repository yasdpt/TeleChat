import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

import '../../../../core/consts/app_config.dart';

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
    client = SupabaseClient(
      AppConfig.supaBaseUrl,
      AppConfig.supaBaseKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chats'),
        brightness: Brightness.dark,
      ),
      body: Center(
        child: StreamBuilder(
          stream: client.from('users').stream().limit(30).execute(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (snapshot.hasData) {
                List<Map<String, dynamic>> listOfItems = snapshot.data;
                return Container(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: listOfItems.length,
                          itemBuilder: (context, index) =>
                              Text(listOfItems[index]['username']),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  child: Text('No Data'),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
