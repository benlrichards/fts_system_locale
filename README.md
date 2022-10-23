# fts_system_locale

A flutter plugin to set the system locale. This is companion plugin [flutter_translation_sheet](https://pub.dev/packages/flutter_translation_sheet) package.
| | Android | iOS | Linux | macOS | Web | Windows |
| ----------- | ------- | ---- | ------- | ------ | ----------- | ------- |
| **Support** | SDK 16+ | 9.0+ | Not yet | 10.11+ | Not planned | Not yet |

## Getting Started

run `flutter pub add fts_system_locale` in your project directory.

## Usage

Here is an example with the flutter_translation_sheet package.

```dart
DropdownButton<Locale>(
  items: AppLocales.supportedLocales
      .map((e) => DropdownMenuItem(value: e, child: Text
      .toList(),
  onChanged: (value) {
    if (value != null) {
      Fts.locale = value;
      FtsSystemLocale().setLocale(value.languageCode).
    }
  },
  value: Fts.locale,
),
```

check the example dir for a complete example.

## Configuration

### Android

For Android 13+ "per-app-language" support. Follow https://developer.android.com/guide/topics/resources/app-languages#app-language-settings

Others need no extra configuration.
