import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../controller/feeds_cubit/community_cubit.dart';
import '../../../widgets/feeds_widget/add_post_form.dart';
import '../../../widgets/feeds_widget/post_item.dart';
import '../../../widgets/feeds_widget/story_item.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunityCubit()
        ..getUserData()
        ..getStoryData()
        ..getPostsData(),
      child: BlocConsumer<CommunityCubit, CommunityState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CommunityCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildWhatsonyourmindSanjay(context, cubit),
                    const SizedBox(
                      height: 10,
                    ),
                    storyItem(cubit,context),
                    const SizedBox(
                      height: 10,
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
                                  return Card(
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
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 8.0,
                                ),
                              ),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 8.0,
                            ),
                            itemBuilder: (context, index) {
                              return buildPostItem(context, cubit, index);
                            },
                            itemCount: cubit.postsModel.length,
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
