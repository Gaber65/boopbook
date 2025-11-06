import 'package:boopbook/core/utils/main_basic/main_baisc.dart';
import 'package:boopbook/core/utils/text_style.dart';
import 'package:boopbook/core/utils/video_detail.dart';
import 'package:boopbook/feature/chats/controller/chat_cubit.dart';
import 'package:boopbook/feature/reals/view/followers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/color_constant.dart';
import '../../model/chat_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  FollowerModel userModel;

  ChatDetailsScreen({
    super.key,
    required this.userModel,
  });

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getMessages(userModel),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              titleSpacing: 0.0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      userModel.image.toString(),
                    ),
                  ),
                  Text(
                    userModel.name.toString(),
                    style: const TextStyle(
                        fontSize: 14, overflow: TextOverflow.clip),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
            body: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var message = cubit.messagesList[index];
                if (sl<SharedPreferences>().getString('uId') ==
                    message.senderId) {
                  return buildMyMessage(message, context);
                } else {
                  return buildMessage(message, context);
                }
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 15.0,
              ),
              itemCount: cubit.messagesList.length,
            ),
            floatingActionButton: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (cubit.chatImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          image: FileImage(cubit.chatImage!),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            cubit.removePostImage();
                          },
                          icon: const Icon(
                            Icons.close,
                          ))
                    ],
                  ),
                if (cubit.VideoChat != null)
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Card(
                          elevation: 10,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            child: VideoFileApp(
                              video: cubit.VideoChat!,
                            ),
                          )),
                      IconButton(
                        onPressed: () {
                          cubit.removePostImage();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: Colors.lightBlue,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            keyboardType: TextInputType.multiline,
                            keyboardAppearance: Brightness.dark,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'type your message here...',
                              hintStyle: textStyle(context: context),
                              prefixIcon: IconButton(
                                onPressed: () {
                                  cubit.uploadvideochat();
                                },
                                icon: const Icon(IconlyBroken.chart),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            cubit.getChatImage();
                          },
                          icon: Icon(
                            IconlyBroken.image_2,
                            color: Colors.lightBlue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (cubit.chatImage == null &&
                                cubit.VideoChat == null) {
                              cubit.sendMessage(
                                dateTime: DateTime.now().toString(),
                                text: messageController.text,
                                receiverId: userModel.uId,
                              );
                            } else if (cubit.chatImage != null) {
                              cubit.sendChatImage(
                                dateTime: DateTime.now().toString(),
                                text: messageController.text,
                                receiverId: userModel.uId,
                              );
                            } else if (cubit.VideoChat != null) {
                              cubit.UplaodVideochat(
                                  reciverid: userModel.uId,
                                  text: messageController.text,
                                  datatime: DateTime.now().toString());
                            }
                            messageController.clear();
                          },
                          icon: Icon(
                            IconlyBroken.send,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }

  String limitTextLength(String text, int maxLength) {
    return (text.length <= maxLength)
        ? text
        : '${text.substring(0, maxLength)}...';
  }

  Widget buildMessage(MessageModel model, context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.gray20004,
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(
              15.0,
            ),
            topStart: Radius.circular(
              15.0,
            ),
            topEnd: Radius.circular(
              15.0,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (model.image!.isNotEmpty)
              Container(
                height: 200.0,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    4.0,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(model.image.toString()),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            if (model.video!.isNotEmpty)
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    height: 200.0,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                    ),
                    child: VideoStringApp(video: model.video.toString()),
                  ),
                ],
              ),
            Text(
              limitTextLength(model.message.toString(), 50),
              style: textStyle(fontSize: 14, context: context),
            ),
            Text(
              formatDateTime(model.time!),
              style: const TextStyle(fontSize: 10, color: Colors.black38),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMyMessage(MessageModel model, context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue.shade200,
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                15.0,
              ),
              topStart: Radius.circular(
                15.0,
              ),
              topEnd: Radius.circular(
                15.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (model.image!.isNotEmpty)
                Container(
                  height: 200.0,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(model.image.toString()),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              if (model.video!.isNotEmpty)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 200.0,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          4.0,
                        ),
                      ),
                      child: VideoStringApp(video: model.video.toString()),
                    ),
                  ],
                ),
              Text(
                limitTextLength(model.message.toString(), 50),
                style: textStyle(fontSize: 14, context: context),
              ),
              Text(
                formatDateTime(model.time!),
                style: const TextStyle(fontSize: 10, color: Colors.black38),
              ),
            ],
          ),
        ),
      );
}
