import 'package:boopbook/feature/layout/controller/Layout_cubit/layout_cubit.dart';
import 'package:boopbook/feature/layout/controller/feeds_cubit/feeds_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/feeds_widget/add_post_form.dart';
import '../../../widgets/feeds_widget/post_item.dart';
import '../../../widgets/feeds_widget/story_item.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedsCubit()
        ..getUserData()
        ..getStoryData()
        ..getPostsData(),
      child: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = FeedsCubit.get(context);
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
                    storyItem(cubit),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8.0,
                      ),
                      itemBuilder: (context, index) {
                        return buildPostItem(context,cubit,index);
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
