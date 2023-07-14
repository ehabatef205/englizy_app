import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_view_part/cubit/cubit.dart';
import 'package:englizy_app/modules/admin_modules/admin_view_part/cubit/states.dart';
import 'package:englizy_app/modules/admin_modules/admin_view_part/video_screen.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class AdminViewPartScreen extends StatelessWidget {
  final String name;
  final QueryDocumentSnapshot<Object?> data;

  const AdminViewPartScreen(
      {required this.name, required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => AdminViewPartCubit(),
      child: BlocConsumer<AdminViewPartCubit, AdminViewPartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminViewPartCubit cubit = AdminViewPartCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(name),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data["videos"].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: VideoScreen(
                          video: data["videos"][index],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    data["description"],
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 20,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data["questions"].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data["questions"][index]
                                      ["question${index + 1}"],
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: data["questions"][index]
                                                      ["answer1"] ==
                                                  data["questions"][index]
                                                      ["correct"]
                                              ? Colors.green
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(data["questions"][index]
                                              ["answer1"]),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: data["questions"][index]
                                                      ["answer2"] ==
                                                  data["questions"][index]
                                                      ["correct"]
                                              ? Colors.green
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(data["questions"][index]
                                              ["answer2"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: data["questions"][index]
                                                      ["answer3"] ==
                                                  data["questions"][index]
                                                      ["correct"]
                                              ? Colors.green
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(data["questions"][index]
                                              ["answer3"]),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: data["questions"][index]
                                                      ["answer4"] ==
                                                  data["questions"][index]
                                                      ["correct"]
                                              ? Colors.green
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(data["questions"][index]
                                              ["answer4"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
