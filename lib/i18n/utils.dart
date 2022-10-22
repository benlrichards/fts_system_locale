import 'i18n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class Fts {
  static const List<String> _rtlLanguages = <String>[
    'ar',
    'fa',
    'he',
    'ps',
    'ur'
  ];

  static const FtsDelegate delegate = FtsDelegate();

  static WidgetsBinding get _binding =>
      WidgetsFlutterBinding.ensureInitialized();
  static bool useMasterTextAsKey = false;
  static Map<String, Map<String, String>> get _translations {
    if (kDebugMode) {
      // reactive to hot reload.
      return !useMasterTextAsKey
          ? Translations.getByKeys()
          : Translations.getByText();
    } else {
      // required for hot restart.
      return !useMasterTextAsKey ? Translations.byKeys : Translations.byText;
    }
  }

  static Locale? _locale;

  static late Locale fallbackLocale;

  static final onSystemLocaleChanged = ValueNotifier(
    deviceLocale,
  );

  static final onLocaleChanged = ValueNotifier(
    AppLocales.supportedLocales.first,
  );

  static TextDirection get textDirection => _textDirection;

  static Locale get locale {
    return _locale ?? AppLocales.supportedLocales.first;
  }

  static var _textDirection = TextDirection.ltr;

  static set locale(Locale value) {
    value = _safeLocale(value);
    if (!AppLocales.supportedLocales.contains(value)) {
      return;
    }
    _locale = value;
    _textDirection = _rtlLanguages.contains(value.languageCode)
        ? TextDirection.rtl
        : TextDirection.ltr;
    onLocaleChanged.value = _locale!;

    _notifyUpdate();
  }

  static void _notifyUpdate() {
    _binding.addPostFrameCallback((timeStamp) {
      _binding.performReassemble();
    });
  }

  static String tr(
    String key, {
    Map<String, Object>? namedArgs,
    List<Object>? args,
  }) {
    if (Fts._locale == null) {
      init();
    }
    late String text;
    final map = _translations;
    if (hasTr(key)) {
      text = map['$_locale']![key]!;
    } else {
      var fallback = '$fallbackLocale';
      if (map.containsKey(fallback)) {
        text = map[fallback]![key] ?? key;
      } else {
        text = key;
      }
    }

    if (text.contains('@:')) {
      RegExp(r'@:(\S+)').allMatches(text).forEach((match) {
        final toReplace = match.group(0)!;
        final findKey = match.group(1)!;
        if (!hasTr(findKey)) {
          print('Fts, linked key not found: $findKey');
        } else {
          text = text.replaceAll(toReplace, findKey.tr());
        }
      });
    }

    if (namedArgs != null && namedArgs.isNotEmpty) {
      namedArgs.forEach((key, value) {
        // text = text.replaceAll('{$key}', '$value');
        text = text.replaceAll('{$key}', '$value');
      });
    }

    if (args != null && args.isNotEmpty) {
      for (final a in args) {
        text = text.replaceFirst(RegExp(r'%s'), '$a');
      }
    }
    return text;
  }

  static bool hasTr(String key) {
    final map = _translations;
    return map['$_locale']?.containsKey(key) == true;
  }

  static void init({
    Locale? locale,
    Locale? fallbackLocale,
  }) {
    final originalCallback = _binding.platformDispatcher.onLocaleChanged;
    _binding.platformDispatcher.onLocaleChanged = () {
      originalCallback?.call();
      onSystemLocaleChanged.value = _binding.platformDispatcher.locale;
    };

    Fts.fallbackLocale = fallbackLocale ?? AppLocales.supportedLocales.first;

    locale ??= deviceLocale;
    Fts.locale = locale;
  }

  static Locale get deviceLocale => _binding.platformDispatcher.locale;

  // only support country code for now.
  static Locale _safeLocale(Locale value) {
    var clean = value;
    if (value.countryCode != null) {
      clean = Locale(value.languageCode);
    }
    return clean;
  }
}

extension FtsStringExtension on String {
  String tr({
    Map<String, Object>? namedArgs,
    List<Object>? args,
  }) =>
      Fts.tr(this, namedArgs: namedArgs, args: args);
}

/// Use `MaterialApp.localizationsDelegates: const [FtsDelegate()],`
/// Basic delegate for TextDirection
class _FtsLocalization implements WidgetsLocalizations {
  const _FtsLocalization();

  @override
  TextDirection get textDirection => Fts.textDirection;
}

class FtsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  final localization = const _FtsLocalization();

  const FtsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<WidgetsLocalizations> load(Locale locale) async => localization;

  @override
  bool shouldReload(FtsDelegate old) => false;
}
