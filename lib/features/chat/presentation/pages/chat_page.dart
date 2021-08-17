import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = '/chatPage';
  const ChatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final num = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: Text('CHAT PAGE $num'),
      ),
    );
  }
}
