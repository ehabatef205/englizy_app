import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/student/demo_unit/cubit/cubit.dart';
import 'package:englizy_app/modules/student/demo_unit/cubit/states.dart';
import 'package:englizy_app/modules/student/demo_unit/video_demo_screen.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class DemoUnitScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> unit;
  const DemoUnitScreen({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => DemoUnitCubit(),
      child: BlocConsumer<DemoUnitCubit, DemoUnitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DemoUnitCubit cubit = DemoUnitCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    unit["name"],
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
                displayFullTextOnTap: true,
              ),
            ),
            body: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/englizy.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.25,
                        child: VideoDemoScreen(
                          video: unit["video"],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              unit["name"],
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              unit["description"],
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${unit["price"]} EG",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: MaterialButton(
                                onPressed: () async =>
                                    await launch("https://wa.me/+201129257330"),
                                color: Colors.indigo,
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Buy Now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Unit content",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 20.0,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("units")
                                    .doc(unit.id)
                                    .collection("parts")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var data = snapshot.data!.docs;
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(
                                              "Part ${index + 1}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color),
                                            ),
                                          );
                                        });
                                  } else {
                                    return const SizedBox();
                                  }
                                })
                          ],
                        ),
                      )
                    ],
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
