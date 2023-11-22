import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toHumanDate() {
    final f = DateFormat('dd \'de\' MMMM \'de\' y', 'pt_BR');
    return f.format(this);
  }
}
