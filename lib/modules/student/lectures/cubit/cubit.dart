import 'package:englizy_app/modules/student/lectures/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LecturesCubit extends Cubit<LecturesStates> {
  LecturesCubit() : super(LecturesInitialState());

  static LecturesCubit get(context) => BlocProvider.of(context);

  int index = 0;
  bool done = false;
  String textName = "Next";

  void changeIndex(){
    index++;
    emit(ChangeState());
  }

  void changeTextName(){
    textName = "Done";
    emit(ChangeState());
  }
}