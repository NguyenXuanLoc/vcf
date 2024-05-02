// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:convert';
import 'dart:ui';

import 'package:base_bloc/utils/log_utils.dart';
import 'package:easy_localization/easy_localization.dart' show AssetLoader;
import 'package:flutter/services.dart';

class Applocalizations extends AssetLoader {
  const Applocalizations();

  static const enCode = 'en';

  static const languageCode = {
    enCode: 'eng',
  };

  static const localeEn = Locale(enCode);

  static const List<Locale> supportedLocales = <Locale>[
    localeEn,
  ];

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) async {
    var locales = await getLocales();
    return Future.value(locales[locale.toString()]);
  }

  Future<Map<String, dynamic>> getLanguage(String fileName) async {
    String str =
        await rootBundle.loadString('assets/translations/$fileName.json');
    return json.decode(str);
  }

  Future<Map<String, Map<String, dynamic>>> getLocales() async {
    var englishLanguage = await getLanguage(enCode);

    return {
      enCode: englishLanguage,
    };
  }
}
