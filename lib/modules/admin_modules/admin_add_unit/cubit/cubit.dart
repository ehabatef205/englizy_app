import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_add_unit/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAddUnitCubit extends Cubit<AdminAddUnitStates> {
  AdminAddUnitCubit() : super(AdminAddUnitInitialState());

  static AdminAddUnitCubit get(context) => BlocProvider.of(context);

  TextEditingController nameUnitController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isAdd = false;
  bool isLoading = false;

  void changeIsAdd() {
    isAdd = !isAdd;
    emit(ChangeIsAddState());
  }

  Future<void> addUnit() async{
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      isLoading = true;
      emit(LoadingState());
      await FirebaseFirestore.instance.collection("units").add({
        "name": nameUnitController.text,
        "time": DateTime.now(),
      }).whenComplete(() async{
        isAdd = false;
        isLoading = false;
        emit(LoadingSuccessState());
      }).catchError((error) {
        isLoading = false;
        emit(LoadingErrorState());
      });
    }
  }
}
