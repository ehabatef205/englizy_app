import 'dart:convert';
import 'dart:io';

import 'package:englizy_app/modules/student/update_profile_student/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileStudentCubit extends Cubit<UpdateProfileStudentStates> {
  UpdateProfileStudentCubit() : super(UpdateProfileStudentInitialState());

  static UpdateProfileStudentCubit get(context) => BlocProvider.of(context);

  TextEditingController parentsPhoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? academicYear;
  String? center;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  XFile? image;
  String img64 = '';
  String dropdownValue = 'academic year';
  String dropdownValue2 = 'center';

  List<String> academicYearList = [
    'First year of high school',
    'Second year of high school',
    'Third year of high school',
  ];
  List<String> centerList = [
    'Safa1',
    'Safa2',
    'Safa3',
    'Safa4',
    'Safa5',
    'Safa6',
    'Safa7',
    'Safa8',
    'Safa9',
  ];

  void changeItem(newValue) {
    dropdownValue = newValue;
    academicYear = dropdownValue;
    emit(ChangeState());
  }

  void changeItem2(newValue) {
    dropdownValue2 = newValue;
    center = dropdownValue2;
    emit(ChangeState());
  }

  void chooseImage() async {
    image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    File imagefile = File(image!.path);

    Uint8List bytes = await imagefile.readAsBytes();

    img64 = "data:image/jpeg;base64,${base64.encode(bytes)}";

    print(img64);

    emit(ChangeImageState());
  }
}
