import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/student/lectures/video_screen.dart';
import 'package:englizy_app/modules/student/lectures/cubit/cubit.dart';
import 'package:englizy_app/modules/student/lectures/cubit/states.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LecturesScreen extends StatelessWidget {
  final String unitId;
  final String partId;

  const LecturesScreen({super.key, required this.unitId, required this.partId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => LecturesCubit(),
      child: BlocConsumer<LecturesCubit, LecturesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LecturesCubit cubit = LecturesCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: cubit.index == 0 ? AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Video',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
                displayFullTextOnTap: true,
              ) : cubit.index == 1 ? AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Reading',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
                displayFullTextOnTap: true,
              ) : cubit.index == 2 ? AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Exams',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
                displayFullTextOnTap: true,
              ) : AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Lectures',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
                displayFullTextOnTap: true,
              ),
              /*Text(
                "Lectures",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),*/
            ),
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/englizy.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("units")
                                .doc(unitId)
                                .collection("parts")
                                .doc(partId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!;
                                return Column(
                                  children: [
                                    cubit.index == 0
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: data["videos"].length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: SizedBox(
                                                  width: size.width,
                                                  height: size.height * 0.25,
                                                  child: VideoScreen(
                                                    video: data["videos"]
                                                        [index],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : cubit.index == 1
                                            ? Text(
                                                data["description"],
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color,
                                                ),
                                              )
                                            : cubit.index == 2
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: data["questions"]
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .scaffoldBackgroundColor
                                                                      .withOpacity(
                                                                          0.8),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border
                                                                      .all(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .color!,
                                                                  )),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Question${index + 1}: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .color,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  data["questions"]
                                                                          [
                                                                          index]
                                                                      [
                                                                      "question${index + 1}"],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .color,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.transparent,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Theme.of(context).textTheme.bodyText1!.color!,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10),
                                                                            child:
                                                                                Text(
                                                                              data["questions"][index]["answer1"],
                                                                              style: TextStyle(
                                                                                fontSize: 18,
                                                                                color: Theme.of(context).textTheme.bodyText1!.color,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.transparent,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Theme.of(context).textTheme.bodyText1!.color!,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10),
                                                                            child:
                                                                                Text(
                                                                              data["questions"][index]["answer2"],
                                                                              style: TextStyle(
                                                                                fontSize: 18,
                                                                                color: Theme.of(context).textTheme.bodyText1!.color,
                                                                              ),
                                                                            ),
                                                                          ),
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
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.transparent,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Theme.of(context).textTheme.bodyText1!.color!,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10),
                                                                            child:
                                                                                Text(
                                                                              data["questions"][index]["answer3"],
                                                                              style: TextStyle(
                                                                                fontSize: 18,
                                                                                color: Theme.of(context).textTheme.bodyText1!.color,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.transparent,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Theme.of(context).textTheme.bodyText1!.color!,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10),
                                                                            child:
                                                                                Text(
                                                                              data["questions"][index]["answer4"],
                                                                              style: TextStyle(
                                                                                fontSize: 18,
                                                                                color: Theme.of(context).textTheme.bodyText1!.color,
                                                                              ),
                                                                            ),
                                                                          ),
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
                                                  )
                                                : CircularProgressIndicator(),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: size.width * 0.25,
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            child: MaterialButton(
                                              onPressed: () {
                                                cubit.changeIndex();
                                                if(cubit.index == 2){
                                                  cubit.done = true;
                                                }
                                                if(cubit.textName == "Done"){
                                                  Navigator.pop(context);
                                                }
                                              },
                                              color: Colors.indigo,
                                              height: 50.0,
                                              child: Text(
                                                cubit.done != true ? 'Next' : 'Done',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
