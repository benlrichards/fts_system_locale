import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fts_system_locale/fts_system_locale.dart';
import 'package:fts_system_locale/i18n/i18n.dart';
import 'package:fts_system_locale/i18n/utils.dart';

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
  String? locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [Fts.delegate],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  if (locale == null) {
                    Fts.locale = const Locale('bn');
                    FtsSystemLocale().setLocale('bn').then(debugPrint);
                    locale = 'bn';
                  } else {
                    Fts.locale = const Locale('en');
                    FtsSystemLocale().setLocale().then(debugPrint);
                    locale = null;
                  }
                  // FtsSystemLocale().getPlatformVersion().then(debugPrint);
                },
                child: Text(Strings.home.changeLocale.tr()),
              ),
              TextButton(
                onPressed: () => methodChannel
                    .invokeMethod('navigateToActivity')
                    .then((value) => debugPrint(value.toString())),
                child: const Text('Navigate to android activity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
