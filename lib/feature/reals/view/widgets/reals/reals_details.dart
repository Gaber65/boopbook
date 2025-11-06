// ignore_for_file: must_be_immutable

import 'package:boopbook/core/utils/text_style.dart';
import 'package:boopbook/core/utils/video_detail.dart';
import 'package:boopbook/feature/authentication/models/user_model.dart';
import 'package:boopbook/feature/reals/controller/reals_cubit.dart';
import 'package:boopbook/feature/reals/view/reals/add_reals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../layout/model/post_model.dart';
import 'item_video.dart';

class VideoReals extends StatelessWidget {
  VideoReals({
    super.key,
    required this.model,
    required this.realsIdes,
    required this.userModel,
  });
  List<PostModel> model;
  String realsIdes;
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RealsCubit()..getFollow(),
      child: BlocConsumer<RealsCubit, RealsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
            ),
          );
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    bottom: const PreferredSize(
                      preferredSize: Size.fromHeight(0),
                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white30,
                        tabs: [
                          Text(
                            'For You',
                          ),
                          Text(
                            'New Reals',
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return BodyReals(
                            model: model[index],
                            cubit: RealsCubit.get(context),
                            realsId: realsIdes,
                            index: index,
                            userModel: userModel,
                          );
                        },
                        itemCount: model.length,
                      ),
                      AddReels(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
