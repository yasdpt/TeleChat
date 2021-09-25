import 'package:flutter/cupertino.dart';

import '../../features/group_chat/presentation/pages/group_chat_page.dart';
import '../../features/private_chat/presentation/pages/private_chat_page.dart';
import '../../features/contacts/presentation/pages/contacts_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/group_chat/presentation/pages/group_profile_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/settings/presentation/pages/chat_settings_page.dart';
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
    case GroupChatPage.routeName:
      return CupertinoPageRoute(
        builder: (_) => GroupChatPage(),
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
    case ContactsPage.routeName:
      return CupertinoPageRoute(
        builder: (_) => ContactsPage(),
        settings: settings,
      );
    case SearchPage.routeName:
      return CupertinoPageRoute(
        builder: (_) => SearchPage(),
        settings: settings,
      );
    case ProfilePage.routeName:
      return CupertinoPageRoute(
        builder: (_) => ProfilePage(),
        settings: settings,
      );
    case GroupProfilePage.routeName:
      return CupertinoPageRoute(
        builder: (_) => GroupProfilePage(),
        settings: settings,
      );
    case ChatSettingsPage.routeName:
      return CupertinoPageRoute(
        builder: (_) => ChatSettingsPage(),
        settings: settings,
      );
    default:
      return CupertinoPageRoute(
        builder: (_) => HomePage(),
        settings: settings,
      );
  }
}
