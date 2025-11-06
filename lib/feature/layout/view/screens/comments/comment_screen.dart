// ignore_for_file: must_be_immutable

import 'package:boopbook/core/utils/main_basic/main_baisc.dart';
import 'package:boopbook/feature/authentication/models/user_model.dart';
import 'package:boopbook/feature/authentication/view/widgets/custom_text_form_field.dart';
import 'package:boopbook/feature/layout/controller/Commet_cubit/comment_cubit.dart';
import 'package:boopbook/feature/layout/model/post_model.dart';
import 'package:boopbook/feature/layout/view/screens/comments/sub-comment-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/color_constant.dart';
import '../../../../../core/utils/main_basic/main_bloc/main_cubit.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../../../generated/l10n.dart';
import '../../../model/comment_model.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({
    super.key,
    required this.postId,
    required this.postModel,
    required this.collection,
    required this.userModel,
  });

  String postId;
  String collection;
  UserModel userModel;
  PostModel postModel;
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentCubit()
        ..getComment(
          postId: postId,
          collection: collection,
        ),
      child: BlocConsumer<CommentCubit, CommentState>(
        listener: (context, state) {
          var cubit = CommentCubit.get(context);
          if (state is CreateCommentSuccessState) {
            cubit.addCommentList(
              postId: postId,
              id: sl<SharedPreferences>().getString('uId').toString(),
              postComments: postModel.postComments!,
              collection: collection,
            );
            textController.clear();
          }
        },
        builder: (context, state) {
          var cubit = CommentCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Comments'),
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildCommentItem(
                    context: context,
                    commentModel: cubit.commentPost[index],
                    commentId: cubit.commentIds[index],
                    collection:collection,
                    index: index,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 9,
                  );
                },
                itemCount: cubit.commentPost.length,
                shrinkWrap: true,
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: MainCubit.get(context).isDark
                      ? ThemeData.dark().scaffoldBackgroundColor
                      : ColorConstant.gray20005,
                  borderRadius: BorderRadiusDirectional.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: textController,
                    validator: (value) {
                      return S.of(context).validation;
                    },
                    style: textStyle(
                      fontSize: 13,
                      context: context,
                    ),
                    decoration: InputDecoration(
                      hintText: "Write Comment...",
                      counterStyle: textStyle(
                        fontSize: 13,
                        context: context,
                      ),
                      hintStyle: textStyle(
                        fontSize: 12,
                        context: context,
                        color: ColorConstant.blueGray400,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (textController.text.isNotEmpty) {
                            cubit.createComment(
                              comment: textController.text,
                              postId: postId,
                              image: userModel.image!,
                              name: userModel.name,
                              collection: collection,
                            );
                          }
                        },
                        icon: const Icon(Icons.near_me),
                      ),
                      enabledBorder: InputBorder.none,
                      focusColor: ColorConstant.gray20004,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }

  Widget buildCommentItem({
    required BuildContext context,
    required CommentModel commentModel,
    required String commentId,
    required String collection,
    required int index,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(commentModel.image!),
          backgroundColor: Colors.white,
          radius: 25,
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: MainCubit.get(context).isDark
                      ? ThemeData.dark().scaffoldBackgroundColor
                      : ColorConstant.gray20005,
                  borderRadius: BorderRadiusDirectional.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        commentModel.name!,
                        style: textStyle(context: context),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .8,
                        child: Text(
                          commentModel.text!,
                          style: textStyle(context: context),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubCommentScreen(
                            model: commentModel,
                            commentId: commentId,
                            postId: postId,
                            userModel: userModel,
                            postComments: postModel.postComments!,
                            collection: collection,
                          ),
                        ),
                      );
                    },
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.grey[700], fontWeight: FontWeight.bold),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Reply',
                          style: textStyle(context: context),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  DefaultTextStyle(
                    style: textStyle(
                      context: context,
                      color: MainCubit.get(context).isDark
                          ? ThemeData.dark().scaffoldBackgroundColor
                          : Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        formatDateTime(commentModel.dataTime!),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
