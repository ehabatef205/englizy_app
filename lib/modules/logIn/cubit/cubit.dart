import 'package:englizy_app/modules/logIn/cubit/states.dart';
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

  void passwordChange() {
    isPassword = !isPassword;
    emit(ChangeState());
  }
}
