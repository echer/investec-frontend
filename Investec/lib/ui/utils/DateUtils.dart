import 'package:intl/intl.dart';

class DateUtils {
  static strToDateIso8601(String value) {
    DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    DateTime parsed = formatter.parse(value).toLocal();
    return parsed.toIso8601String();
  }

  static dateToStr(DateTime value) {
    DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    final String formatted = formatter.format(value);
    return formatted;
  }

  static strIso8601ToStr(String value) {
    DateTime now = DateTime.parse(value).toLocal();
    return dateToStr(now);
  }
}
