import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/models/post_model.dart';
import 'package:englizy_app/modules/student/posts/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsCubit extends Cubit<PostsStates> {
  PostsCubit() : super(PostsInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);
  
  Stream<QuerySnapshot> getPosts(){
    return FirebaseFirestore.instance.collection("posts").orderBy("time").snapshots();
  }
}