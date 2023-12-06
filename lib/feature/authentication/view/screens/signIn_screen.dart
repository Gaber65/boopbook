import 'package:boopbook/core/utils/text_style.dart';
import 'package:boopbook/feature/authentication/controller/AuthCubit/ath_cubit.dart';
import 'package:boopbook/feature/authentication/view/screens/signUp_screen.dart';
import 'package:boopbook/feature/authentication/view/widgets/custom_text_form_field.dart';
import 'package:boopbook/feature/layout/view/screens/LayoutScreen/layout_screen.dart';
import 'package:boopbook/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/color_constant.dart';
import '../../../../generated/l10n.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AthCubit(),
      child: BlocConsumer<AthCubit, AthState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            sl<SharedPreferences>().setString(
              'uId',
              state.r,
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const LayoutScreen();
                },
              ),
                  (route) => false,
            );
            Fluttertoast.showToast(
              msg: S.of(context).validation,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        builder: (context, state) {
          var cubit = AthCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: Form(
              key: cubit.formkey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).WelcomeBackWemissedyou,
                      style: textStyle(
                        fontSize: 30,
                        context: context,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    MyTextForm(
                      controller: cubit.emailController,
                      prefixIcon: const Icon(
                        Icons.alternate_email_sharp,
                        size: 14,
                      ),
                      enable: false,
                      hintText: S.of(context).EnterYourEmail,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyTextForm(
                      controller: cubit.passController,
                      prefixIcon: const Icon(
                        Icons.password,
                        size: 14,
                      ),
                      enable: true,
                      hintText: S.of(context).EnterYourPassword,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (state is SignInError)
                      Text(
                        state.e,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    buildInkWell2(context, cubit, state),
                    const Spacer(),
                    buildInkWell(cubit, context, state),
                    const SizedBox(
                      height: 15,
                    ),
                    buildRow(context),
                    const SizedBox(
                      height: 15,
                    ),
                    const Spacer(),
                    buildRowOr(context),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {},
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: ColorConstant.gray20005,
                                borderRadius:
                                    BorderRadiusDirectional.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(FontAwesomeIcons.google),
                                    Text(
                                      "Google",
                                      style: textStyle(
                                          context: context,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {},
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: ColorConstant.gray20005,
                                borderRadius:
                                    BorderRadiusDirectional.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(FontAwesomeIcons.github),
                                    Text(
                                      "GitHub",
                                      style: textStyle(
                                          context: context,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Row buildRowOr(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 3,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            S.of(context).or,
            style: textStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black,
              context: context,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 3,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Row buildRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).Donthaveanaccount,
          style: textStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.grey,
            context: context,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SignUpScreen();
                },
              ),
            );
          },
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              overlayColor: MaterialStatePropertyAll(Colors.white),
              padding: MaterialStatePropertyAll(EdgeInsets.zero)),
          child: Text(
            S.of(context).Signup,
            style: textStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Colors.black,
              context: context,
            ),
          ),
        ),
      ],
    );
  }

  InkWell buildInkWell2(BuildContext context, AthCubit cubit, AthState state) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              title: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .5,
                      child: Text(
                        S.of(context).receiveEmail,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTextForm(
                    controller: cubit.restController,
                    prefixIcon: const Icon(
                      Icons.alternate_email_sharp,
                      size: 14,
                    ),
                    enable: false,
                    hintText: S.of(context).EnterYourEmail,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      if (cubit.restController.text.isNotEmpty) {
                        cubit.restPassword(
                          email: cubit.restController.text,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: S.of(context).validation,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                      if (state is RestPasswordSuccess) {
                        Navigator.pop(context);
                      }
                      if (state is RestPasswordError) {
                        Fluttertoast.showToast(
                          msg: state.e,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    child: myBottom(
                      (state is RestPasswordLoading)
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              S.of(context).save,
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      child: Text(
        S.of(context).forgotPass,
        style: textStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          context: context,
        ),
      ),
    );
  }

  InkWell buildInkWell(AthCubit cubit, BuildContext context, AthState state) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        if (cubit.passController.text.isNotEmpty &&
            cubit.emailController.text.isNotEmpty) {
          cubit.signIn(
            email: cubit.emailController.text,
            pass: cubit.passController.text,
          );
        } else {
          Fluttertoast.showToast(
            msg: S.of(context).validation,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      child: myBottom(
        (state is SignInLoading)
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                S.of(context).Signin,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
