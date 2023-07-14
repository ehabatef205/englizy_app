import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_unit/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AdminAddUnitCubit extends Cubit<AdminAddUnitStates> {
  AdminAddUnitCubit() : super(AdminAddUnitInitialState());

  static AdminAddUnitCubit get(context) => BlocProvider.of(context);

  TextEditingController nameUnitController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String? levelId;

  XFile? image;

  String imageUrl = "";

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
        await FirebaseFirestore.instance.collection("units").add({
          "name": nameUnitController.text,
          "level": levelId,
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
    await uploadTask!.whenComplete(() async {
      await reference.getDownloadURL().then((urlImage) {
        imageUrl = urlImage;
        emit(ChooseImageState());
      });
    });
  }

  String getName(File video) {
    return video.path.split(".").last;
  }
}
