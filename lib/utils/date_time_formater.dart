import 'package:intl/intl.dart';

class DateTimeFormatter {
  final DateTime date;

  const DateTimeFormatter(this.date);

  String format() {
    final String formattedDate =
        DateFormat('EEEE, dd. MMMM yyyy, HH:mm').format(date);
    return formattedDate;
  }
}
