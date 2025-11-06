import 'package:boopbook/core/utils/main_basic/main_bloc/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  required BuildContext context,
}) {
  return GoogleFonts.poppins(
    fontSize: fontSize ?? 14,
    fontWeight: fontWeight ?? FontWeight.w500,
    color:
        color ?? (!MainCubit.get(context).isDark ? Colors.black : Colors.white),
  );
}

Color PKColor = const Color.fromRGBO(
  56,
  76,
  255,
  1,
);
