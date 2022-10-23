import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fts_system_locale/fts_system_locale.dart';

import 'i18n/i18n.dart';

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
  void initState() {
    super.initState();
    Fts.onSystemLocaleChanged.addListener(() {
      setState(() {
        Fts.locale = Fts.onSystemLocaleChanged.value;
      });
    });
  }

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
        appBar: AppBar(title: Text(Strings.home.title.tr())),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<Locale>(
                items: AppLocales.supportedLocales
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.languageCode)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    Fts.locale = value ?? Fts.deviceLocale;
                  });
                  FtsSystemLocale().setLocale(value?.languageCode);
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
