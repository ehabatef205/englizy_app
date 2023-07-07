import 'package:bloc/bloc.dart';
import 'package:englizy_app/modules/admin/settings_admin/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SettingsAdminCubit extends Cubit<SettingsAdminStates> {
  SettingsAdminCubit() : super(InitialSettingsAdminState());

  static SettingsAdminCubit get(context) => BlocProvider.of(context);
}
