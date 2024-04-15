class TimeServ{
  static int get now {
    final DateTime time = DateTime.now().toLocal();
    return ((time.year%100) << 20) + (time.month << 16) + (time.day << 11) + (time.hour << 6) + time.minute;
  }

  static int fromDateTime(DateTime time){
    return ((time.year%100) << 20) + (time.month << 16) + (time.day << 11) + (time.hour << 6) + time.minute;
  }

  static DateTime toDateTime(int time){
    return DateTime(
      time >> 20 + 2000,
      (time >> 16) & 0xF,
      (time >> 11) & 0X1F,
      (time >> 6) & 0x1F,
      time & 0x3F,
      0,
      0,
      0,
    );
  }

  /// year -> 7       20
  /// month -> 4      16
  /// day -> 5        11
  /// hour -> 5       6
  /// minutes -> 6    0
  /// TOTAL = 27
  /// 
  /// xxxx x000 0000 1111 0000 0111 1100 0000

  static String timeToString(int time){
    //        year                                      month                                                 day                    hour                                           minute
    return '${(time >> 20).toString().padLeft(2, '0')}-${((time >> 16) & 0xF).toString().padLeft(2, '0')}-${((time>>11) & 0x1F)} ${((time>>6) & 0x1F).toString().padLeft(2, '0')}:${(time & 0x3F).toString().padLeft(2, '0')}';
  }

  static int nextDayOfChange(int time){
    DateTime date = toDateTime(time).copyWith(minute: 0, hour: 0);
    return fromDateTime(date.add(Duration(days: 8 - date.weekday)));
  }
}
