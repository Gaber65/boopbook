import 'package:boopbook/core/utils/main_basic/main_baisc.dart';
import 'package:boopbook/core/utils/video_detail.dart';
import 'package:boopbook/feature/authentication/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/utils/text_style.dart';
import '../../../controller/feeds_cubit/feeds_cubit.dart';

Widget buildPostItem(
  context,
  FeedsCubit cubit,
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
                        SizedBox(
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
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              PopupMenuButton<int>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
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
                  PopupMenuItem(
                    value: 2,
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            'Saved post',
                            style: textStyle(
                              context: context,
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.bookmark_border_outlined)
                        ],
                      ),
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
              height: 140.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          cubit.postsModel[index].postImage.toString()),
                      fit: BoxFit.cover)),
            ),
          if (cubit.postsModel[index].video!.isNotEmpty)
            Container(
              height: 140.0,
              child: HotVideo(
                url: cubit.postsModel[index].video!,
                height:140 ,
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
                          const Icon(IconlyBold.heart,
                              size: 16.0,
                              color: Color.fromRGBO(56, 76, 255, 1)),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            12.toString(),
                            style: textStyle(context: context, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
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
                            11.toString(),
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
                child: Container(
                  height: 40,
                  child: MyTextForm(
                    prefixIcon: const SizedBox(),
                    controller: TextEditingController(),
                    hintText: 'Write Your Comment',
                    enable: false,
                    obscureText: false,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                child: Row(
                  children: [
                    const Icon(
                      IconlyBroken.heart,
                      size: 16.0,
                      color: Colors.red,
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
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
