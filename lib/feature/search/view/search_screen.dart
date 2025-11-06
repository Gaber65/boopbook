import 'package:animate_do/animate_do.dart';
import 'package:boopbook/feature/authentication/view/widgets/custom_text_form_field.dart';
import 'package:boopbook/feature/search/controller/search_cubit.dart';
import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/text_style.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('Search'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  MyTextForm(
                    controller: cubit.textController,
                    hintText: 'Search For Friends',
                    prefixIcon: Icon(Icons.search),
                    onChanged: (p0) {
                      cubit.allUser.clear();
                      cubit.getAllUserData(p0);
                      cubit.nameIsEmpty(p0);
                    },
                    enabled: true,
                    obscureText: false,
                    enable: false,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (cubit.textController.text.isNotEmpty)
                    (state is GetAllUserLoadingSearchState)
                        ? FadeIn(
                            duration: const Duration(milliseconds: 400),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade600,
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return const Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 5.0,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 100,
                                    ),
                                  );
                                },
                                itemCount: 10,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 8.0,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                            cubit.allUser[index].image!,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          cubit.allUser[index].name,
                                          style: textStyle(
                                            context: context,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            cubit.follow(
                                              image:
                                                  cubit.allUser[index].image!,
                                              uId: cubit.allUser[index].uId!,
                                              name: cubit.allUser[index].name!,
                                            );
                                          },
                                          icon: CircleAvatar(
                                            radius: 20,
                                            child: Icon(IconlyBold.add_user),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: cubit.allUser.length,
                            ),
                          ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
