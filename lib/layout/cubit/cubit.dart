import 'package:bloc/bloc.dart';
import 'package:englizy_app/layout/cubit/states.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int bottomNavIndex = 0;

  List<Widget> studentScreens = [
    Center(child: Text("data")),
    Center(child: Text("data")),
    Center(child: Text("data")),
    Center(child: Text("data")),
    Center(child: Text("data")),
  ];

  List<Widget> adminScreens = [
    Center(child: Text("data")),
    Center(child: Text("data")),
    Center(child: Text("data")),
    Center(child: Text("data")),
    Center(child: Text("data")),
  ];

  List<FluidNavBarIcon> icons(int index) {
    return [
      FluidNavBarIcon(
        icon: Icons.home_outlined,
      ),
      FluidNavBarIcon(
        icon: Icons.date_range_sharp,
      ),
      FluidNavBarIcon(
        icon: Icons.data_exploration,
      ),
      FluidNavBarIcon(
        icon: Icons.settings,
      ),
    ];
  }

  void changeIndex(int newIndex) {
    bottomNavIndex = newIndex;
    emit(ChangeIndexState());
  }
}
