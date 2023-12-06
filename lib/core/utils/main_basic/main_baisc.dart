import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/l10n.dart';
import '../../network/local/dio.dart';
import '../../services/services_locator.dart';
import '../../services/observer.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

Future<void> mainBasic() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServicesLocator().init();
  print(sl<SharedPreferences>().getString('uId'));
  Bloc.observer = await MyBlocObserver();
  DioFinalHelper.init();
}

Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates = [
  S.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

String? language = sl<SharedPreferences>().getString('language') ?? 'en';
Locale? myLocale;

LocaleResolutionCallback? localeResolutionCallback =
    (deviceLocale, supportedLocales) {
  myLocale = deviceLocale;
  language = myLocale!.languageCode;
  return myLocale;
};

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  DateTime now = DateTime.now();

  if (dateTime.day == now.day && dateTime.month == now.month && dateTime.year == now.year) {
    // If the date is today, show only the hour and minute
    return DateFormat('hh:mm a').format(dateTime);
  } else {
    // If the date is not today, show the full date with AM/PM
    return DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
  }
}
