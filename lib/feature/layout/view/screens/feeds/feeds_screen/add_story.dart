import 'package:boopbook/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controller/feeds_cubit/community_cubit.dart';

class AddStory extends StatelessWidget {
  AddStory({
    super.key,
    required this.name,
    required this.image,
  });
  String name;
  String image;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunityCubit()
        ..getUserData()
        ..pickImage(
          source: ImageSource.gallery,
        ),
      child: BlocConsumer<CommunityCubit, CommunityState>(
        listener: (context, state) {
          var cubit = CommunityCubit.get(context);
          if (state is UploadImageToFireStateSuccess) {
            cubit.clearImage();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = CommunityCubit.get(context);
          return Scaffold(
            bottomNavigationBar: bottomNav(cubit),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 36,
                        horizontal: 8,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  image,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                name,
                                style: textStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  context: context,
                                ),
                              ),
                              const Spacer(),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.refresh,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          if (state is UploadImageToFireStateLoading)
                            LinearProgressIndicator(),
                        ],
                      ),
                    ),
                    if (cubit.imageFile != null)
                      Container(
                        height: MediaQuery.sizeOf(context).height * .6,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(cubit.imageFile!),
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  cubit.clearImage();
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          ),
                        ),
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

  Material bottomNav(CommunityCubit cubit) {
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                if (cubit.imageFile == null) {
                  cubit.pickImage(
                    source: ImageSource.gallery,
                  );
                }
              },
              child: const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/premium-vector/medical-history-online-services-icon_116137-3643.jpg?w=740'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                if (cubit.imageFile == null) {
                  cubit.pickImage(
                    source: ImageSource.gallery,
                  );
                } else {
                  cubit.uploadStoryToFirebase();
                }
              },
              child: const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/free-vector/download-concept-illustration_114360-2857.jpg?w=740&t=st=1702424028~exp=1702424628~hmac=9b7ea6a0fdf7de65e5249a533d97b36b59018b2d6b58d96f28f4cb9da16c1f43'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
