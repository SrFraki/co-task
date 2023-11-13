
import 'package:intl/intl.dart';

class TimeService{
  static DateTime get lastWeekMon{
    final date = DateTime.now();
    return toDateTimeFormat(toStringFormat(date.subtract(Duration(days: date.weekday - 1))));
  }

  static bool compare(DateTime dbMon, DateTime lastMon) => dbMon.compareTo(lastMon)<0;


  static String toStringFormat(DateTime date) => DateFormat("yyyy-MM-dd").format(date);

  static toDateTimeFormat(String date) => DateTime.parse(date);
}