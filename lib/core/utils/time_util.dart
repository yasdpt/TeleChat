import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shamsi_date/shamsi_date.dart';

class TimeUtil {
  static String getChatTime(DateTime time) {
    String hour = time.hour < 10 ? '0${time.hour}' : '${time.hour}';
    String minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';

    return '$hour:$minute';
  }

  static DateTime convertDateToLocal(String date) {
    return DateTime.parse(date + 'Z').toLocal();
  }

  static String getDateString(AppLocalizations locale, DateTime time) {
    Jalali jDate = Gregorian.fromDateTime(time).toJalali();
    return '${jDate.day} ${_getMonthStr(locale, jDate.month)}';
  }

  static String _getMonthStr(AppLocalizations locale, int month) {
    switch (month) {
      case 1:
        return locale.farvardin;
      case 2:
        return locale.ordibehesht;
      case 3:
        return locale.khordad;
      case 4:
        return locale.tir;
      case 5:
        return locale.mordad;
      case 6:
        return locale.shahrivar;
      case 7:
        return locale.mehr;
      case 8:
        return locale.aban;
      case 9:
        return locale.azar;
      case 10:
        return locale.dey;
      case 11:
        return locale.bahman;
      case 12:
        return locale.esfand;
      default:
        return '';
    }
  }

  String _getDayStr(AppLocalizations locale, int day) {
    switch (day) {
      case 1:
        return locale.saturday;
      case 2:
        return locale.sunday;
      case 3:
        return locale.monday;
      case 4:
        return locale.tuesday;
      case 5:
        return locale.wednesday;
      case 6:
        return locale.thursday;
      case 7:
        return locale.friday;
      default:
        return '';
    }
  }
}
