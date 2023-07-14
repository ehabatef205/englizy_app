import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin_modules/admin_pdfs/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPDFSCubit extends Cubit<AdminPDFSStates> {
  AdminPDFSCubit() : super(AdminPDFSInitialState());

  static AdminPDFSCubit get(context) => BlocProvider.of(context);

  Stream<QuerySnapshot> getDemo() {
    return FirebaseFirestore.instance.collection("demo").snapshots();
  }

  Stream<QuerySnapshot> getPdfs() {
    return FirebaseFirestore.instance.collection("pdfs").orderBy("time").snapshots();
  }
}
