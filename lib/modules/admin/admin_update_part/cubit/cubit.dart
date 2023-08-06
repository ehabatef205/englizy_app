import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin/admin_update_part/cubit/states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class AdminUpdatePartCubit extends Cubit<AdminUpdatePartStates> {
  AdminUpdatePartCubit() : super(AdminUpdatePartInitialState());

  static AdminUpdatePartCubit get(context) => BlocProvider.of(context);

  TextEditingController descriptionPartController = TextEditingController();
  TextEditingController numberOfQuestionsController = TextEditingController();
  TextEditingController namePartController = TextEditingController();
  List<TextEditingController> controllers = [];
  List<dynamic> questions = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  VideoPlayerController? controller;
  ChewieController? chewieController;
  int numberOfQuestions = 0;
  bool isLoading = false;
  FilePickerResult? result;
  UploadTask? uploadTask;
  List<String> videosUrl = [];
  List<bool> isDone = [];

  void changeData({required DocumentSnapshot<Object?> data}) {
    namePartController.text = data["name"];
    descriptionPartController.text = data["description"];
    numberOfQuestionsController.text = data["questions"].length.toString();
    numberOfQuestions = data["questions"].length;
    questions = data["questions"];
    emit(ChangeDataState());
  }

  void createChewieController(PlatformFile video) {
    VideoPlayerController controller =
        VideoPlayerController.file(File(video.path!))..initialize();
    chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      showOptions: true,
    );
    emit(VideoState());
  }

  void removeItem(int index) {
    questions.removeAt(index);
    emit(RemoveState());
  }

  void chooseNumberOfQuestions() async {
    numberOfQuestions = int.parse(numberOfQuestionsController.text);
    int number = numberOfQuestions - questions.length;
    for (int i = 0; i < number; i++) {
      questions.add({
        "question": "",
        "answer1": "",
        "answer2": "",
        "answer3": "",
        "answer4": "",
        "correct": ""
      });
    }
    emit(ChooseNumberOfQuestionsState());
  }

  void changeQuestion(String question, int index) {
    questions[index]["question"] = question;
    emit(QuestionState());
  }

  void changeAnswer1(String answer1, int index) {
    questions[index]["answer1"] = answer1;
    emit(Answer1State());
  }

  void changeAnswer2(String answer2, int index) {
    questions[index]["answer2"] = answer2;
    emit(Answer2State());
  }

  void changeAnswer3(String answer3, int index) {
    questions[index]["answer3"] = answer3;
    emit(Answer3State());
  }

  void changeAnswer4(String answer4, int index) {
    questions[index]["answer4"] = answer4;
    emit(Answer4State());
  }

  void changeCorrect(String correct, int index) {
    questions[index]["correct"] = correct;
    emit(CorrectState());
  }

  void chooseVideo() async {
    result = await FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: true);
    for (int i = 0; i < result!.files.length; i++) {
      isDone.add(false);
    }
    emit(ChangeVideoState());
  }

  void chooseVideo2() async {
    FilePickerResult? result1 = await FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: true);
    for (int i = 0; i < result1!.files.length; i++) {
      result!.files.add(result1.files[i]);
      isDone.add(false);
    }
    emit(ChangeVideoState());
  }

  Future uploadVideos(BuildContext context, String name, String id, String partId) async {
    isLoading = true;
    emit(LoadingState());
    /*for (int i = 0; i < result!.files.length; i++) {
      final file = File(result!.files[i].path!);
      isDone[i] = true;
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("units")
          .child(name)
          .child("${DateTime.now().millisecondsSinceEpoch}.${getName(file)}");

      uploadTask = reference.putData(await file.readAsBytes());
      await uploadTask!.whenComplete(() async {
        await reference.getDownloadURL().then((urlVideo) {
          videosUrl.add((urlVideo));
          emit(AddVideoState());
        });
      });
    }

    await FirebaseFirestore.instance
        .collection("units")
        .doc(id)
        .collection("parts")
        .add({
      "name": namePartController.text,
      "videos": videosUrl,
      "description": descriptionPartController.text,
      "questions": questions,
      "time": DateTime.now(),
      "view": false,
      "viewGrade": false,
    }).whenComplete(() async {
      isLoading = false;
      emit(LoadingState());
      Navigator.pop(context);
    }).catchError((error) {
      isLoading = false;
      emit(LoadingState());
    });*/

    await FirebaseFirestore.instance
        .collection("units")
        .doc(id)
        .collection("parts")
        .doc(partId)
        .update({
      "name": namePartController.text,
      "description": descriptionPartController.text,
      "questions": questions,
    }).whenComplete(() async {
      emit(LoadingState());
      Navigator.pop(context);
      isLoading = false;
    }).catchError((error) {
      isLoading = false;
      emit(LoadingState());
    });
  }

  String getName(File video) {
    return video.path.split(".").last;
  }
}
