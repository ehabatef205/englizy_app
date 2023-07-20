import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin/admin_add_pdf/cubit/states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAddPDFCubit extends Cubit<AdminAddPDFStates> {
  AdminAddPDFCubit() : super(AdminAddPDFInitialState());

  static AdminAddPDFCubit get(context) => BlocProvider.of(context);

  TextEditingController namePdfController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  List<TextEditingController> controllers = [];
  List<Map<String, dynamic>> questions = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  FilePickerResult? pdf;
  UploadTask? uploadTask;

  String? levelId;
  String? level;

  void changeLevel(String? level) {
    levelController.text = level!;
    emit(ChangeState());
  }

  void changeLevelId(String? newLevel) {
    levelId = newLevel;
    emit(ChangeState());
  }

  void choosePdf() async {
    pdf = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"], allowMultiple: false);
    emit(ChangePDFState());
  }

  Future uploadPdf({required BuildContext context}) async {
    isLoading = true;
    emit(LoadingState());
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("pdf")
          .child(namePdfController.text)
          .child("${DateTime.now().millisecondsSinceEpoch}.${getName(File(pdf!.files[0].path!))}");

      uploadTask = reference.putData(await File(pdf!.files[0].path!).readAsBytes());
      await uploadTask!.whenComplete(() async {
        await reference.getDownloadURL().then((urlPdf) async {
          await FirebaseFirestore.instance.collection("pdfs").add({
            "pdf": urlPdf,
            "name": namePdfController.text,
            "time": DateTime.now(),
            "level": levelId,
            "view": false
          }).whenComplete(() async{
            Navigator.pop(context);
          });
          emit(AddVideoState());
        });
      }).catchError((error) {
        isLoading = false;
        emit(LoadingErrorState());
      });
  }

  String getName(File video) {
    return video.path.split(".").last;
  }
}
