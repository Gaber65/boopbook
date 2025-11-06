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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign In`
  String get Signin {
    return Intl.message(
      'Sign In',
      name: 'Signin',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get EnterYourEmail {
    return Intl.message(
      'Enter Your Email',
      name: 'EnterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Password`
  String get EnterYourPassword {
    return Intl.message(
      'Enter Your Password',
      name: 'EnterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Full Name`
  String get EnterYourFullName {
    return Intl.message(
      'Enter Your Full Name',
      name: 'EnterYourFullName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email to \nReceive the instruction to reset your password`
  String get receiveEmail {
    return Intl.message(
      'Please enter your email to \nReceive the instruction to reset your password',
      name: 'receiveEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Phone Number`
  String get EnterYourPhoneNumber {
    return Intl.message(
      'Enter Your Phone Number',
      name: 'EnterYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Welcome \nBack!`
  String get WelcomeBackWemissedyou {
    return Intl.message(
      'Welcome \nBack!',
      name: 'WelcomeBackWemissedyou',
      desc: '',
      args: [],
    );
  }

  /// `Dont have an account?`
  String get Donthaveanaccount {
    return Intl.message(
      'Dont have an account?',
      name: 'Donthaveanaccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account`
  String get Alreadyhaveanaccount {
    return Intl.message(
      'Already have an account',
      name: 'Alreadyhaveanaccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get Signup {
    return Intl.message(
      'Sign up',
      name: 'Signup',
      desc: '',
      args: [],
    );
  }

  /// `Create \nAccount`
  String get createAccount {
    return Intl.message(
      'Create \nAccount',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid data`
  String get validation {
    return Intl.message(
      'Please enter valid data',
      name: 'validation',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get FullName {
    return Intl.message(
      'Full Name',
      name: 'FullName',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgotPass {
    return Intl.message(
      'Forgot password',
      name: 'forgotPass',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Or continue with`
  String get or {
    return Intl.message(
      'Or continue with',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Boopbook`
  String get boopbook {
    return Intl.message(
      'Boopbook',
      name: 'boopbook',
      desc: '',
      args: [],
    );
  }

  /// `What are you thinking .... ?`
  String get enterYourText {
    return Intl.message(
      'What are you thinking .... ?',
      name: 'enterYourText',
      desc: '',
      args: [],
    );
  }

  /// `Publish`
  String get publish {
    return Intl.message(
      'Publish',
      name: 'publish',
      desc: '',
      args: [],
    );
  }

  /// `Open Camara`
  String get camara {
    return Intl.message(
      'Open Camara',
      name: 'camara',
      desc: '',
      args: [],
    );
  }

  /// `Upload video`
  String get video {
    return Intl.message(
      'Upload video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get image {
    return Intl.message(
      'Upload Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Share Location`
  String get location {
    return Intl.message(
      'Share Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
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
