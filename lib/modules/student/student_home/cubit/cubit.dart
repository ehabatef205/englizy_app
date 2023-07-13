import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/student/student_home/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentHomeCubit extends Cubit<StudentHomeStates> {
  StudentHomeCubit() : super(StudentHomeInitialState());

  static StudentHomeCubit get(context) => BlocProvider.of(context);

  Stream<QuerySnapshot> getDemo() {
    return FirebaseFirestore.instance.collection("demo").snapshots();
  }

  Stream<QuerySnapshot> getUnits() {
    return FirebaseFirestore.instance.collection("units").orderBy("time").snapshots();
  }
}
