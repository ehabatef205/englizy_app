import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/models/post_model.dart';
import 'package:englizy_app/models/user_model.dart';
import 'package:englizy_app/modules/student/create_post/cubit/states.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostsCubit extends Cubit<CreatePostsStates> {
  CreatePostsCubit() : super(CreatePostsInitialState());

  static CreatePostsCubit get(context) => BlocProvider.of(context);

  TextEditingController textController = TextEditingController();

  void createPost({required BuildContext context}) {
    if (textController.text.trim() != "") {
      FirebaseFirestore.instance.collection('posts').add({
        "uid": userModel!.uid,
        "time": DateTime.now(),
        "text": textController.text,
        "view": true
      }).then((value) {
        Navigator.pop(context);
        emit(CreatePostsCreatePostSuccessState());
      }).catchError((error) {
        emit(CreatePostsCreatePostErrorState());
      });
    }
  }
}
