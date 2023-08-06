import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin/admin_update_unit/cubit/states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AdminUpdateUnitCubit extends Cubit<AdminUpdateUnitStates> {
  AdminUpdateUnitCubit() : super(AdminUpdateUnitInitialState());

  static AdminUpdateUnitCubit get(context) => BlocProvider.of(context);

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

  void changeDataState({required DocumentSnapshot<Object?> data}) {
    nameUnitController.text = data["name"];
    priceUnitController.text = data["price"];
    descriptionUnitController.text = data["description"];
    FirebaseFirestore.instance
        .collection("levels")
        .doc(data["level"])
        .get()
        .then((value) {
      levelController.text = value["name"];
    });
    emit(ChangeDataState());
  }

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

  Future<void> addUnit(
      {required BuildContext context,
      required DocumentSnapshot<Object?> data}) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      isLoading = true;
      emit(LoadingState());
      uploadPhoto(url: data["image"]).whenComplete(() async {
        uploadVideo(url: data["video"]).whenComplete(() async {
          uploadPdf(url: data["homework"]).whenComplete(() async {
            await FirebaseFirestore.instance
                .collection("units")
                .doc(data.id)
                .update({
              "name": nameUnitController.text,
              "level": levelId == null ? data["level"] : levelId,
              "video": result == null ? data["video"] : videoUrl,
              "homework": pdf == null ? data["homework"] : pdfUrl,
              "description": descriptionUnitController.text,
              "price": priceUnitController.text,
              "image": image == null ? data["image"] : imageUrl,
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

  Future uploadPhoto({required String url}) async {
    if (image != null) {
      FirebaseStorage.instance.refFromURL(url).delete();
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("units")
          .child(nameUnitController.text)
          .child(
              "${DateTime.now().millisecondsSinceEpoch}.${getName(File(image!.path))}");

      UploadTask uploadTask =
          reference.putData(await File(image!.path).readAsBytes());
      await uploadTask!.whenComplete(() async {
        await reference.getDownloadURL().then((urlImage) {
          imageUrl = urlImage;
          emit(ChooseImageState());
        });
      });
    }
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

  Future uploadPdf({required String url}) async {
    if (pdf != null) {
      FirebaseStorage.instance.refFromURL(url).delete();
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
  }

  Future uploadVideo({required String url}) async {
    if (result != null) {
      FirebaseStorage.instance.refFromURL(url).delete();
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
}
