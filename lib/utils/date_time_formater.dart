import 'package:intl/intl.dart';

class DateTimeFormatter {
  final DateTime date;

  const DateTimeFormatter(this.date);

  String formatDate() {
    return DateFormat('EEEE, dd. MMMM yyyy, HH:mm').format(date);
  }

  String formatTime() {
    return DateFormat('HH:mm').format(date);
  }
}
