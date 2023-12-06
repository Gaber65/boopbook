import 'package:boopbook/core/utils/text_style.dart';
import 'package:boopbook/feature/authentication/view/widgets/custom_text_form_field.dart';
import 'package:boopbook/feature/layout/controller/Layout_cubit/layout_cubit.dart';
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
            Icon(cubit.currentIndex == 1
                ? IconlyBold.user_2
                : IconlyLight.user_1),
            Icon(cubit.currentIndex == 2
                ? IconlyBold.profile
                : IconlyLight.profile),
            Icon(cubit.currentIndex == 3
                ? IconlyBold.notification
                : IconlyLight.notification),
            Icon(
                cubit.currentIndex == 4 ? IconlyBold.video : IconlyLight.video),
            Icon(
              cubit.currentIndex == 5
                  ? IconlyBold.setting
                  : IconlyLight.setting,
            ),
          ];
          return DefaultTabController(
            length: 6,
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
            onPressed: () {},
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero)),
            child: const Icon(
              IconlyBold.chat,
              size: 20,
            ),
          ),
        ),
      ],
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
