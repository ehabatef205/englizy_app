import 'package:englizy_app/modules/student/change_password/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  TextEditingController lastPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  bool isPassword = true;
  bool isPassword2 = true;
  bool isPassword3 = true;

  void passwordChange() {
    isPassword = !isPassword;
    emit(ChangeState());
  }
  void passwordChange2() {
    isPassword2 = !isPassword2;
    emit(ChangeState());
  }
  void passwordChange3() {
    isPassword3 = !isPassword3;
    emit(ChangeState());
  }
}
