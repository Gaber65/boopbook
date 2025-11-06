import 'package:animate_do/animate_do.dart';
import 'package:boopbook/feature/reals/controller/reals_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/text_style.dart';
import '../../chats/presentaion/view/chat_screen.dart';

class FollowerScreen extends StatelessWidget {
  const FollowerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RealsCubit()..getFollow(),
      child: BlocConsumer<RealsCubit, RealsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = RealsCubit.get(context);
          return (cubit.followerModel.isEmpty)
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
                            height: 100,
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
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ChatDetailsScreen(
                                      userModel: cubit.followerModel[index],
                                    );
                                  },
                                ),
                              );

                            },
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.start ,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    cubit.followerModel[index].image,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  cubit.followerModel[index].name,
                                  style: textStyle(
                                    context: context,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: cubit.followerModel.length,
                );
        },
      ),
    );
  }
}
