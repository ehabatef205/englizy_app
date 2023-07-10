import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_unit/admin_add_unit_screen.dart';
import 'package:englizy_app/modules/admin_modules/admin_home/cubit/cubit.dart';
import 'package:englizy_app/modules/admin_modules/admin_home/cubit/states.dart';
import 'package:englizy_app/modules/admin_modules/admin_view_parts/admin_view_parts_screen.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => AdminHomeCubit(),
      child: BlocConsumer<AdminHomeCubit, AdminHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminHomeCubit cubit = AdminHomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Home"),
              actions: [
                IconButton(
                    onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => AdminAddUnitScreen()));
                    },
                    icon: Icon(Icons.add))
              ],
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
                                    physics:
                                    const NeverScrollableScrollPhysics(),
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminViewPartsScreen(dataOfUnit: data[index],)));
                                        },
                                        title: Text(data[index]["name"]),
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
