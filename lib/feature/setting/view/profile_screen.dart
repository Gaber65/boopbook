import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:boopbook/core/utils/main_basic/main_bloc/main_cubit.dart';
import 'package:boopbook/feature/authentication/view/screens/signIn_screen.dart';
import 'package:boopbook/feature/setting/view/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/text_style.dart';
import '../../layout/controller/Layout_cubit/layout_cubit.dart';
import '../../layout/controller/feeds_cubit/community_cubit.dart';
import '../../layout/view/widgets/feeds_widget/post_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunityCubit()
        ..getUserData()
        ..getPostsData()
        ..getFollow(),
      child: BlocConsumer<CommunityCubit, CommunityState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CommunityCubit.get(context);
          return Scaffold(
            body: buildColumn(context, cubit),
          );
        },
      ),
    );
  }

  Widget buildColumn(context, CommunityCubit cubit) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadiusDirectional.only(
                        topEnd: Radius.circular(
                          12,
                        ),
                        topStart: Radius.circular(12),
                      ),
                      child: Image(
                        image: NetworkImage(
                          cubit.userModel != null
                              ? cubit.userModel!.cover!
                              : 'https://tse2.mm.bing.net/th?id=OIP.vGDCJnsOvLDbVBWhXTMDqQHaD4&pid=Api',
                        ),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                      cubit.userModel != null
                          ? cubit.userModel!.image!
                          : 'https://tse2.mm.bing.net/th?id=OIP.vGDCJnsOvLDbVBWhXTMDqQHaD4&pid=Api',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          if (cubit.userModel != null)
            Text(
              cubit.userModel!.name,
              style: textStyle(
                context: context,
                fontSize: 14 + 2,
                color: Colors.black,
              ),
            ),
          const SizedBox(
            height: 12,
          ),
          if (cubit.userModel != null)
            Text(
              cubit.userModel!.bio!,
              style: textStyle(
                context: context,
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 14,
              left: 14,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 60,
                    width: 75,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadiusDirectional.circular(14),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditProfile(
                                userModel: cubit.userModel!,
                              );
                            },
                          ),
                        );
                      },
                      icon: const Icon(
                        IconlyLight.edit_square,
                        color: Colors.black,
                        size: 27,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadiusDirectional.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                (cubit.postsModel.contains(
                                        sl<SharedPreferences>().get('uId')))
                                    ? cubit.postsModel.length.toString()
                                    : 0.toString(),
                                style: textStyle(
                                  context: context,
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Post',
                                style: textStyle(
                                  context: context,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                cubit.followerModel.length.toString(),
                                style: textStyle(
                                  context: context,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Following',
                                style: textStyle(
                                  context: context,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 60,
                    width: 75,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadiusDirectional.circular(14),
                    ),
                    child: IconButton(
                      onPressed: () {
                        MainCubit.get(context).logOut().then(
                          (value) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SignInScreen();
                                },
                              ),
                              (route) => false,
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        IconlyLight.logout,
                        color: Colors.black,
                        size: 27,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          (cubit.postsModel.isEmpty)
              ? FadeIn(
                  duration: const Duration(milliseconds: 400),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade600,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5.0,
                          margin: EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 140,
                          ),
                        );
                      },
                      itemCount: 10,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8.0,
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8.0,
                    ),
                    itemBuilder: (context, index) {
                      if (cubit.userModel!.uId == cubit.postsModel[index].uId) {
                        return buildPostItem(
                          context,
                          cubit,
                          index,
                        );
                      }
                      {
                        return const SizedBox();
                      }
                    },
                    itemCount: cubit.postsModel.length,
                  ),
                )
        ],
      ),
    );
  }
}
