import 'package:flutter/cupertino.dart';

import '../../features/chat/presentation/pages/private_chat_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/settings/presentation/pages/language_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return CupertinoPageRoute(
        builder: (_) => HomePage(),
        settings: settings,
      );
    case PrivateChatPage.routeName:
      return CupertinoPageRoute(
        builder: (_) => PrivateChatPage(),
        settings: settings,
      );
    case PrivateChatPage.routeName:
      return CupertinoPageRoute(
        builder: (_) => PrivateChatPage(),
        settings: settings,
      );
    case SettingsPage.routeName:
      return CupertinoPageRoute(
        builder: (_) => SettingsPage(),
        settings: settings,
      );
    case LanguagePage.routeName:
      return CupertinoPageRoute(
        builder: (_) => LanguagePage(),
        settings: settings,
      );
    default:
      return CupertinoPageRoute(
        builder: (_) => HomePage(),
        settings: settings,
      );
  }
}
