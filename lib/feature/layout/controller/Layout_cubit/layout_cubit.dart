import 'package:bloc/bloc.dart';
import 'package:boopbook/feature/layout/view/screens/feeds/feeds_screen/community_screen.dart';
import 'package:boopbook/feature/reals/view/reals/get_realse_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../setting/view/friend_screen.dart';
import '../../../setting/view/profile_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) {
    return BlocProvider.of(context);
  }

  int currentIndex = 0;

  List<Widget> screens =  [
    CommunityScreen(),
    RealsScreen(),
    ProfileScreen(),
    FollowerScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndex());
  }

  getUserdata() {}
}
