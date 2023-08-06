import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin/admin_add_part/admin_add_part_screen.dart';
import 'package:englizy_app/modules/admin/admin_home/admin_home_screen.dart';
import 'package:englizy_app/modules/admin/admin_update_unit/admin_update_unit_screen.dart';
import 'package:englizy_app/modules/admin/admin_view_part/admin_view_part_screen.dart';
import 'package:englizy_app/modules/admin/admin_view_parts/cubit/cubit.dart';
import 'package:englizy_app/modules/admin/admin_view_parts/cubit/states.dart';
import 'package:englizy_app/modules/admin/admin_view_students_in_homework/admin_view_students_in_homrwork_screen.dart';
import 'package:englizy_app/modules/admin/admin_view_students_in_unit/admin_view_students_in_unit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminViewPartsScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> dataOfUnit;

  const AdminViewPartsScreen({required this.dataOfUnit, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => AdminViewPartsCubit(),
      child: BlocConsumer<AdminViewPartsCubit, AdminViewPartsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminViewPartsCubit cubit = AdminViewPartsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("units")
                      .doc(dataOfUnit.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!;
                      return Text(
                        data["name"],
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      );
                    } else {
                      return Text(
                        dataOfUnit["name"],
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
                              builder: (context) =>
                                  AdminAddPartScreen(data: dataOfUnit)));
                    },
                    icon: const Icon(Icons.add)),
                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("units")
                        .doc(dataOfUnit.id)
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
                                          AdminUpdateUnitScreen(data: data)));
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
                                  .doc(dataOfUnit.id)
                                  .collection("parts")
                                  .get()
                                  .then((value) async {
                                for (int i = 0; i < value.docs.length; i++) {
                                  await FirebaseFirestore.instance
                                      .collection("units")
                                      .doc(dataOfUnit.id)
                                      .collection("parts")
                                      .doc(value.docs[i].id)
                                      .collection("answers")
                                      .get()
                                      .then((value2) async {
                                    for (int j = 0; j < value2.docs.length; j++) {
                                      await FirebaseFirestore.instance
                                          .collection("units")
                                          .doc(dataOfUnit.id)
                                          .collection("parts")
                                          .doc(value.docs[i].id)
                                          .collection("answers")
                                          .doc(value2.docs[j].id)
                                          .delete();
                                    }

                                    await FirebaseFirestore.instance
                                        .collection("units")
                                        .doc(dataOfUnit.id)
                                        .collection("parts")
                                        .doc(value.docs[i].id)
                                        .delete();
                                  });
                                }
                              }).whenComplete(() async {
                                await FirebaseFirestore.instance
                                    .collection("units")
                                    .doc(dataOfUnit.id)
                                    .collection("homework")
                                    .get()
                                    .then((value) async {
                                  for (int i = 0; i < value.docs.length; i++) {
                                    await FirebaseFirestore.instance
                                        .collection("units")
                                        .doc(dataOfUnit.id)
                                        .collection("homework")
                                        .doc(value.docs[i].id)
                                        .delete();
                                  }
                                }).whenComplete(() async {
                                  FirebaseFirestore.instance
                                      .collection("units")
                                      .doc(dataOfUnit.id)
                                      .delete()
                                      .whenComplete(() {
                                    Navigator.pop(context);
                                  });
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
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminViewStudentsInUnitScreen(
                            unitId: dataOfUnit.id,
                          ),
                        ),
                      );
                    },
                    title: Text(
                      "Students",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminViewStudentsInHomeworkScreen(
                            unit: dataOfUnit,
                          ),
                        ),
                      );
                    },
                    title: Text(
                      "Homework",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: cubit.getParts(dataOfUnit.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!.docs;
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminViewPartScreen(
                                                  name: data[index]["name"],
                                                  unitId: dataOfUnit.id,
                                                  data: data[index],
                                                )));
                                  },
                                  title: Text(
                                    data[index]["name"],
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color),
                                  ),
                                  trailing: Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor:
                                            Theme.of(context).iconTheme.color),
                                    child: Checkbox(
                                      activeColor:
                                          Theme.of(context).iconTheme.color,
                                      checkColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      value: data[index]["view"],
                                      onChanged: (value) {
                                        FirebaseFirestore.instance
                                            .collection("units")
                                            .doc(dataOfUnit.id)
                                            .collection("parts")
                                            .doc(data[index].id)
                                            .update({"view": value});
                                      },
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
