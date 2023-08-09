import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/logIn/logIn_screen.dart';
import 'package:englizy_app/modules/student/change_password/change_password_screen.dart';
import 'package:englizy_app/modules/student/settings_student/cubit/cubit.dart';
import 'package:englizy_app/modules/student/settings_student/cubit/states.dart';
import 'package:englizy_app/modules/student/update_profile_student/update_profile_screen.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:englizy_app/shared/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SettingsStudentScreen extends StatelessWidget {
  const SettingsStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => SettingsStudentCubit(),
      child: BlocConsumer<SettingsStudentCubit, SettingsStudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SettingsStudentCubit cubit = SettingsStudentCubit.get(context);
          if (!cubit.isDone) {
            cubit.readDark(context);
          }
          return Scaffold(
            appBar: AppBar(
              leading: const SizedBox(),
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Color.fromRGBO(102, 144, 206, 1),
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            body: SafeArea(
              child: Container(
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/englizy.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  height: size.height,
                  width: size.width,
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.4),
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("app")
                          .doc("t2FTNJm5pTGqCbfg8v1T")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data;
                          return ListView(
                            children: [
                              ListTile(
                                title: Text(
                                  "Dark Mode",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                ),
                                trailing: Consumer<ThemeNotifier>(
                                    builder: (context, theme, _) {
                                  return CupertinoSwitch(
                                    value: cubit.isDark,
                                    onChanged: (value) {
                                      cubit.changeMode(theme, context);
                                    },
                                  );
                                }),
                                leading: Icon(
                                  Icons.dark_mode,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                title: Text(
                                  "Update Profile",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const UpdateProfileStudentScreen()));
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.password,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                title: Text(
                                  'Change password',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ChangePasswordScreen()));
                                },
                              ),
                              data!["delete_account"]
                                  ? ListTile(
                                      onTap: () {
                                        showDialog<String>(
                                          context: context,
                                          builder:
                                              (BuildContext context) =>
                                              AlertDialog(
                                                content: const Text(
                                                    'Do you want to delete this?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context),
                                                    child: const Text('No'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      cubit.deleteAccount(context);
                                                    },
                                                    child: const Text('Yes'),
                                                  ),
                                                ],
                                              ),
                                        );
                                      },
                                      title: Text(
                                        "Delete account",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                        ),
                                      ),
                                      leading: Icon(
                                        Icons.delete_outline,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                    )
                                  : const SizedBox(),
                              ListTile(
                                leading: Icon(
                                  Icons.logout_outlined,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                title: Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                ),
                                onTap: () {
                                  cubit.signOut(context: context);
                                },
                              ),
                            ],
                          );
                        } else {
                          return Center(
                              child: Text(
                            "Loading...",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                          ));
                        }
                      }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
