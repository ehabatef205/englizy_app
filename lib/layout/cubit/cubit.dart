import 'package:bloc/bloc.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:englizy_app/layout/cubit/states.dart';
import 'package:englizy_app/modules/admin/settings_admin/settings_admin_screen.dart';
import 'package:englizy_app/modules/student/home/home_screen.dart';
import 'package:englizy_app/modules/student/posts/posts_screen.dart';
import 'package:englizy_app/modules/student/settings_student/settings_student_screen.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int bottomNavIndex = 2;

  List<Widget> widgetAdmin = <Widget>[
    SettingsAdminScreen(),
    Center(
      child: Text(
        'Lectures',
      ),
    ),
    Center(
      child: Text(
        'HOME PAGE',
      ),
    ),
    Center(
      child: Text(
        'CONTACT',
      ),
    ),
    Center(
      child: Text(
        'CONTACT',
      ),
    ),
  ];

  List<Widget> widgetStudent = <Widget>[
    SettingsStudentScreen(),
    Center(
      child: Text(
        'Lectures',
      ),
    ),
    HomeScreen(),
    PostsScreen(),
    Center(
      child: Text(
        'CONTACT',
      ),
    ),
  ];

  List<TabItem> icons() {
    return [
      TabItem(
        icon: Icon(Icons.settings),
        title: 'Settings',
      ),
      TabItem(
        icon: Icon(Icons.date_range_sharp),
        title: 'community',
      ),
      TabItem(
        icon: Icon(Icons.home_outlined),
        title: 'HOME PAGE',
      ),
      TabItem(
        icon: Icon(Icons.data_exploration),
        title: 'Posts',
      ),
      TabItem(
        icon: Icon(Icons.ac_unit),
        title: 'CONTACT',
      ),
    ];
  }

  /*List<MoltenTab> icons() {
    return [
      MoltenTab(
        icon: Icon(Icons.home_outlined),
        title: Text(
          'HOME PAGE',
          style: TextStyle(
            fontSize: 9.0,
          ),
        ),
      ),
      MoltenTab(
        icon: Icon(Icons.date_range_sharp),
        title: Text(
          'Lectures',
          style: TextStyle(
            fontSize: 9.0,
          ),
        ),
      ),
      MoltenTab(
        icon: Icon(Icons.data_exploration),
        title: Text(
          'CONTACT',
          style: TextStyle(
            fontSize: 9.0,
          ),
        ),
      ),
      MoltenTab(
        icon: Icon(Icons.ac_unit),
        title: Text(
          'CONTACT',
          style: TextStyle(
            fontSize: 9.0,
          ),
        ),
      ),
      MoltenTab(
        icon: Icon(Icons.settings),
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 9.0,
          ),
        ),
      ),
    ];
  }*/

  void changeIndex(int newIndex) {
    bottomNavIndex = newIndex;
    emit(ChangeIndexState());
  }
}
