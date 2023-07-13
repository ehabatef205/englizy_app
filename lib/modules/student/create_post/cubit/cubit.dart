import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/models/post_model.dart';
import 'package:englizy_app/models/user_model.dart';
import 'package:englizy_app/modules/student/create_post/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostsCubit extends Cubit<CreatePostsStates> {
  CreatePostsCubit() : super(CreatePostsInitialState());

  static CreatePostsCubit get(context) => BlocProvider.of(context);

  TextEditingController textController = TextEditingController();

  File? postImage;
  var picker = ImagePicker();

  void removePostImage() {
    postImage = null;
    emit(CreatePostsRemovePostImageState());
  }

  /*void createPost({
    required String dateTime,
    required String text,
    required String postImage,
  }) {
    emit(CreatePostsCreatePostLoadingState());

    PostModel model = PostModel(
      name: UserModel.studentName,
      uId: UserModel.uid,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostsCreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostsCreatePostErrorState());
    });
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostsCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(CreatePostsCreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostsCreatePostErrorState());
    });
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(CreatePostsPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(CreatePostsPostImagePickedErrorState());
    }
  }*/


 // List<String> postsId = [];

  /*void getPosts()
  {
    FirebaseFirestore.instance.collection('posts').get().then((value)
    {
      value.docs.forEach((element)
      {
        element.reference
            .collection('likes')
            .get()
            .then((value)
        {
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        })
            .catchError((error){});
      });

      emit(PostsGetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PostsGetPostsErrorState(error.toString()));
    });
  }*/
}