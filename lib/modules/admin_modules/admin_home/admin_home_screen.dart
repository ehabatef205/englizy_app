import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_unit/admin_add_unit_screen.dart';
import 'package:englizy_app/modules/admin_modules/admin_home/cubit/cubit.dart';
import 'package:englizy_app/modules/admin_modules/admin_home/cubit/states.dart';
import 'package:englizy_app/modules/admin_modules/admin_view_parts/admin_view_parts_screen.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:englizy_app/shared/constant.dart';
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminAddUnitScreen()));
                    },
                    icon: Icon(Icons.add))
              ],
            ),
            body: Center(
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
                                Theme.of(context).scaffoldBackgroundColor,
                            iconEnabledColor: Theme.of(context).iconTheme.color,
                            hint: const Text(
                              "Choose level",
                              style: TextStyle(color: Colors.grey),
                            ),
                            items: date.map((item) {
                              return DropdownMenuItem(
                                onTap: (){
                                  cubit.changeLevelId(item.id);
                                },
                                value: item["name"],
                                child: Text(
                                  item["name"],
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color),
                                ),
                              );
                            }).toList(),
                            value: cubit.level,
                            onChanged: (newValue) {
                              cubit.changeLevel(newValue!.toString());
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
                cubit.level == null
                    ? const SizedBox()
                    : StreamBuilder<QuerySnapshot>(
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
                cubit.level == null
                    ? const SizedBox()
                    : StreamBuilder<QuerySnapshot>(
                        stream: cubit.getUnits(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!.docs;
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
                                  padding: const EdgeInsets.all(5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Theme.of(context).textTheme.bodyText1!.color!, width: 1)
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AdminViewPartsScreen(
                                                      dataOfUnit: data[index],
                                                    )));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomRight: Radius.circular(5),
                                                  bottomLeft: Radius.circular(5),
                                                ),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    data[index]["image"],
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Center(
                                            child: Text(
                                              data[index]["name"],
                                              style: TextStyle(
                                                color: Theme.of(context).textTheme.bodyText1!.color,
                                                fontSize: 15,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
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
                      ),
              ],
            )),
          );
        },
      ),
    );
  }
}
