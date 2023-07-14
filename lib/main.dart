import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/MyBlocObserver.dart';
import 'package:englizy_app/layout/app_layout.dart';
import 'package:englizy_app/models/user_model.dart';
import 'package:englizy_app/modules/logIn/logIn_screen.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:englizy_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'modules/admin_modules/admin_home/admin_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser != null){
      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value){
        userModel = UserModel.fromjson(value.data()!);
        print(userModel!.level);
      });
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Consumer<ThemeNotifier>(
              builder: (context, ThemeNotifier theme, _) => MaterialApp(
                title: 'Englizy',
                theme: theme.getTheme(),
                debugShowCheckedModeBanner: false,
                home: FirebaseAuth.instance.currentUser == null? LoginScreen() : AppScreen(),
              ),
            );
          }),
    );
  }
}
