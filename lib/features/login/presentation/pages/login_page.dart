import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login/SignUp'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Card(
          shape: RoundedRectangleBorder(),
        ),
      ),
    );
  }
}
