import 'package:englizy_app/layout/cubit/cubit.dart';
import 'package:englizy_app/layout/cubit/states.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            bottomNavigationBar: MoltenBottomNavigationBar(
              tabs: cubit.icons(),
              onTabChange: (index){
                cubit.changeIndex(index);
              },
              selectedIndex: cubit.bottomNavIndex,
              borderRaduis: BorderRadius.circular(25),
            ),
            body: cubit.widgetOptions[cubit.bottomNavIndex],
          );
        },
      ),
    );
  }
}

/*
BottomNavigationBar(
              items: cubit.bottomBar,
              showUnselectedLabels: true,
              backgroundColor: Colors.black,
              currentIndex: cubit.bottomNavIndex,
              onTap: (index){
                cubit.changeIndex(index);
              },
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.blueAccent,
            )
 */
