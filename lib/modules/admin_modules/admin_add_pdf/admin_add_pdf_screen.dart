import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_pdf/cubit/cubit.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_pdf/cubit/states.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_part/video_screen.dart';
import 'package:englizy_app/modules/admin_modules/admin_view_part/admin_view_part_screen.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class AdminAddPDFScreen extends StatelessWidget {
  const AdminAddPDFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => AdminAddPDFCubit(),
      child: BlocConsumer<AdminAddPDFCubit, AdminAddPDFStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminAddPDFCubit cubit = AdminAddPDFCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Add pdf"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: cubit.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          child: cubit.result != null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: cubit.result!.files.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SizedBox(
                                        width: size.width,
                                        height: size.height * 0.25,
                                        child: VideoScreen(
                                          video: cubit.result!.files[index],
                                        ),
                                      ),
                                    );
                                  })
                              : const SizedBox()),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                        controller: cubit.namePdfController,
                        type: TextInputType.text,
                        context: context,
                        labelText: "Name pdf",
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Name pdf is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            cubit.uploadVideos("", "");
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
          );
        },
      ),
    );
  }
}
