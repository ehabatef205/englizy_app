import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_view_parts/cubit/states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class AdminViewPartsCubit extends Cubit<AdminViewPartsStates> {
  AdminViewPartsCubit() : super(AdminViewPartsInitialState());

  static AdminViewPartsCubit get(context) => BlocProvider.of(context);

  Stream<QuerySnapshot> getParts(String id) {
    return FirebaseFirestore.instance.collection("units").doc(id).collection("parts").orderBy("time").snapshots();
  }
}
