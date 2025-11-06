import 'package:boopbook/core/utils/main_basic/main_baisc.dart';
import 'package:boopbook/feature/authentication/models/user_model.dart';
import 'package:boopbook/feature/chats/presentaion/view/chat_screen.dart';
import 'package:boopbook/feature/layout/view/screens/comments/comment_screen.dart';
import 'package:boopbook/feature/reals/controller/reals_cubit.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../../../core/utils/video_detail.dart';
import '../../../../layout/model/post_model.dart';

class BodyReals extends StatelessWidget {
  BodyReals({
    super.key,
    required this.model,
    required this.cubit,
    required this.realsId,
    required this.userModel,
    required this.index,
  });
  RealsCubit cubit;
  String realsId;
  int index;
  PostModel model;
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: VideApp(
            video: model.video.toString(),
            isPlaying: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          model.image.toString(),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.name.toString(),
                            style: textStyle(
                              context: context,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            formatDateTime(model.dateTime.toString()),
                            style: textStyle(
                              context: context,
                              color: Colors.white60,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      if (sl<SharedPreferences>().getString('uId') != model.uId)
                        TextButton(
                          onPressed:() {
                            cubit.follow(
                              image: model.image!,
                              uId: model.uId!,
                              name: model.name!,
                            );
                          },
                          child: Text(
                            'Follow',
                            style: textStyle(
                              context: context,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .8,
                    child: Text(
                      model.text.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: textStyle(
                        context: context,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (model.postLikes!.contains(sl<SharedPreferences>()
                              .getString('uId')
                              .toString())) {
                          } else {
                            cubit.addLike(
                              realsId: realsId,
                              id: sl<SharedPreferences>()
                                  .getString('uId')
                                  .toString(),
                              postLikes: model.postLikes!,
                            );
                          }
                        },
                        onDoubleTap: () {
                          cubit.removeLike(
                            realsId: realsId,
                            id: sl<SharedPreferences>()
                                .getString('uId')
                                .toString(),
                            postLikes: model.postLikes!,
                          );
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Icon(
                          IconlyBold.heart,
                          color: !model.postLikes!.contains(
                                  sl<SharedPreferences>()
                                      .getString('uId')
                                      .toString())
                              ? Colors.white
                              : Color.fromRGBO(56, 76, 255, 1),
                        ),
                      ),
                      Text(
                        model.postLikes!.length.toString(),
                        style: textStyle(
                          context: context,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CommentScreen(
                                  postId: realsId,
                                  postModel: model,
                                  collection: 'reals',
                                  userModel: userModel,
                                );
                              },
                            ),
                          );
                        },
                        icon: const Icon(
                          IconlyBold.chat,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        model.postComments!.length.toString(),
                        style: textStyle(
                          context: context,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 3),
                              content: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Share to Your Friends',
                                      textAlign: TextAlign.start,
                                      style: textStyle(
                                          context: context,
                                          color: Colors.white
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ChatDetailsScreen(
                                                          userModel: cubit
                                                              .followerModel[index],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(
                                                    cubit.followerModel[index].image,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                cubit.followerModel[index].name.substring(0,5),
                                                style: textStyle(
                                                    context: context,
                                                    color: Colors.white
                                                ),
                                                textAlign: TextAlign.center,
                                              ),

                                            ],
                                          );
                                        },
                                        itemCount: cubit.followerModel.length,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          IconlyBold.send,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
