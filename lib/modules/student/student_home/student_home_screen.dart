import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_unit/admin_add_unit_screen.dart';
import 'package:englizy_app/modules/admin_modules/admin_view_part/admin_view_part_screen.dart';
import 'package:englizy_app/modules/student/lectures/lectures_screen.dart';
import 'package:englizy_app/modules/student/parts/parts_screen.dart';
import 'package:englizy_app/modules/student/student_home/cubit/cubit.dart';
import 'package:englizy_app/modules/student/student_home/cubit/states.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return BlocProvider(
      create: (BuildContext context) => StudentHomeCubit(),
      child: BlocConsumer<StudentHomeCubit, StudentHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          StudentHomeCubit cubit = StudentHomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Units',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
                displayFullTextOnTap: true,
              ),
              /*Text(
                "Units",
                style: TextStyle(
                  color: Theme
                      .of(context)
                      .textTheme
                      .bodyText1!
                      .color,
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
                color: Theme
                    .of(context)
                    .scaffoldBackgroundColor
                    .withOpacity(0.35),
                child: Center(
                    child: Column(
                      children: [
                        Center(
                            child: Column(
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("levels")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        var date = snapshot.data!.docs;
                                        return DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            dropdownColor:
                                            Theme
                                                .of(context)
                                                .scaffoldBackgroundColor,
                                            iconEnabledColor: Theme
                                                .of(context)
                                                .iconTheme
                                                .color,
                                            hint: Text(
                                              "Choose level",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight
                                                    .w700,),
                                            ),
                                            items: date.map((item) {
                                              return DropdownMenuItem(
                                                onTap: () {
                                                  cubit.changeLevelId(item.id);
                                                },
                                                value: item["name"],
                                                child: Text(
                                                  item["name"],
                                                  style: TextStyle(
                                                    color: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .color,
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight
                                                        .w700,),
                                                ),
                                              );
                                            }).toList(),
                                            value: cubit.level,
                                            onChanged: (newValue) {
                                              cubit.changeLevel(
                                                  newValue!.toString());
                                            },
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: color2,
                                          ),
                                        );
                                      }
                                    }),
                                StreamBuilder<QuerySnapshot>(
                                  stream: cubit.getDemo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var data = snapshot.data!.docs;
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: data.length,
                                          itemBuilder: (context, index) {
                                            return SizedBox();
                                          });
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                                FirebaseAuth.instance.currentUser == null
                                    ? Center(child: SizedBox())
                                    : StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(
                                        FirebaseAuth.instance.currentUser!.uid)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        var dataOfUser = snapshot.data;
                                        return StreamBuilder<QuerySnapshot>(
                                          stream: cubit.getUnits(),
                                          builder: (context, snapshot2) {
                                            if (snapshot2.hasData) {
                                              var data = snapshot2.data!.docs;
                                              return GridView.builder(
                                                gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 0.8,
                                                ),
                                                shrinkWrap: true,
                                                itemCount: data.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .all(
                                                        5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(5),
                                                          border: Border.all(
                                                              color: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .color!,
                                                              width: 1)
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          if (dataOfUser!["accepted"]) {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (
                                                                        context) =>
                                                                        PartsScreen(
                                                                          dataOfUnit: data[index],)));
                                                          } else {
                                                            Fluttertoast
                                                                .showToast(
                                                              msg: "Wait for accept by admin",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity: ToastGravity
                                                                  .BOTTOM,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors
                                                                  .red,
                                                              textColor: Colors
                                                                  .white,
                                                              fontSize: 16.0,
                                                            );
                                                          }
                                                        },
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: const BorderRadius
                                                                      .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                        5),
                                                                    topRight: Radius
                                                                        .circular(
                                                                        5),
                                                                    bottomRight: Radius
                                                                        .circular(
                                                                        5),
                                                                    bottomLeft: Radius
                                                                        .circular(
                                                                        5),
                                                                  ),
                                                                  image: DecorationImage(
                                                                    image: NetworkImage(
                                                                      data[index]["image"],
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Center(
                                                              child: DefaultTextStyle(
                                                                style: TextStyle(
                                                                  fontSize: 22.0,
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .color,
                                                                  fontWeight: FontWeight
                                                                      .w700,
                                                                ),
                                                                child: AnimatedTextKit(
                                                                  animatedTexts: [
                                                                    WavyAnimatedText(
                                                                        data[index]["name"]),
                                                                  ],
                                                                  isRepeatingAnimation: true,
                                                                  repeatForever: true,
                                                                ),
                                                              ),
                                                              /*TextLiquidFill(
                                                                text: data[index]["name"],
                                                                waveColor: Colors.blueAccent,
                                                                boxBackgroundColor: Colors.redAccent,
                                                                textStyle: TextStyle(
                                                                  fontSize: 18.0,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                                boxHeight: 30.0,
                                                              ),*/
                                                              /*Text(
                                                                data[index]["name"],
                                                                style: TextStyle(
                                                                  color: Theme
                                                                      .of(context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .color,
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                                maxLines: 1,
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                              ),*/
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              return const Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: color2,
                                          ),
                                        );
                                      }
                                    }),
                              ],
                            )),
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
