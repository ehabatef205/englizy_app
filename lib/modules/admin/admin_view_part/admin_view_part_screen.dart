import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin/admin_home/admin_home_screen.dart';
import 'package:englizy_app/modules/admin/admin_update_part/admin_update_part_screen.dart';
import 'package:englizy_app/modules/admin/admin_view_grades/admin_view_grades_screen.dart';
import 'package:englizy_app/modules/admin/admin_view_part/cubit/cubit.dart';
import 'package:englizy_app/modules/admin/admin_view_part/cubit/states.dart';
import 'package:englizy_app/modules/admin/admin_view_part/video_screen.dart';
import 'package:englizy_app/modules/admin/admin_view_parts/admin_view_parts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminViewPartScreen extends StatelessWidget {
  final String name;
  final String unitId;
  final QueryDocumentSnapshot<Object?> data;

  const AdminViewPartScreen(
      {required this.name,
      required this.unitId,
      required this.data,
      super.key});

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
              title: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("units")
                      .doc(unitId)
                      .collection("parts")
                      .doc(data.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data1 = snapshot.data!;
                      return Text(
                        data1["name"],
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      );
                    } else {
                      return Text(
                        name,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      );
                    }
                  }),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminViewGradesScreen(
                                  unitId: unitId, partId: data.id)));
                    },
                    icon: const Icon(Icons.view_agenda_outlined)),
                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("units")
                        .doc(unitId)
                        .collection("parts")
                        .doc(data.id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!;
                        return IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdminUpdatePartScreen(
                                            data: data,
                                            unitId: unitId,
                                          )));
                            },
                            icon: Icon(Icons.edit));
                      } else {
                        return const SizedBox();
                      }
                    }),
                IconButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: const Text('Do you want to delete this?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () async{
                              Navigator.pop(context);
                              Navigator.pop(context);
                              await FirebaseFirestore.instance
                                  .collection("units")
                                  .doc(unitId)
                                  .collection("parts")
                                  .doc(data.id)
                                  .collection("answers")
                                  .get()
                                  .then((value) async {
                                for (int i = 0; i < value.docs.length; i++) {
                                  await FirebaseFirestore.instance
                                      .collection("units")
                                      .doc(unitId)
                                      .collection("parts")
                                      .doc(data.id)
                                      .collection("answers")
                                      .doc(value.docs[i].id)
                                      .delete();
                                }
                              }).whenComplete(() async {
                                FirebaseFirestore.instance
                                    .collection("units")
                                    .doc(unitId)
                                    .collection("parts")
                                    .doc(data.id)
                                    .delete()
                                    .whenComplete(() {

                                });
                              });
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    ),
                    icon: const Icon(Icons.delete_outline))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                    .collection("units")
                    .doc(unitId)
                    .collection("parts")
                    .doc(data.id)
                    .snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      var data1 = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data1["videos"].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: VideoScreen(
                                  video: data1["videos"][index],
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            data1["description"],
                            style: TextStyle(
                                fontSize: 25,
                                color: Theme.of(context).textTheme.bodyText1!.color),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data1["questions"].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data1["questions"][index]
                                          ["question"],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color),
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
                                                  color: data1["questions"][index]
                                                  ["answer1"] ==
                                                      data1["questions"][index]
                                                      ["correct"]
                                                      ? Colors.green
                                                      : Colors.transparent,
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                  border:
                                                  Border.all(color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color!),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                    data1["questions"][index]
                                                    ["answer1"],
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .color),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: data1["questions"][index]
                                                  ["answer2"] ==
                                                      data1["questions"][index]
                                                      ["correct"]
                                                      ? Colors.green
                                                      : Colors.transparent,
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                  border:
                                                  Border.all(color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color!),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                    data1["questions"][index]
                                                    ["answer2"],
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .color),
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
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: data1["questions"][index]
                                                  ["answer3"] ==
                                                      data1["questions"][index]
                                                      ["correct"]
                                                      ? Colors.green
                                                      : Colors.transparent,
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                  border:
                                                  Border.all(color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color!),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                    data1["questions"][index]
                                                    ["answer3"],
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .color),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: data1["questions"][index]
                                                  ["answer4"] ==
                                                      data1["questions"][index]
                                                      ["correct"]
                                                      ? Colors.green
                                                      : Colors.transparent,
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                  border:
                                                  Border.all(color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color!),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                    data1["questions"][index]
                                                    ["answer4"],
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .color),
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
                          ),
                        ],
                      );
                    }else {
                      return Center(
                          child: Text(
                            "Loading...",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!),
                          ));
                    }
                  }
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
