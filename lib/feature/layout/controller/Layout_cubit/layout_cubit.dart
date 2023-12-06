import 'package:bloc/bloc.dart';
import 'package:boopbook/core/network/local/dio.dart';
import 'package:boopbook/feature/authentication/models/user_model.dart';
import 'package:boopbook/feature/layout/view/screens/feeds/feeds_screen/feeds_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/services_locator.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) {
    return BlocProvider.of(context);
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    Column(),
    FeedsScreen(),
    FeedsScreen(),
    FeedsScreen(),
    FeedsScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndex());
  }


}
