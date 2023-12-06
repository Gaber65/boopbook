import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/services_locator.dart';
import 'main_state.dart';


class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) {
    return BlocProvider.of(context);
  }


  String? language;
  void changeAppLang({
    String? fromSharedLang,
    String? langMode,
  }) {
    if (fromSharedLang != null) {
      language = fromSharedLang;
      emit(AppChangeModeState());
    } else {
      language = langMode;
      sl<SharedPreferences>()
          .setString(
        'language',
        langMode!,
      )
          .then((value) {
        emit(AppChangeModeState());
      });
    }
  }


  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      sl<SharedPreferences>()
          .setBool(
        'isDark',
        isDark,
      )
          .then((value) {
        emit(AppChangeModeState());
      });
    }
  }

}
