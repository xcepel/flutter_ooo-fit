class DateNormalize {
  final DateTime date;

  const DateNormalize(this.date);

  DateTime normalize() {
    return DateTime(date.year, date.month, date.day);
  }
}
