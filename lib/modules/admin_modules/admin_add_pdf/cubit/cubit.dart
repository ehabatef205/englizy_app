import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_pdf/cubit/states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class AdminAddPDFCubit extends Cubit<AdminAddPDFStates> {
  AdminAddPDFCubit() : super(AdminAddPDFInitialState());

  static AdminAddPDFCubit get(context) => BlocProvider.of(context);

  TextEditingController namePdfController = TextEditingController();
  List<TextEditingController> controllers = [];
  List<Map<String, dynamic>> questions = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  FilePickerResult? result;
  UploadTask? uploadTask;

  void choosePdf() async {
    result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);
    emit(ChangeVideoState());
  }

  Future uploadVideos(String name, String id) async {
    for (int i = 0; i < result!.files.length; i++) {
      final file = File(result!.files[i].path!);
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("pdf")
          .child(name)
          .child("${DateTime.now().millisecondsSinceEpoch}.${getName(file)}");

      uploadTask = reference.putData(await file.readAsBytes());
      await uploadTask!.whenComplete(() async {
        await reference.getDownloadURL().then((urlPdf) async {
          await FirebaseFirestore.instance.collection("pdf").add({
            "pdf": urlPdf,
            "name": namePdfController.text,
            "time": DateTime.now(),
            "view": false
          });
          emit(AddVideoState());
        });
      });
    }
  }

  String getName(File video) {
    return video.path.split(".").last;
  }
}
