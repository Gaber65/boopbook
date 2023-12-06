import 'package:boopbook/core/network/local/dio.dart';
import 'package:boopbook/feature/layout/view/screens/LayoutScreen/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/services_locator.dart';
import 'core/utils/main_basic/main_baisc.dart';
import 'core/utils/main_basic/main_bloc/main_cubit.dart';
import 'core/utils/main_basic/main_bloc/main_state.dart';
import 'core/utils/theme_manager.dart';
import 'feature/authentication/view/screens/signIn_screen.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  await mainBasic();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MainCubit()
          ..changeAppLang(
            fromSharedLang:
                sl<SharedPreferences>().getString('language') ?? 'en',
          )
          ..changeAppMode(
            fromShared: sl<SharedPreferences>().getBool('isDark') ?? false,
          );
      },
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MainCubit.get(context);
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: getApplicationLightTheme(context),
            darkTheme: getApplicationDarkTheme(context),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            localizationsDelegates: localizationsDelegates,
            localeResolutionCallback: localeResolutionCallback,
            supportedLocales: S.delegate.supportedLocales,
            locale: cubit.language == 'en'
                ? const Locale('en')
                : const Locale('ar'),
            home: sl<SharedPreferences>().getString('uId') != null ||
                    sl<SharedPreferences>().getString('uId') != ''
                ? LayoutScreen()
                : SignInScreen(),
          );
        },
      ),
    );
  }
}
