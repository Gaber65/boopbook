import 'package:boopbook/core/utils/main_basic/main_bloc/main_cubit.dart';
import 'package:boopbook/core/utils/text_style.dart';
import 'package:boopbook/feature/authentication/view/widgets/custom_text_form_field.dart';
import 'package:boopbook/feature/layout/controller/Layout_cubit/layout_cubit.dart';
import 'package:boopbook/feature/reals/view/reals/get_realse_screen.dart';
import 'package:boopbook/feature/search/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/utils/color_constant.dart';
import '../../../../../core/utils/custom_image_view.dart';
import '../../../../../generated/l10n.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          List<Icon> tapBarIcon = [
            Icon(cubit.currentIndex == 0 ? IconlyBold.home : IconlyLight.home),
            Icon(
              cubit.currentIndex == 1 ? IconlyBold.game : IconlyBroken.game,
            ),
            Icon(cubit.currentIndex == 2
                ? IconlyBold.profile
                : IconlyLight.profile),
            Icon(cubit.currentIndex == 3
                ? IconlyBold.user_3
                : IconlyLight.user_1),

          ];
          return DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: buildAppBar(context, cubit, tapBarIcon),
              body: cubit.screens[cubit.currentIndex],
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(
    BuildContext context,
    LayoutCubit cubit,
    List<Icon> tapBarIcon,
  ) {
    return AppBar(
      centerTitle: false,
      title: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            colors: [
              Color.fromRGBO(56, 76, 255, 1),
              Color.fromRGBO(0, 163, 255, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        child: Text(
          S.of(context).boopbook,
          style: textStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            context: context,
          ),
        ),
      ),
      actions: [
        ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [
                Color.fromRGBO(56, 76, 255, 1),
                Color.fromRGBO(0, 163, 255, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchScreen();
                  },
                ),
              );
            },
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero)),
            child: const Icon(
              IconlyBroken.search,
              size: 25,
            ),
          ),
        ),
      ],
      backgroundColor: cubit.currentIndex == 1
          ? ThemeData.dark().scaffoldBackgroundColor
          : Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(35),
        child: TabBar(
          onTap: (value) {
            cubit.changeIndex(value);
          },
          labelColor: const Color.fromRGBO(56, 76, 255, 1),
          labelPadding: const EdgeInsets.all(8),
          indicatorWeight: .1,
          unselectedLabelColor: Colors.black,
          tabs: tapBarIcon,
        ),
      ),
    );
  }
}
