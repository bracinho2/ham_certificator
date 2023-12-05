import 'package:flutter/material.dart';

class AvailableLanguage {
  final String name;
  final String flag;
  final Locale locale;

  AvailableLanguage({
    required this.name,
    required this.flag,
    required this.locale,
  });
  static final languageList = [
    AvailableLanguage(
      name: 'Português do Brasil',
      flag: '🇧🇷',
      locale: const Locale('pt', 'BR'),
    ),
    AvailableLanguage(
      name: 'Español del Argentina',
      flag: '🇦🇷',
      locale: const Locale('es', 'AR'),
    ),
    AvailableLanguage(
      name: 'Español del Paraguay',
      flag: '🇵🇾',
      locale: const Locale('es', 'PY'),
    ),
  ];
}
