import 'package:animate_do/animate_do.dart';
import 'package:boopbook/feature/layout/view/screens/feeds/feeds_screen/add_story.dart';
import 'package:boopbook/feature/layout/view/screens/feeds/feeds_screen/story_details.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utils/custom_image_view.dart';
import '../../../controller/feeds_cubit/community_cubit.dart';

Widget storyItem(CommunityCubit cubit, BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SizedBox(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 130,
            width: 82,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                (cubit.userModel != null)
                    ? CustomImageView(
                        imagePath: cubit.userModel!.image!,
                        height: 110,
                        fit: BoxFit.cover,
                        width: 80,
                        radius: BorderRadius.circular(
                          15,
                        ),
                        alignment: Alignment.topCenter,
                      )
                    : FadeIn(
                        duration: const Duration(milliseconds: 400),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade600,
                          child: CustomImageView(
                            imagePath:
                                'https://img.freepik.com/free-photo/daily-life-indigenous-people_52683-96788.jpg?t=st=1701875207~exp=1701875807~hmac=be11372415da7a950c444f6e29a88c336efb568dd5b95942291c088bf20cec4c',
                            height: 110,
                            fit: BoxFit.cover,
                            width: 80,
                            radius: BorderRadius.circular(
                              15,
                            ),
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                    radius: 18,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AddStory(
                                name: cubit.userModel!.name!,
                                image: cubit.userModel!.image!,
                              );
                            },
                          ),
                        );
                      },
                      icon: const Icon(
                        IconlyBold.plus,
                        size: 18,
                        color: Color.fromRGBO(56, 76, 255, 1),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 5,
              );
            },
            itemBuilder: (context, index) {
              if (cubit.storyModel.isNotEmpty &&
                  index < cubit.storyModel.length) {
                return SizedBox(
                  height: 130,
                  width: 82,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CustomImageView(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return StoryDetails(
                                  storyModel: cubit.storyModel[index],
                                  cubit: cubit,
                                  index: index,
                                );
                              },
                            ),
                          );
                        },
                        imagePath: cubit.storyModel![index].object,
                        height: 110,
                        fit: BoxFit.cover,
                        width: 80,
                        radius: BorderRadius.circular(
                          15,
                        ),
                        alignment: Alignment.topCenter,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: const Color.fromRGBO(
                            56,
                            76,
                            255,
                            1,
                          ),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                                '${cubit.storyModel![index].image}'),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return FadeIn(
                  duration: const Duration(milliseconds: 400),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade600,
                    child: CustomImageView(
                      imagePath:
                          'https://img.freepik.com/free-photo/daily-life-indigenous-people_52683-96788.jpg?t=st=1701875207~exp=1701875807~hmac=be11372415da7a950c444f6e29a88c336efb568dd5b95942291c088bf20cec4c',
                      height: 110,
                      fit: BoxFit.cover,
                      width: 80,
                      radius: BorderRadius.circular(
                        15,
                      ),
                      alignment: Alignment.topCenter,
                    ),
                  ),
                );
              }
            },
            itemCount: cubit.storyModel!.isEmpty ? 5 : cubit.storyModel!.length,
          )
        ],
      ),
    ),
  );
}
