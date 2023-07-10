import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_part/admin_add_part_screen.dart';
import 'package:englizy_app/modules/admin_modules/admin_view_part/admin_view_part_screen.dart';
import 'package:englizy_app/modules/admin_modules/admin_view_parts/cubit/cubit.dart';
import 'package:englizy_app/modules/admin_modules/admin_view_parts/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminViewPartsScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> dataOfUnit;

  const AdminViewPartsScreen({required this.dataOfUnit, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return BlocProvider(
      create: (BuildContext context) => AdminViewPartsCubit(),
      child: BlocConsumer<AdminViewPartsCubit, AdminViewPartsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminViewPartsCubit cubit = AdminViewPartsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(dataOfUnit["name"]),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AdminAddPartScreen(data: dataOfUnit)));
                    },
                    icon: Icon(Icons.add))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: StreamBuilder<QuerySnapshot>(
                stream: cubit.getParts(dataOfUnit.id),
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
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AdminViewPartScreen(name: "Part ${index + 1}", data: data[index],)));
                            },
                            title: Text("Part ${index + 1}"),
                            trailing: Checkbox(
                              value: data[index]["view"],
                              onChanged: (value){
                                FirebaseFirestore.instance.collection("units").doc(dataOfUnit.id).collection("parts").doc(data[index].id).update({
                                  "view": value
                                });
                              },
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
          );
        },
      ),
    );
  }
}
