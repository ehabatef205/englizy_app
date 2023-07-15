import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/student/parts/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentViewPartsCubit extends Cubit<StudentViewPartsStates> {
  StudentViewPartsCubit() : super(StudentViewPartsInitialState());

  static StudentViewPartsCubit get(context) => BlocProvider.of(context);

  Stream<QuerySnapshot> getParts(String id) {
    return FirebaseFirestore.instance.collection("units").doc(id).collection("parts").orderBy("time").snapshots();
  }
}