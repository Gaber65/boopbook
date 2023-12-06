import 'package:animate_do/animate_do.dart';
import 'package:boopbook/feature/layout/controller/feeds_cubit/feeds_cubit.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utils/color_constant.dart';
import '../../../../authentication/view/widgets/custom_text_form_field.dart';
import '../../../controller/Layout_cubit/layout_cubit.dart';

Widget buildWhatsonyourmindSanjay(BuildContext context, FeedsCubit cubit) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      (cubit.userModel != null)
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                cubit.userModel!.image!.values!.first,
                height: 35,
                width: 35,
                fit: BoxFit.cover,
              ),
            )
          : FadeIn(
              duration: const Duration(milliseconds: 400),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade700,
                highlightColor: Colors.grey.shade600,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://img.freepik.com/free-photo/daily-life-indigenous-people_52683-96788.jpg?t=st=1701875207~exp=1701875807~hmac=be11372415da7a950c444f6e29a88c336efb568dd5b95942291c088bf20cec4c',
                    height: 35,
                    width: 35,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
          child: SizedBox(
            height: 38,
            child: MyTextForm(
              controller: TextEditingController(),
              hintText:
                  'What’s on your mind, ${cubit.userModel != null ? cubit.userModel!.name!.values!.first : ''}?',
              obscureText: false,
              enable: false,
              prefixIcon: const Icon(
                IconlyLight.image,
                size: 16,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstant.gray20005,
            borderRadius: BorderRadiusDirectional.circular(12),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              IconlyLight.search,
              size: 16,
            ),
          ),
        ),
      )
    ],
  );
}
