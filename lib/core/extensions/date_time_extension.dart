import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toHumanDate({
    required Locale locale,
  }) {
    switch (locale.toLanguageTag()) {
      case 'pt-BR':
        final f = DateFormat('dd \'de\' MMMM \'de\' y', locale.toLanguageTag());
        return f.format(this);

      case 'es-PY':
        final f = DateFormat('dd \'de\' MMMM \'de\' y', locale.toLanguageTag());
        return f.format(this);

      case 'es-AR':
        final f = DateFormat('dd \'de\' MMMM \'de\' y', locale.toLanguageTag());
        return f.format(this);

      default:
        final f = DateFormat('dd \'-\' MMMM \'-\' y', locale.toLanguageTag());
        return f.format(this);
    }
  }
}
