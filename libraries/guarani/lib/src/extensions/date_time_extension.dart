import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toHumanDate() {
    final f = DateFormat('dd \'de\' MMMM \'de\' y', 'pt_BR');
    return f.format(this);
  }

  String getMonthNameAbreviation() {
    const List<String> monthAbbreviations = [
      '',
      'JAN',
      'FEV',
      'MAR',
      'ABR',
      'MAI',
      'JUN',
      'JUL',
      'AGO',
      'SET',
      'OUT',
      'NOV',
      'DEZ'
    ];
    return monthAbbreviations[month];
  }
}
