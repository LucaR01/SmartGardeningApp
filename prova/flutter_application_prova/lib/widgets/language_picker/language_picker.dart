import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_prova/l10n/languages.dart';
import 'package:flutter_application_prova/provider/locale_provider.dart';

class LanguagePickerWidget extends StatelessWidget {
  const LanguagePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: locale,
        icon: Container(width: 12),
        items: Languages.languages.map(
          (locale) {
            final flag = Languages.getFlag(locale.languageCode);
            
            return DropdownMenuItem(
              child: Center(
                child: Text(
                  flag,
                  style: TextStyle(fontSize: 32),
                ),
              ),
              value: locale,
              onTap: () {
                final provider = Provider.of<LocaleProvider>(context, listen: false);
                provider.setLocale(locale);
              },
            );
          }
        ).toList(),
      onChanged: (_) {},
      ),
    );
  }
}