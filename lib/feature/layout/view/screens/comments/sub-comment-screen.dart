import 'package:boopbook/feature/layout/controller/Commet_cubit/comment_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/color_constant.dart';
import '../../../../../core/utils/main_basic/main_baisc.dart';
import '../../../../../core/utils/main_basic/main_bloc/main_cubit.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../../../generated/l10n.dart';
import '../../../../authentication/models/user_model.dart';
import '../../../model/comment_model.dart';

class SubCommentScreen extends StatelessWidget {
  SubCommentScreen({
    Key? key,
    required this.postId,
    required this.commentId,
    required this.model,
    required this.userModel,
    required this.postComments,
    required this.collection,
  }) : super(key: key);

  String postId;
  String commentId;
  String collection;
  CommentModel model;
  UserModel userModel;
  List<dynamic> postComments;

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentCubit()
        ..getSubComment(
          postId: postId,
          commentId: commentId,
          collection: collection,

        ),
      child: BlocConsumer<CommentCubit, CommentState>(
        listener: (context, state) {
          var cubit = CommentCubit.get(context);
          if (state is CreateCommentSuccessState) {
            cubit.addCommentList(
              postId: postId,
              id: sl<SharedPreferences>().getString('uId').toString(),
              postComments: postComments!,
              collection: collection,
            );
            textController.clear();
          }
        },
        builder: (context, state) {
          var cubit = CommentCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Replies'),
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(110),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(model.image!),
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
                                borderRadius:
                                    BorderRadiusDirectional.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.name!,
                                      style: textStyle(context: context),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.sizeOf(context).width * .8,
                                      child: Text(
                                        model.text!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
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
                                const Spacer(),
                                DefaultTextStyle(
                                  style: textStyle(
                                    context: context,
                                    color: MainCubit.get(context).isDark
                                        ? ThemeData.dark()
                                            .scaffoldBackgroundColor
                                        : Colors.grey,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      formatDateTime(model.dataTime!),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsetsDirectional.only(
                start: 20,
                end: 8
              ),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildCommentItem(
                    context: context,
                    commentModel: cubit.commentPost[index],
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
                            cubit.createSubComment(
                              comment: textController.text,
                              postId: postId,
                              image: userModel.image!,
                              name: userModel.name,
                              commentId: commentId,
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
