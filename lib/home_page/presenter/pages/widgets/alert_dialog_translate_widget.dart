import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

import '../../../../i18n/config/available_language.dart';
import '../../../../i18n/config/available_language_controller.dart';

class ModalTranslateWidget extends StatefulWidget {
  const ModalTranslateWidget({super.key});

  @override
  State<ModalTranslateWidget> createState() => _ModalTranslateWidgetState();
}

AvailableLanguage dropdownValue = AvailableLanguage.languageList.first;

final _languageController = GetIt.I.get<LanguageController>();

class _ModalTranslateWidgetState extends State<ModalTranslateWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'select-language'.i18n(),
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: SizedBox(
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...AvailableLanguage.languageList
                .map((l) => InkWell(
                      onTap: () {
                        _languageController.setLanguage(language: l);
                        context.go('/');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(l.flag),
                            Text(l.name),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
