import 'package:intl/intl.dart';

String dateFormatter(DateTime date, {String? format}) {
  final DateTime now = date;
  final formattedDate = DateFormat(format ?? 'dd-MM-yyyy hh:mm').format(now);

  return formattedDate;
}
