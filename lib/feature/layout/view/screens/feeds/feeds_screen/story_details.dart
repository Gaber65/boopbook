import 'dart:async';

import 'package:boopbook/core/utils/main_basic/main_baisc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/services/services_locator.dart';
import '../../../../../../core/utils/text_style.dart';
import '../../../../controller/feeds_cubit/community_cubit.dart';
import '../../../../model/story_model.dart';

class StoryDetails extends StatefulWidget {
  const StoryDetails({
    Key? key,
    required this.storyModel,
    required this.cubit,
    required this.index,
  }) : super(key: key);
  final StoryModel storyModel;
  final CommunityCubit cubit;
  final int index;

  @override
  State<StoryDetails> createState() => _StoryDetailsState();
}

class _StoryDetailsState extends State<StoryDetails> {
  double percent = 0;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 3), (timer) {
      setState(() {
        percent += 0.001;
        if (percent > 1) {
          timer.cancel();
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.storyModel.object.toString(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 36,
                horizontal: 8,
              ),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: percent,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(widget.storyModel.image.toString()),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.storyModel.name.toString(),
                            style: textStyle(
                              color: Colors.white,
                              fontSize: 16,
                              context: context,
                            ),
                          ),
                          Text(
                            formatDateTime(
                                widget.storyModel.dateTime.toString()),
                            style: textStyle(
                              color: Colors.white,
                              fontSize: 16,
                              context: context,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      if (widget.cubit.storyModel[widget.index].uId ==
                          sl<SharedPreferences>().get('uId'))
                        PopupMenuButton<int>(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              onTap: () {
                                widget.cubit
                                    .removeStory(
                                        widget.cubit.storyId[widget.index])
                                    .then(
                                  (value) {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Remove Story',
                                    style: textStyle(
                                        context: context, fontSize: 12),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.remove)
                                ],
                              ),
                            ),
                          ],
                          icon: CircleAvatar(
                            child: const Icon(
                              Icons.more_vert,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                          offset: const Offset(0, 20),
                        )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
