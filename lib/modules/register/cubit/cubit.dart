
import 'package:englizy_app/modules/register/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  TextEditingController quadrupleNameController = TextEditingController();
  TextEditingController parentsPhoneNumberController = TextEditingController();
  TextEditingController studentPhoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isPassword = true;
  bool isConfirmPassword = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void passwordChange() {
    isPassword = !isPassword;
    emit(RegisterChangeState());
  }
  void confirmPasswordChange() {
    isConfirmPassword = !isConfirmPassword;
    emit(RegisterChangeState());
  }
}
