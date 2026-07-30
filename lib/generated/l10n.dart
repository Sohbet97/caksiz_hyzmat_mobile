// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Esasy`
  String get home {
    return Intl.message('Esasy', name: 'home', desc: '', args: []);
  }

  /// `Kategoriýa`
  String get category {
    return Intl.message('Kategoriýa', name: 'category', desc: '', args: []);
  }

  /// `Profil`
  String get person {
    return Intl.message('Profil', name: 'person', desc: '', args: []);
  }

  /// `Sebet`
  String get korzina {
    return Intl.message('Sebet', name: 'korzina', desc: '', args: []);
  }

  /// `Kategoriýalar ýok`
  String get categoriesEmpty {
    return Intl.message(
      'Kategoriýalar ýok',
      name: 'categoriesEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Похоже, здесь пока пусто. Попробуйте обновить страницу позже`
  String get categoryEmptyDesc {
    return Intl.message(
      'Похоже, здесь пока пусто. Попробуйте обновить страницу позже',
      name: 'categoryEmptyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Täzelemek`
  String get retry {
    return Intl.message('Täzelemek', name: 'retry', desc: '', args: []);
  }

  /// `Ählisi`
  String get all {
    return Intl.message('Ählisi', name: 'all', desc: '', args: []);
  }

  /// `Haryt gözleg`
  String get search {
    return Intl.message('Haryt gözleg', name: 'search', desc: '', args: []);
  }

  /// `Arzalnaşyklar`
  String get skidki {
    return Intl.message('Arzalnaşyklar', name: 'skidki', desc: '', args: []);
  }

  /// `Täze goşulanlar`
  String get news_added {
    return Intl.message(
      'Täze goşulanlar',
      name: 'news_added',
      desc: '',
      args: [],
    );
  }

  /// `Mugt dostawkalar`
  String get mugt_dostawkalar {
    return Intl.message(
      'Mugt dostawkalar',
      name: 'mugt_dostawkalar',
      desc: '',
      args: [],
    );
  }

  /// `Günüň arzanlaşygy`
  String get gunun_arzanlasygy {
    return Intl.message(
      'Günüň arzanlaşygy',
      name: 'gunun_arzanlasygy',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
