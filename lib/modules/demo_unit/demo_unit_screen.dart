import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin/admin_view_part/video_screen.dart';
import 'package:englizy_app/modules/demo_unit/cubit/cubit.dart';
import 'package:englizy_app/modules/demo_unit/cubit/states.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemoUnitScreen extends StatelessWidget {
  final String unitId;

  const DemoUnitScreen({super.key, required this.unitId});

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
                    'Demo Unit',
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
                child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("units")
                        .doc(unitId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                width: size.width,
                                height: size.height * 0.25,
                                child: VideoScreen(
                                  video: data["videos"],
                                ),
                              ),
                            ),
                            Text(
                              data["name"],
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              data["description"],
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              data["price"],
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              clipBehavior:
                              Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(25.0),
                              ),
                              child: MaterialButton(
                                onPressed: () {

                                },
                                color: Colors.indigo,
                                height: size.height* 0.2,
                                child: Text(
                                  'Buy Now',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text(
                            "Loading...",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                          ),
                        );
                      }
                    }),
              ),
            ),
          );
        },
      ),
    );
  }
}
