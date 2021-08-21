class TimeUtil {
  static String getChatTime(DateTime time) {
    String hour = time.hour < 10 ? '0${time.hour}' : '${time.hour}';
    String minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';

    return '$hour:$minute';
  }

  static DateTime convertDateToLocal(String date) {
    return DateTime.parse(date + 'Z').toLocal();
  }
}
