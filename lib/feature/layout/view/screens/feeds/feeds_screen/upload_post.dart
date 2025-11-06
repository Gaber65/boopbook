// ignore_for_file: must_be_immutable

import 'package:boopbook/core/utils/video_detail.dart';
import 'package:boopbook/feature/authentication/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/utils/color_constant.dart';
import '../../../../../../core/utils/main_basic/main_bloc/main_cubit.dart';
import '../../../../../../core/utils/text_style.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../controller/feeds_cubit/community_cubit.dart';

class UploadPost extends StatelessWidget {
  UploadPost({
    super.key,
    required this.image,
    required this.textEditingController,
    required this.name,
  });

  String image;
  String name;
  TextEditingController textEditingController;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunityCubit()..getUserData(),
      child: BlocConsumer<CommunityCubit, CommunityState>(
        listener: (context, state) {
          var cubit = CommunityCubit.get(context);
          if(state is CreatePostToFireStateSuccess){
            textEditingController.clear();
            cubit.clearImage();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = CommunityCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            key: scaffoldKey,
            appBar: buildAppBar(context),
            body: buildPaddingBody(context, cubit,state),
            bottomSheet:
                (cubit.imageFile != null || cubit.currentPosition != null)
                    ? null
                    : cubit.showBottom == false
                        ? bottomSheet(context, cubit)
                        : null,
            bottomNavigationBar:
                (cubit.currentPosition != null || cubit.imageFile != null)
                    ? bottomNav(cubit)
                    : null,
            floatingActionButton:
                (cubit.imageFile != null || cubit.currentPosition != null)
                    ? null
                    : floatingAction(cubit, context),
          );
        },
      ),
    );
  }

  FloatingActionButton floatingAction(CommunityCubit cubit, BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        cubit.changeBottom();
      },
      child: const CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(
            'https://img.freepik.com/premium-vector/medical-history-online-services-icon_116137-3643.jpg?w=740'),
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
            child: IconButton(
              onPressed: () {
                cubit
                    .pickImage(
                  source: ImageSource.camera,
                )
                    .then((value) {
                  cubit.getFileType(cubit.imageFile!.path);
                });
              },
              icon: Icon(
                Icons.camera,
                color: PKColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                cubit.clearImage();

                cubit
                    .pickVideo(
                  source: ImageSource.gallery,
                )
                    .then((value) {
                  cubit.getFileType(cubit.imageFile!.path);
                });
              },
              icon: Icon(
                Icons.movie,
                color: Colors.red.shade900,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  cubit.clearImage();

                  cubit
                      .pickImage(
                    source: ImageSource.gallery,
                  )
                      .then((value) {
                    cubit.getFileType(cubit.imageFile!.path);
                  });
                },
                icon: Icon(
                  FontAwesomeIcons.image,
                  color: Colors.green.shade600,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                cubit.clearImage();
                cubit.getCurrentLocation();
              },
              icon: const Icon(
                Icons.location_on,
                color: Colors.orangeAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                height: 35,
                width: 35,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyle(
                fontSize: 13,
                context: context,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (textEditingController.text.isNotEmpty) {
                CommunityCubit.get(context).uploadImageToFirebase(
                  text: textEditingController.text,
                );
              } else {
                Fluttertoast.showToast(
                  msg: 'Please Add your text',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.amber,
                  textColor: Colors.black,
                  fontSize: 16.0,
                );
              }
            },
            child: Text(
              S.of(context).publish,
              style: textStyle(
                fontSize: 13,
                context: context,
                color: PKColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPaddingBody(
      BuildContext context, CommunityCubit cubit, CommunityState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (state is UploadImageToFireStateLoading) LinearProgressIndicator(),
          MyTextForm(
            controller: textEditingController,
            hintText: S.of(context).enterYourText,
            prefixIcon: const SizedBox(),
            obscureText: false,
            enable: false,
          ),
          const Spacer(),
          if (cubit.imageFile != null)
            (cubit.ifImage == true)
                ? Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(cubit.imageFile!),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: AlignmentDirectional.topEnd,
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
                : Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      VideoFileApp(
                        video: cubit.imageFile!,
                      ),
                      Padding(
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
                    ],
                  ),
          if (cubit.currentPosition != null)
            SizedBox(
              height: 400,
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  GoogleMap(
                    onMapCreated: (controller) {},
                    initialCameraPosition: CameraPosition(
                      target: LatLng(cubit.latitude!, cubit.longitude!),
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
                  Padding(
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
                ],
              ),
            ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget bottomSheet(BuildContext context, CommunityCubit cubit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: MainCubit.get(context).isDark
              ? ThemeData.dark().scaffoldBackgroundColor
              : ColorConstant.gray20005,
          borderRadius: BorderRadiusDirectional.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  cubit
                      .pickImage(
                    source: ImageSource.camera,
                  )
                      .then(
                    (value) {
                      cubit.getFileType(cubit.imageFile!.path);
                    },
                  );
                },
                title: Text(
                  S.of(context).camara,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle(
                      fontSize: 18,
                      context: context,
                      fontWeight: FontWeight.w300),
                ),
                leading: const Icon(Icons.camera),
                iconColor: PKColor,
              ),
              const SizedBox(
                height: 12,
              ),
              ListTile(
                onTap: () {
                  cubit
                      .pickVideo(
                    source: ImageSource.gallery,
                  )
                      .then((value) {
                    cubit.getFileType(cubit.imageFile!.path);
                  });
                },
                title: Text(
                  S.of(context).video,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle(
                      fontSize: 18,
                      context: context,
                      fontWeight: FontWeight.w300),
                ),
                leading: const Icon(Icons.movie),
                iconColor: Colors.red.shade900,
              ),
              const SizedBox(
                height: 12,
              ),
              ListTile(
                onTap: () {
                  cubit
                      .pickImage(
                    source: ImageSource.gallery,
                  )
                      .then((value) {
                    cubit.getFileType(cubit.imageFile!.path);
                  });
                },
                title: Text(
                  S.of(context).image,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle(
                      fontSize: 18,
                      context: context,
                      fontWeight: FontWeight.w300),
                ),
                leading: const Icon(FontAwesomeIcons.image),
                iconColor: Colors.green.shade600,
              ),
              const SizedBox(
                height: 12,
              ),
              ListTile(
                onTap: () {
                  cubit.clearImage();
                  cubit.getCurrentLocation();
                },
                title: Text(
                  S.of(context).location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle(
                      fontSize: 18,
                      context: context,
                      fontWeight: FontWeight.w300),
                ),
                leading: const Icon(Icons.location_on),
                iconColor: Colors.orangeAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
