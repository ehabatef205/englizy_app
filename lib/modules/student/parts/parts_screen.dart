import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/student/lectures/lectures_screen.dart';
import 'package:englizy_app/modules/student/parts/cubit/cubit.dart';
import 'package:englizy_app/modules/student/parts/cubit/states.dart';
import 'package:englizy_app/modules/student/student_home/student_home_screen.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartsScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> dataOfUnit;
  const PartsScreen({super.key, required this.dataOfUnit});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => StudentViewPartsCubit(),
      child: BlocConsumer<StudentViewPartsCubit , StudentViewPartsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          StudentViewPartsCubit cubit = StudentViewPartsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title:AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Parts',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
                displayFullTextOnTap: true,
              ),
              /*Text(
                'Parts',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 20,
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
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: cubit.getParts(dataOfUnit.id),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          var data = snapshot.data!.docs;
                          return GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                            ),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context , index) {
                              return Container(
                                width: size.width * 0.35,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!
                                          .withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LecturesScreen(unitId: dataOfUnit.id, partId: data[index].id),
                                      ),
                                    );
                                  },
                                  child: Center(
                                    child: Text(
                                      'Part ${index + 1}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 20),
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
                      }
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}