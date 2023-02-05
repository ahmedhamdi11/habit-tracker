//return today date formatted as yyyymmdd
String todayDateFormatted() {
  DateTime dateTimeObject = DateTime.now();
  String year = dateTimeObject.year.toString();
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}

//convert String yyyymmdd to dateTime object
DateTime createDateTimeToObject(String yyyymmdd) {
  int dd = int.parse(yyyymmdd.substring(6, 8));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  DateTime dateTimeObject = DateTime(yyyy, mm, dd);
  return dateTimeObject;
}

//convert dateTime object tot String yyymmdd
String convertDateTimeToString(DateTime dateTime) {
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}
