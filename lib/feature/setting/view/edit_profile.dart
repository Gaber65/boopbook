import 'package:boopbook/feature/authentication/models/user_model.dart';
import 'package:boopbook/feature/authentication/view/widgets/custom_text_form_field.dart';
import 'package:boopbook/feature/setting/controller/setting_cubit.dart';
import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class EditProfile extends StatelessWidget {
  EditProfile({
    Key? key,
    required this.userModel,
  }) : super(key: key);
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  UserModel userModel;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit()
        ..getUserData().then((value) {
          nameController.text = userModel.name;
          phoneController.text = userModel.phone;
          bioController.text = userModel.bio!;
        }),
      child: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {
          if (state is UpdateUserSuccessSettingState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = SettingCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    cubit.updateCoverProfile();
                    cubit.updateProfile();
                  },
                  icon: const Icon(
                    IconlyBroken.upload,
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                if (state is UpdateUserLoadingSettingState)
                  const LinearProgressIndicator(),
                SizedBox(
                  height: 190.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 140.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                    4.0,
                                  ),
                                  topRight: Radius.circular(
                                    4.0,
                                  ),
                                ),
                                image: DecorationImage(
                                  image: cubit.imageProfileCover == null
                                      ? NetworkImage(
                                          '${userModel.cover}',
                                        ) as ImageProvider
                                      : FileImage(cubit.imageProfileCover!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: CircleAvatar(
                                backgroundColor:
                                    ThemeData.light().scaffoldBackgroundColor,
                                radius: 20.0,
                                child: const Icon(
                                  IconlyBroken.camera,
                                  size: 16.0,
                                ),
                              ),
                              onPressed: () {
                                cubit.getProfileCoverImage();
                              },
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: cubit.imageProfile == null
                                  ? NetworkImage(
                                      '${userModel.image}',
                                    ) as ImageProvider
                                  : FileImage(cubit.imageProfile!),
                            ),
                          ),
                          IconButton(
                            icon: CircleAvatar(
                              backgroundColor:
                                  ThemeData.light().scaffoldBackgroundColor,
                              radius: 20.0,
                              child: const Icon(
                                IconlyBroken.camera,
                                size: 16.0,
                              ),
                            ),
                            onPressed: () {
                              cubit.getProfileImage();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      MyTextForm(
                        controller: nameController,
                        hintText: '',
                        prefixIcon: Icon(Icons.person),
                        enabled: true,
                        obscureText: false,
                        enable: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyTextForm(
                        controller: phoneController,
                        hintText: '',
                        prefixIcon: Icon(IconlyBroken.call),
                        enabled: true,
                        obscureText: false,
                        enable: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextForm(
                        controller: bioController,
                        hintText: '',
                        prefixIcon: Icon(IconlyBroken.edit),
                        enabled: true,
                        obscureText: false,
                        enable: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: myBottom(
                          TextButton(
                            onPressed: () {
                              cubit.updateUserData(
                                name: nameController.text,
                                phone: phoneController.text,
                                bio: bioController.text,
                              );
                            },
                            child: Text(
                              'Upload',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 20,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
