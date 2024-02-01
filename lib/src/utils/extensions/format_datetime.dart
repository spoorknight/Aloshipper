extension DateTimeVN on DateTime {
  String? get dateTimeToDayOfWeekVN {
    String? dayOfWeek;
    switch (weekday) {
      case DateTime.monday:
        dayOfWeek = "Thứ Hai";
        break;
      case DateTime.tuesday:
        dayOfWeek = "Thứ Ba";
        break;
      case DateTime.wednesday:
        dayOfWeek = "Thứ Tư";
        break;
      case DateTime.thursday:
        dayOfWeek = "Thứ Năm";
        break;
      case DateTime.friday:
        dayOfWeek = "Thứ Sáu";
        break;
      case DateTime.saturday:
        dayOfWeek = "Thứ Bảy";
        break;
      case DateTime.sunday:
        dayOfWeek = "Chủ Nhật";
        break;
    }
    return dayOfWeek;
  }
}
