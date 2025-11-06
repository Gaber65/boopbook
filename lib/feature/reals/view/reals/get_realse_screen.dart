import 'package:boopbook/core/utils/video_detail.dart';
import 'package:boopbook/feature/layout/controller/Layout_cubit/layout_cubit.dart';
import 'package:boopbook/feature/reals/controller/reals_cubit.dart';
import 'package:boopbook/feature/reals/view/widgets/reals/reals_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RealsScreen extends StatelessWidget {
  const RealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RealsCubit()..getRealsData()..getUserData(),
      child: BlocConsumer<RealsCubit, RealsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RealsCubit.get(context);
          return Scaffold(
            backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
            body: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 3,
              itemCount: cubit.realsModel.length,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        VideApp(
                          video: cubit.realsModel[index].video.toString(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                                cubit.realsModel[index].image.toString()),
                          ),
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        print('object');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return VideoReals(
                                model: cubit.realsModel,
                                userModel: cubit.userModel!,
                                realsIdes: cubit.realsIdes[index],
                              );
                            },
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.zoom_out_map,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
