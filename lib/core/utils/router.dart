import 'package:flutter/cupertino.dart';

import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return CupertinoPageRoute(
        builder: (_) => HomePage(),
        settings: settings,
      );
    case ChatPage.routeName:
      return CupertinoPageRoute(
        builder: (_) => ChatPage(),
        settings: settings,
      );
    default:
      return CupertinoPageRoute(
        builder: (_) => HomePage(),
        settings: settings,
      );
  }
}
