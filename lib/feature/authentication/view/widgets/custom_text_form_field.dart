import 'package:boopbook/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/color_constant.dart';
import '../../../../generated/l10n.dart';

class MyTextForm extends StatefulWidget {
  MyTextForm({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText,
    this.enable,
  });
  TextEditingController controller;
  String hintText;
  Widget prefixIcon;
  bool? obscureText;
  bool? enable;
  @override
  State<MyTextForm> createState() => _MyTextFormState();
}

class _MyTextFormState extends State<MyTextForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: ColorConstant.gray20005,
        borderRadius: BorderRadiusDirectional.circular(12),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        validator: (value) {
          return S.of(context).validation;
        },
        style: textStyle(
          fontSize: 13,
          context: context,

        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          counterStyle: textStyle(
            fontSize: 13,
            context: context,
          ),
          hintStyle: textStyle(
            fontSize: 12,
            context: context,
            color:  ColorConstant.blueGray400
          ),
          suffixIcon: widget.enable!
              ? IconButton(
              style:  const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  overlayColor: MaterialStatePropertyAll(Colors.white),
                  padding: MaterialStatePropertyAll(EdgeInsets.zero)),

                  onPressed: () {
                    widget.obscureText = !widget.obscureText!;
                    setState(() {});
                  },
                  icon: Icon(
                    widget.obscureText!
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 14,
                  ),
                )
              : null,
          enabledBorder: InputBorder.none,
          focusColor: ColorConstant.gray20004,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }


}


Widget myBottom(Widget widget){
  return Container(
    width: double.infinity,
    height: 52,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadiusDirectional.circular(12),

    ),
    child: Center(
      child: widget,
    ),
  );
}