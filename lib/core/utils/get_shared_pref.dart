import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../consts/app_consts.dart';

class SharedPrefController extends GetxController {
  final box = GetStorage();

  String get getLanguage => box.read(sLanguageKey) ?? 'en';
  void updateLanguage(String language) => box.write(sLanguageKey, language);

  ThemeMode get getAppTheme {
    if (box.read(sAppThemeKey) == null) {
      return ThemeMode.light;
    } else {
      if (box.read(sAppThemeKey) == 'light') {
        return ThemeMode.light;
      } else {
        return ThemeMode.dark;
      }
    }
  }

  void updateAppTheme(String val) => box.write(sAppThemeKey, val);

  // String get getUserId => box.read(kUserId) ?? '';
  // void updateUserId(String val) => box.write(kUserId, val);

  // double get getAccountBalance => box.read(kAccountBalance) ?? 0.0;
  // void updateAccountBalance(double val) => box.write(kAccountBalance, val);

  // bool get getIsLoggedIn => box.read(kIsLoggedIn) ?? false;
  // void updateIsLoggedIn(bool val) => box.write(kIsLoggedIn, val);

  // String get getAccountBalanceFormatted =>
  //     box.read(kAccountBalanceFormatted) ?? '';
  // void updateAccountBalanceFormatted(String val) =>
  //     box.write(kAccountBalanceFormatted, val);

  // String get getEmail => box.read(kEmail) ?? '';
  // void updateEmail(String val) => box.write(kEmail, val);

  // String get getBio => box.read(kBio) ?? '';
  // void updateBio(String val) => box.write(kBio, val);

  // String get getPhoneNumber => box.read(kPhoneNumber) ?? '';
  // void updatePhoneNumber(String val) => box.write(kPhoneNumber, val);

  // String get getFullName => box.read(kFullName) ?? '';
  // void updateFullName(String val) => box.write(kFullName, val);

  // int get getRoundedScore => box.read(kRoundedScore) ?? 0;
  // void updateRoundedScore(int score) => box.write(kRoundedScore, score);

  // String get getImageAddress => box.read(kUserImageAddress) ?? '';
  // void updateImageAddress(String val) => box.write(kUserImageAddress, val);

  // String get getAdTrackId => box.read(kAdTrackId) ?? '';
  // void updateAdTrackId(String trackId) => box.write(kAdTrackId, trackId);

  // String get getLastCompleteStep => box.read(kLastCompleteStep) ?? 0;
  // void updateLastCompleteStep(num lastCompleteStep) => box.write(
  //       kLastCompleteStep,
  //       lastCompleteStep,
  //     );
}
