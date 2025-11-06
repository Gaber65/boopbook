import 'package:boopbook/core/utils/main_basic/main_baisc.dart';
import 'package:boopbook/core/utils/video_detail.dart';
import 'package:boopbook/feature/authentication/view/widgets/custom_text_form_field.dart';
import 'package:boopbook/feature/layout/view/screens/comments/comment_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../controller/feeds_cubit/community_cubit.dart';

Widget buildPostItem(
  context,
  CommunityCubit cubit,
  int index,
) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22.0,
                backgroundImage:
                    NetworkImage(cubit.postsModel[index].image.toString()),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            cubit.postsModel[index].name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle(
                              fontSize: 12,
                              context: context,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                      ],
                    ),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      formatDateTime(
                        cubit.postsModel[index].dateTime.toString(),
                      ),
                      style: textStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              if (cubit.postsModel[index].uId ==
                  sl<SharedPreferences>().get('uId'))
                PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      onTap: () {
                        cubit.removePost(cubit.postIds[index]);
                      },
                      child: Row(
                        children: [
                          Text(
                            'Remove Post',
                            style: textStyle(context: context, fontSize: 12),
                          ),
                          const Spacer(),
                          const Icon(Icons.remove)
                        ],
                      ),
                    ),
                  ],
                  icon: const Icon(
                    Icons.more_vert,
                    size: 18,
                    color: Colors.grey,
                  ),
                  offset: const Offset(0, 20),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          if (cubit.postsModel[index].text!.isNotEmpty)
            Text(
              cubit.postsModel[index].text.toString(),
              maxLines: 6,
              style: textStyle(context: context, fontSize: 14),
            ),
          const SizedBox(
            height: 12,
          ),
          if (cubit.postsModel[index].postImage!.isNotEmpty)
            Container(
              height: 250.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          cubit.postsModel[index].postImage.toString()),
                      fit: BoxFit.cover)),
            ),
          if (cubit.postsModel[index].video!.isNotEmpty)
            SizedBox(
              height: 250.0,
              child: VideoStringApp(video: cubit.postsModel[index].video!),
            ),
          if (cubit.postsModel[index].longitude != '' &&
              cubit.postsModel[index].latitude != '')
            SizedBox(
              height: 250,
              child: GoogleMap(
                onMapCreated: (controller) {},
                initialCameraPosition: CameraPosition(
                  target: LatLng(cubit.postsModel[index].latitude,
                      cubit.postsModel[index].longitude),
                  zoom: 15.0,
                ),
                buildingsEnabled: true,
                compassEnabled: true,
                myLocationEnabled: true,
                indoorViewEnabled: true,
                mapToolbarEnabled: true,
                myLocationButtonEnabled: true,
                zoomGesturesEnabled: true,
              ),
            ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            cubit.postsModel[index].postLikes!.contains(
                                    sl<SharedPreferences>()
                                        .getString('uId')
                                        .toString())
                                ? IconlyBold.heart
                                : Icons.favorite_border,
                            size: 16.0,
                            color: const Color.fromRGBO(56, 76, 255, 1),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            cubit.postsModel[index].postLikes!.length
                                .toString(),
                            style: textStyle(context: context, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      if (cubit.postsModel[index].postLikes!.contains(
                          sl<SharedPreferences>()
                              .getString('uId')
                              .toString())) {
                      } else {
                        cubit.addLike(
                          postId: cubit.postIds[index],
                          index: index,
                          id: sl<SharedPreferences>()
                              .getString('uId')
                              .toString(),
                          postLikes: cubit.postsModel[index].postLikes!,
                        );
                      }
                    },
                    onDoubleTap: () {
                      cubit.removeLike(
                        postId: cubit.postIds[index],
                        index: index,
                        id: sl<SharedPreferences>().getString('uId').toString(),
                        postLikes: cubit.postsModel[index].postLikes!,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            IconlyBold.chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            cubit.postsModel[index].postComments!.length
                                .toString(),
                            style: textStyle(context: context, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CommentScreen(
                              postId: cubit.postIds[index],
                              userModel: cubit.userModel!,
                              postModel: cubit.postsModel[index],
                              collection: 'posts',
                            );
                          },
                        ),
                      );
                    },
                    child: MyTextForm(
                      prefixIcon: const SizedBox(),
                      controller: TextEditingController(),
                      hintText: 'Write Your Comment',
                      enable: false,
                      obscureText: false,
                      enabled: false,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        cubit.postsModel[index].postLikes!.contains(sl<SharedPreferences>()
                                    .getString('uId')
                                    .toString())
                            ? IconlyBold.heart
                            : Icons.favorite_border,
                        size: 16.0,
                        color: const Color.fromRGBO(56, 76, 255, 1),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Like',
                        style: textStyle(context: context, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  if (cubit.postsModel[index].postLikes!.contains(
                      sl<SharedPreferences>().getString('uId').toString())) {
                  } else {
                    cubit.addLike(
                      postId: cubit.postIds[index],
                      index: index,
                      id: sl<SharedPreferences>().getString('uId').toString(),
                      postLikes: cubit.postsModel[index].postLikes!,
                    );
                  }
                },
                onDoubleTap: () {
                  cubit.removeLike(
                    postId: cubit.postIds[index],
                    index: index,
                    id: sl<SharedPreferences>().getString('uId').toString(),
                    postLikes: cubit.postsModel[index].postLikes!,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
