import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin/admin_add_unit/cubit/states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AdminAddUnitCubit extends Cubit<AdminAddUnitStates> {
  AdminAddUnitCubit() : super(AdminAddUnitInitialState());

  static AdminAddUnitCubit get(context) => BlocProvider.of(context);

  TextEditingController nameUnitController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController descriptionUnitController = TextEditingController();
  TextEditingController priceUnitController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  FilePickerResult? pdf;
  UploadTask? uploadTask;

  FilePickerResult? result;
  UploadTask? uploadTask2;

  String? levelId;

  XFile? image;

  String imageUrl = "";
  String videoUrl = "";
  String pdfUrl = "";

  void chooseImage() async {
    image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    emit(ChangeImageState());
  }

  void changeLevelId(String? id) {
    levelId = id;
    emit(ChangeState());
  }

  void changeLevel(String? level) {
    levelController.text = level!;
    emit(ChangeIsAddState());
  }

  Future<void> addUnit({required BuildContext context}) async {
    if (formKey.currentState!.validate() && image != null) {
      formKey.currentState!.save();
      isLoading = true;
      emit(LoadingState());
      uploadPhoto().whenComplete(() async {
        uploadVideo().whenComplete(() async {
          uploadPdf().whenComplete(() async {
            await FirebaseFirestore.instance.collection("units").add({
              "name": nameUnitController.text,
              "level": levelId,
              "video": videoUrl,
              "homework": pdfUrl,
              "description": descriptionUnitController.text,
              "price": priceUnitController.text,
              "students": [],
              "view": false,
              "image": imageUrl,
              "time": DateTime.now(),
            }).whenComplete(() async {
              isLoading = false;
              Navigator.pop(context);
              emit(LoadingSuccessState());
            }).catchError((error) {
              emit(LoadingErrorState());
            });
          });
        });
      });
    }
  }

  Future uploadPhoto() async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("units")
        .child(nameUnitController.text)
        .child(
            "${DateTime.now().millisecondsSinceEpoch}.${getName(File(image!.path))}");

    UploadTask uploadTask =
        reference.putData(await File(image!.path).readAsBytes());
    await uploadTask.whenComplete(() async {
      await reference.getDownloadURL().then((urlImage) {
        imageUrl = urlImage;
        emit(ChooseImageState());
      });
    });
  }

  String getName(File video) {
    return video.path.split(".").last;
  }

  void chooseVideo() async {
    result = await FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: false);
    emit(ChangeVideoState());
  }

  void choosePdf() async {
    pdf = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["pdf"],
        allowMultiple: false);
    emit(ChangePDFState());
  }

  Future uploadPdf() async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("units")
        .child("pdfs")
        .child(
            "${DateTime.now().millisecondsSinceEpoch}.${getName(File(pdf!.files[0].path!))}");

    uploadTask =
        reference.putData(await File(pdf!.files[0].path!).readAsBytes());
    await uploadTask!.whenComplete(() async {
      await reference.getDownloadURL().then((urlPdf) async {
        pdfUrl = urlPdf;
        emit(AddPDFState());
      });
    });
  }

  Future uploadVideo() async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("units")
        .child("videos")
        .child(
            "${DateTime.now().millisecondsSinceEpoch}.${getName(File(result!.files[0].path!))}");

    uploadTask2 =
        reference.putData(await File(result!.files[0].path!).readAsBytes());
    await uploadTask2!.whenComplete(() async {
      await reference.getDownloadURL().then((urlVideo) async {
        videoUrl = urlVideo;
        emit(AddPDFState());
      });
    });
  }
}
