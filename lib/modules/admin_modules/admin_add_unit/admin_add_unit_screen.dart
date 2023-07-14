import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_unit/cubit/cubit.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_unit/cubit/states.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAddUnitScreen extends StatelessWidget {
  const AdminAddUnitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => AdminAddUnitCubit(),
      child: BlocConsumer<AdminAddUnitCubit, AdminAddUnitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminAddUnitCubit cubit = AdminAddUnitCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Add unit"),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: cubit.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey),
                          child: InkWell(
                            onTap: () {
                              cubit.chooseImage();
                            },
                            child: cubit.image == null
                                ? const SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 100,
                                    ),
                                  )
                                : Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(
                                              File(
                                                cubit.image!.path,
                                              ),
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 66.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                      onEditingComplete: () {
                                        FocusScope.of(context).nextFocus();
                                      },
                                      keyboardType: TextInputType.datetime,
                                      enabled: false,
                                      controller: cubit.levelController,
                                      minLines: 1,
                                      cursorColor: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontSize: 18),
                                      decoration: InputDecoration(
                                        filled: true,
                                        hintText: "Type",
                                        hintStyle: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color!
                                                .withOpacity(0.5)),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("levels")
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          var date = snapshot.data!.docs;
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              dropdownColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              iconEnabledColor:
                                                  Theme.of(context)
                                                      .iconTheme
                                                      .color,
                                              items: date.map((item) {
                                                return DropdownMenuItem(
                                                  onTap: () {
                                                    cubit
                                                        .changeLevelId(item.id);
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
                                              onChanged: (newValue) {
                                                cubit.changeLevel(
                                                    newValue!.toString());
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
                                      })
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                          controller: cubit.nameUnitController,
                          type: TextInputType.text,
                          context: context,
                          labelText: "Unit",
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Unit is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        cubit.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                width: double.infinity,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    cubit.addUnit(context: context);
                                  },
                                  color: Colors.indigoAccent,
                                  height: 50.0,
                                  child: const Text(
                                    'Add unit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
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
