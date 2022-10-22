import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fts_system_locale/fts_system_locale.dart';

import 'i18n/i18n.dart';
import 'i18n/translations.dart';
import 'i18n/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

const methodChannel = MethodChannel('com.example.example');

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        Fts.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocales.supportedLocales,
      home: Scaffold(
        appBar: AppBar(
          title: Text(Strings.home.title.tr()),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextButton(
              //   onPressed: () {
              //     if (locale == null) {
              //       Fts.locale = const Locale('bn');
              //       FtsSystemLocale().setLocale('bn').then(debugPrint);
              //       locale = 'bn';
              //     } else {
              //       Fts.locale = const Locale('en');
              //       FtsSystemLocale().setLocale().then(debugPrint);
              //       locale = null;
              //     }
              //     // FtsSystemLocale().getPlatformVersion().then(debugPrint);
              //   },
              //   child: Text(Strings.home.changeLocale.tr()),
              // ),

              DropdownButton<Locale>(
                items: AppLocales.supportedLocales
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.languageCode)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    Fts.locale = value;
                    FtsSystemLocale().setLocale(value.languageCode).then(debugPrint);
                  }
                },
                value: Fts.locale,
              ),
              TextButton(
                onPressed: () => methodChannel
                    .invokeMethod('navigateToActivity')
                    .then((value) => debugPrint(value.toString())),
                child: Text(Strings.home.navigateTo.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
