import 'package:englizy_app/layout/cubit/cubit.dart';
import 'package:englizy_app/layout/cubit/states.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppScreen extends StatelessWidget {
  final int indexOfScreen;
  final String userType;

  const AppScreen(
      {super.key, required this.userType, required this.indexOfScreen});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..changeIndex(indexOfScreen),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return WillPopScope(
            onWillPop: () async {
              SystemNavigator.pop();
              return Future.value(true);
            },
            child: Scaffold(
              bottomNavigationBar: FluidNavBar(
                style: FluidNavBarStyle(
                  barBackgroundColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  iconSelectedForegroundColor:
                      Theme.of(context).iconTheme.color,
                  iconUnselectedForegroundColor:
                      Theme.of(context).iconTheme.color,
                  iconBackgroundColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                ),
                animationFactor: 1,
                defaultIndex: cubit.bottomNavIndex,
                icons: cubit.icons(cubit.bottomNavIndex),
                onChange: (index) => cubit.changeIndex(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
