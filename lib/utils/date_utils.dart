import 'package:intl/intl.dart';

class DateUtils {
  static String format(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
}
