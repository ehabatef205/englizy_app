import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/layout/app_layout.dart';
import 'package:englizy_app/models/user_model.dart';
import 'package:englizy_app/modules/logIn/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  bool isPassword = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLogin = true;
  bool isLoading = false;

  void passwordChange() {
    isPassword = !isPassword;
    emit(ChangeState());
  }

  void loginChange() {
    isLogin = !isLogin;
    emit(ChangeState());
  }

  void userLogin({required BuildContext context}) {
    isLoading = true;
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailLoginController.text,
      password: passwordLoginController.text,
    )
        .then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AppScreen()),
      );
      emit(LoginSuccessState());
    }).catchError((error) {
      isLoading = false;
      emit(LoginErrorState());
    });
  }

  // Registration

  TextEditingController quadrupleNameController = TextEditingController();
  TextEditingController parentsPhoneNumberController = TextEditingController();
  TextEditingController studentPhoneNumberController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isPassword2 = true;
  bool isConfirmPassword = true;
  String dropdownValue = 'academic year';
  String? text1;
  String? text2;
  String dropdownValue2 = 'Center';

  //GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

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
    text1 = dropdownValue;
    emit(RegisterChangeState());
  }

  void changeItem2(newValue) {
    dropdownValue2 = newValue;
    text2 = dropdownValue2;
    emit(RegisterChangeState());
  }

  void passwordChange2() {
    isPassword2 = !isPassword2;
    emit(RegisterChangeState());
  }

  void confirmPasswordChange() {
    isConfirmPassword = !isConfirmPassword;
    emit(RegisterChangeState());
  }

  void userRegister({required BuildContext context}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController2.text,
    )
        .then((value) {
      userCreate(
        context: context,
        uid: value.user!.uid,
        email: emailController.text,
        parentPhone: parentsPhoneNumberController.text,
        studentName: quadrupleNameController.text,
        studentPhone: studentPhoneNumberController.text,
        center: text2,
        academicYear: text1,
      );
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  void userCreate({
    required BuildContext context,
    required studentName,
    required parentPhone,
    required studentPhone,
    required email,
    required uid,
    required academicYear,
    required center,
  }) {
    UserModel model = UserModel(
        uid: uid,
        email: email,
        studentName: studentName,
        parentPhone: parentPhone,
        studentPhone: studentPhone,
        academicYear: text1!,
        center: text2!,
        accepted: false,
        image:
            "https://firebasestorage.googleapis.com/v0/b/englizy-46f94.appspot.com/o/users%2F360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg?alt=media&token=6402503a-2de0-41a0-a4a1-7a705ab9f11d");
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(model.toMap())
        .then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AppScreen()));
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState());
    });
  }
}
