import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin/settings_admin/cubit/cubit.dart';
import 'package:englizy_app/modules/admin/settings_admin/cubit/states.dart';
import 'package:englizy_app/modules/admin/admin_level/admin_level_screen.dart';
import 'package:englizy_app/modules/admin/admin_view_students/admin_view_students_screen.dart';
import 'package:englizy_app/modules/logIn/logIn_screen.dart';
import 'package:englizy_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
          if (!cubit.isDone) {
            cubit.readDark(context);
          }
          return Scaffold(
            body: SafeArea(
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
                              Icons.person_outline,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            title: Text(
                              'Students',
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
                                          const AdminViewStudentsScreen()));
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.layers_outlined,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            title: Text(
                              'Levels',
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
                                          const AdminLevelScreen()));
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
                                    color: Theme.of(context).iconTheme.color,
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
                              FirebaseAuth.instance.signOut();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      return Center(
                          child: Text(
                        "Loading...",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ));
                    }
                  }),
            ),
          );
        },
      ),
    );
  }
}
