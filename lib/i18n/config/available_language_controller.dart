import 'package:flutter/material.dart';

import 'available_language.dart';

class LanguageController extends ValueNotifier<AvailableLanguage> {
  LanguageController()
      : super(
          AvailableLanguage(
            name: 'Português do Brasil',
            flag: '🇧🇷',
            locale: const Locale('pt', 'BR'),
          ),
        );

  setLanguage({
    required AvailableLanguage language,
  }) {
    value = language;
  }
}
