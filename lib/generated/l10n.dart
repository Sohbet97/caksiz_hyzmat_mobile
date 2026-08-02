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

  /// `Iň gowy tejribe üçin içeri giriň`
  String get personLoginTitle {
    return Intl.message(
      'Iň gowy tejribe üçin içeri giriň',
      name: 'personLoginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Içeri giriň / Agza Boluň`
  String get personLoginButton {
    return Intl.message(
      'Içeri giriň / Agza Boluň',
      name: 'personLoginButton',
      desc: '',
      args: [],
    );
  }

  /// `Sargytlarym`
  String get personOrders {
    return Intl.message(
      'Sargytlarym',
      name: 'personOrders',
      desc: '',
      args: [],
    );
  }

  /// `Habarlar`
  String get personMessages {
    return Intl.message('Habarlar', name: 'personMessages', desc: '', args: []);
  }

  /// `Halanlarym`
  String get personCoupons {
    return Intl.message(
      'Halanlarym',
      name: 'personCoupons',
      desc: '',
      args: [],
    );
  }

  /// `Kuponlarym`
  String get personBalance {
    return Intl.message(
      'Kuponlarym',
      name: 'personBalance',
      desc: '',
      args: [],
    );
  }

  /// `Sazlamalar`
  String get personSettings {
    return Intl.message(
      'Sazlamalar',
      name: 'personSettings',
      desc: '',
      args: [],
    );
  }

  /// `Goldaw`
  String get personSupport {
    return Intl.message('Goldaw', name: 'personSupport', desc: '', args: []);
  }

  /// `Okuwlar`
  String get personReviews {
    return Intl.message('Okuwlar', name: 'personReviews', desc: '', args: []);
  }

  /// `Görenlerim`
  String get personHistory {
    return Intl.message(
      'Görenlerim',
      name: 'personHistory',
      desc: '',
      args: [],
    );
  }

  /// `Salgylar`
  String get personAddresses {
    return Intl.message(
      'Salgylar',
      name: 'personAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Yzarlanýanlar`
  String get personFollowing {
    return Intl.message(
      'Yzarlanýanlar',
      name: 'personFollowing',
      desc: '',
      args: [],
    );
  }

  /// `Mugt eltip bermek`
  String get personFreeShipping {
    return Intl.message(
      'Mugt eltip bermek',
      name: 'personFreeShipping',
      desc: '',
      args: [],
    );
  }

  /// `Mugt yzyna gaýtarmak`
  String get personFreeReturn {
    return Intl.message(
      'Mugt yzyna gaýtarmak',
      name: 'personFreeReturn',
      desc: '',
      args: [],
    );
  }

  /// `90 güne çenli`
  String get personFreeReturnDesc {
    return Intl.message(
      '90 güne çenli',
      name: 'personFreeReturnDesc',
      desc: '',
      args: [],
    );
  }

  /// `Ynanylmaz`
  String get personFreeShippingDesc {
    return Intl.message(
      'Ynanylmaz',
      name: 'personFreeShippingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Kargo`
  String get personKargo {
    return Intl.message('Kargo', name: 'personKargo', desc: '', args: []);
  }

  /// `Sazlamalar`
  String get settingsTitle {
    return Intl.message(
      'Sazlamalar',
      name: 'settingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Içeri gir / Agza bol`
  String get settingsLogin {
    return Intl.message(
      'Içeri gir / Agza bol',
      name: 'settingsLogin',
      desc: '',
      args: [],
    );
  }

  /// `Ýurt we sebit`
  String get settingsCountryRegion {
    return Intl.message(
      'Ýurt we sebit',
      name: 'settingsCountryRegion',
      desc: '',
      args: [],
    );
  }

  /// `Dil`
  String get settingsLanguage {
    return Intl.message('Dil', name: 'settingsLanguage', desc: '', args: []);
  }

  /// `Pul birligi`
  String get settingsCurrency {
    return Intl.message(
      'Pul birligi',
      name: 'settingsCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Bildirişler`
  String get settingsNotifications {
    return Intl.message(
      'Bildirişler',
      name: 'settingsNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Gizlinlik`
  String get settingsPrivacy {
    return Intl.message(
      'Gizlinlik',
      name: 'settingsPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Rugsatlar`
  String get settingsPermissions {
    return Intl.message(
      'Rugsatlar',
      name: 'settingsPermissions',
      desc: '',
      args: [],
    );
  }

  /// `Howpsuzlyk merkezi`
  String get settingsSecurityCenter {
    return Intl.message(
      'Howpsuzlyk merkezi',
      name: 'settingsSecurityCenter',
      desc: '',
      args: [],
    );
  }

  /// `Bu programma barada`
  String get settingsAboutApp {
    return Intl.message(
      'Bu programma barada',
      name: 'settingsAboutApp',
      desc: '',
      args: [],
    );
  }

  /// `Biz bilen habarlaşyň`
  String get settingsContactUs {
    return Intl.message(
      'Biz bilen habarlaşyň',
      name: 'settingsContactUs',
      desc: '',
      args: [],
    );
  }

  /// `Aragatnaşyk`
  String get settingsContact {
    return Intl.message(
      'Aragatnaşyk',
      name: 'settingsContact',
      desc: '',
      args: [],
    );
  }

  /// `Hukuk şertleri we syýasatlar`
  String get settingsLegal {
    return Intl.message(
      'Hukuk şertleri we syýasatlar',
      name: 'settingsLegal',
      desc: '',
      args: [],
    );
  }

  /// `Bu programmany paýlaş`
  String get settingsShareApp {
    return Intl.message(
      'Bu programmany paýlaş',
      name: 'settingsShareApp',
      desc: '',
      args: [],
    );
  }

  /// `ÇÄKSIZ HYZMATLAR`
  String get authTitle {
    return Intl.message(
      'ÇÄKSIZ HYZMATLAR',
      name: 'authTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ähli maglumatlaryňyz goralýar`
  String get authSecureNote {
    return Intl.message(
      'Ähli maglumatlaryňyz goralýar',
      name: 'authSecureNote',
      desc: '',
      args: [],
    );
  }

  /// `Google bilen dowam et`
  String get authGoogleContinue {
    return Intl.message(
      'Google bilen dowam et',
      name: 'authGoogleContinue',
      desc: '',
      args: [],
    );
  }

  /// `E-poçta bilen dowam et`
  String get authEmailContinue {
    return Intl.message(
      'E-poçta bilen dowam et',
      name: 'authEmailContinue',
      desc: '',
      args: [],
    );
  }

  /// `Telefon belgisi bilen dowam et`
  String get authPhoneContinue {
    return Intl.message(
      'Telefon belgisi bilen dowam et',
      name: 'authPhoneContinue',
      desc: '',
      args: [],
    );
  }

  /// `Içeri girmekde kynçylyk çekýärsiňizmi?`
  String get authTroubleLogin {
    return Intl.message(
      'Içeri girmekde kynçylyk çekýärsiňizmi?',
      name: 'authTroubleLogin',
      desc: '',
      args: [],
    );
  }

  /// `Dowam etmek bilen`
  String get authTermsPrefix {
    return Intl.message(
      'Dowam etmek bilen',
      name: 'authTermsPrefix',
      desc: '',
      args: [],
    );
  }

  /// `Ulanyş şertlerini`
  String get authTermsOfUse {
    return Intl.message(
      'Ulanyş şertlerini',
      name: 'authTermsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `we`
  String get authAnd {
    return Intl.message('we', name: 'authAnd', desc: '', args: []);
  }

  /// `Gizlinlik syýasatyny`
  String get authPrivacyPolicy {
    return Intl.message(
      'Gizlinlik syýasatyny',
      name: 'authPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `okandygyňyzy tassyklaýarsyňyz.`
  String get authTermsSuffix {
    return Intl.message(
      'okandygyňyzy tassyklaýarsyňyz.',
      name: 'authTermsSuffix',
      desc: '',
      args: [],
    );
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

  /// `Çäksiz Hyzmat`
  String get AppName {
    return Intl.message('Çäksiz Hyzmat', name: 'AppName', desc: '', args: []);
  }

  /// `Ynam Sizden`
  String get ynam_sizden {
    return Intl.message('Ynam Sizden', name: 'ynam_sizden', desc: '', args: []);
  }

  /// `Netije Bizden`
  String get netije_bizden {
    return Intl.message(
      'Netije Bizden',
      name: 'netije_bizden',
      desc: '',
      args: [],
    );
  }

  /// `Okuwlar`
  String get schools {
    return Intl.message('Okuwlar', name: 'schools', desc: '', args: []);
  }

  /// `Okuwlardan gözleg...`
  String get searchSchoolsHint {
    return Intl.message(
      'Okuwlardan gözleg...',
      name: 'searchSchoolsHint',
      desc: '',
      args: [],
    );
  }

  /// `Не удалось загрузить учебные заведения`
  String get schoolsLoadError {
    return Intl.message(
      'Не удалось загрузить учебные заведения',
      name: 'schoolsLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Okuwlar tapylmady`
  String get noSchoolsFound {
    return Intl.message(
      'Okuwlar tapylmady',
      name: 'noSchoolsFound',
      desc: '',
      args: [],
    );
  }

  /// `Häzirki wagta ulgama goşulan okuwlar tapylmady`
  String get noSchoolsFoundDEsc {
    return Intl.message(
      'Häzirki wagta ulgama goşulan okuwlar tapylmady',
      name: 'noSchoolsFoundDEsc',
      desc: '',
      args: [],
    );
  }

  /// `Что-то пошло не так`
  String get errorSchool {
    return Intl.message(
      'Что-то пошло не так',
      name: 'errorSchool',
      desc: '',
      args: [],
    );
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

  /// `Kargo`
  String get cargo {
    return Intl.message('Kargo', name: 'cargo', desc: '', args: []);
  }

  /// `Brendler`
  String get brands {
    return Intl.message('Brendler', name: 'brands', desc: '', args: []);
  }

  /// `Top harytlar`
  String get top_products {
    return Intl.message(
      'Top harytlar',
      name: 'top_products',
      desc: '',
      args: [],
    );
  }

  /// `Aksiýalar`
  String get aksiyalar {
    return Intl.message('Aksiýalar', name: 'aksiyalar', desc: '', args: []);
  }

  /// `Täze goşulanlar`
  String get new_added {
    return Intl.message(
      'Täze goşulanlar',
      name: 'new_added',
      desc: '',
      args: [],
    );
  }

  /// `Maslahat berilýänler`
  String get maslahat_berilyanler {
    return Intl.message(
      'Maslahat berilýänler',
      name: 'maslahat_berilyanler',
      desc: '',
      args: [],
    );
  }

  /// `Halanlarym`
  String get favorites {
    return Intl.message('Halanlarym', name: 'favorites', desc: '', args: []);
  }

  /// `Näsazlyk ýüze çykdy`
  String get nasazlyk_yuze_cykdy {
    return Intl.message(
      'Näsazlyk ýüze çykdy',
      name: 'nasazlyk_yuze_cykdy',
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
