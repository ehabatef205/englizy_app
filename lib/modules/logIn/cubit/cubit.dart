import 'package:cloud_firestore/cloud_firestore.dart';
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
  TextEditingController studentNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLogin = true;
  void passwordChange() {
    isPassword = !isPassword;
    emit(ChangeState());
  }

  void loginChange() {
    isLogin = !isLogin;
    emit(ChangeState());
  }

  void userLogin() {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      emit(LoginSuccessState());
    }).catchError((error) {
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
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  void passwordChange2() {
    isPassword2 = !isPassword2;
    emit(RegisterChangeState());
  }

  void confirmPasswordChange() {
    isConfirmPassword = !isConfirmPassword;
    emit(RegisterChangeState());
  }

  void userRegister() {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController2.text,
    )
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      userCreate(
        uid: value.user!.uid,
        email: emailController.text,
        parentPhone: parentsPhoneNumberController.text,
        studentName: quadrupleNameController.text,
        studentPhone: studentPhoneNumberController.text,
      );
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  void userCreate({
    required studentName,
    required parentPhone,
    required studentPhone,
    required email,
    required uid,
  }) {
    UserModel model = UserModel(
      uid: uid,
      email: email,
      studentName: studentName,
      parentPhone: parentPhone,
      studentPhone: studentPhone,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState());
    });
  }
}
