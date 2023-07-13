import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_unit/admin_add_unit_screen.dart';
import 'package:englizy_app/modules/admin_modules/admin_view_part/admin_view_part_screen.dart';
import 'package:englizy_app/modules/student/lectures/lectures_screen.dart';
import 'package:englizy_app/modules/student/student_home/cubit/cubit.dart';
import 'package:englizy_app/modules/student/student_home/cubit/states.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => StudentHomeCubit(),
      child: BlocConsumer<StudentHomeCubit, StudentHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          StudentHomeCubit cubit = StudentHomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Unit",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ),
            body: Center(
                child: Column(
              children: [
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
                StreamBuilder<QuerySnapshot>(
                  stream: cubit.getUnits(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!.docs;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LecturesScreen(
                                              id: data[index].id,
                                            )));
                              },
                              title: Text(
                                data[index]["name"],
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyText1!.color,
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            )),
          );
        },
      ),
    );
  }
}
