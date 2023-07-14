import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_pdf/admin_add_pdf_screen.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_unit/admin_add_unit_screen.dart';
import 'package:englizy_app/modules/admin_modules/admin_pdfs/cubit/cubit.dart';
import 'package:englizy_app/modules/admin_modules/admin_pdfs/cubit/states.dart';
import 'package:englizy_app/modules/admin_modules/admin_view_parts/admin_view_parts_screen.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPDFSScreen extends StatelessWidget {
  const AdminPDFSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => AdminPDFSCubit(),
      child: BlocConsumer<AdminPDFSCubit, AdminPDFSStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminPDFSCubit cubit = AdminPDFSCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("PDFS"),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminAddPDFScreen()));
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
                  stream: cubit.getPdfs(),
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
                                        builder: (context) =>
                                            AdminViewPartsScreen(
                                              dataOfUnit: data[index],
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
                                    unselectedWidgetColor: Theme.of(context).iconTheme.color
                                ),
                                child: Checkbox(
                                  activeColor: Theme.of(context).iconTheme.color,
                                  checkColor: Theme.of(context).scaffoldBackgroundColor,
                                  value: data[index]["view"],
                                  onChanged: (value) {
                                    FirebaseFirestore.instance
                                        .collection("units")
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
              ],
            )),
          );
        },
      ),
    );
  }
}
