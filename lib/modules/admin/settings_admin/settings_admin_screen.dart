import 'package:englizy_app/modules/admin/settings_admin/cubit/cubit.dart';
import 'package:englizy_app/modules/admin/settings_admin/cubit/states.dart';
import 'package:englizy_app/modules/logIn/logIn_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsAdminScreen extends StatelessWidget {
  const SettingsAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SettingsAdminCubit(),
      child: BlocConsumer<SettingsAdminCubit, SettingsAdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SettingsAdminCubit cubit = SettingsAdminCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
