import 'package:englizy_app/layout/app_layout.dart';
import 'package:englizy_app/modules/logIn/cubit/cubit.dart';
import 'package:englizy_app/modules/logIn/cubit/states.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            body: Stack(
              //alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: SafeArea(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Form(
                            key: cubit.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.25,
                                ),
                                cubit.isLogin
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Hello dear student",
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.bodyText1!.color,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Text(
                                            "We'd love you to join us",
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.bodyText1!.color,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextFormFieldWidget(
                                            controller:
                                                cubit.emailLoginController,
                                            type: TextInputType.emailAddress,
                                            context: context,
                                            labelText: "Email",
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return "Email is required";
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          TextFormFieldWidget(
                                            controller:
                                                cubit.passwordLoginController,
                                            type: TextInputType.visiblePassword,
                                            context: context,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                cubit.isPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Theme.of(context).iconTheme.color,
                                              ),
                                              onPressed: () {
                                                cubit.passwordChange();
                                              },
                                              color: Colors.black,
                                            ),
                                            labelText: "Password",
                                            obscureText: cubit.isPassword,
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return "password is required";
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                },
                                                child: Text(
                                                  "Forgot your password?",
                                                  style: TextStyle(
                                                    color: Theme.of(context).textTheme.bodyText1!.color,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 30.0,
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Hello dear student",
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.bodyText1!.color,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormFieldWidget(
                                            controller:
                                                cubit.quadrupleNameController,
                                            type: TextInputType.name,
                                            context: context,
                                            labelText: "Quadruple name",
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return "Quadruple name is required";
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          DropdownButtonFormField(
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Theme.of(context).textTheme.bodyText1!.color!,
                                                    width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Theme.of(context).textTheme.bodyText1!.color!,
                                                    width: 1),
                                              ),
                                              filled: true,
                                            ),
                                            hint: Text(cubit.dropdownValue),
                                            onChanged: (String? newValue) {
                                              cubit.changeItem(newValue);
                                            },
                                            style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color!),
                                            items: cubit.academicYearList.map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          DropdownButtonFormField(
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Theme.of(context).textTheme.bodyText1!.color!,
                                                    width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Theme.of(context).textTheme.bodyText1!.color!,
                                                    width: 1),
                                              ),
                                              filled: true,
                                            ),
                                            hint: Text(cubit.dropdownValue2!, style: TextStyle(color: Colors.grey, fontSize: 20),),
                                            onChanged: (String? newValue) {
                                              cubit.changeItem2(newValue);
                                            },
                                            items: cubit.centerList.map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          TextFormFieldWidget(
                                            controller: cubit
                                                .parentsPhoneNumberController,
                                            type: TextInputType.phone,
                                            context: context,
                                            labelText: "Parent's phone number",
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return "Parent's phone number is required";
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          TextFormFieldWidget(
                                            controller: cubit
                                                .studentPhoneNumberController,
                                            type: TextInputType.phone,
                                            context: context,
                                            labelText: "Student Phone Number",
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return "Student Phone Number is required";
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          TextFormFieldWidget(
                                            controller:
                                                cubit.passwordController2,
                                            type: TextInputType.visiblePassword,
                                            context: context,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                cubit.isPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Theme.of(context).iconTheme.color,
                                              ),
                                              onPressed: () {
                                                cubit.passwordChange();
                                              },
                                              color: Colors.black,
                                            ),
                                            labelText: "Password",
                                            obscureText: cubit.isPassword,
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return "password is required";
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          TextFormFieldWidget(
                                            controller:
                                                cubit.confirmPasswordController,
                                            type: TextInputType.visiblePassword,
                                            context: context,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                cubit.isConfirmPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Theme.of(context).iconTheme.color,
                                              ),
                                              onPressed: () {
                                                cubit.confirmPasswordChange();
                                              },
                                              color: Colors.black,
                                            ),
                                            labelText: "Confirm Password",
                                            obscureText: cubit.isPassword,
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return "Confirm Password is required";
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Text(
                                              "The email used to reset the password",
                                              style: TextStyle(
                                                color: Theme.of(context).textTheme.bodyText1!.color!,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          TextFormFieldWidget(
                                            controller: cubit.emailController,
                                            type: TextInputType.emailAddress,
                                            context: context,
                                            labelText: "Email",
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return "Email is required";
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                        ],
                                      ),
                                //LogIn
                                cubit.isLoading ? Center(
                                  child: CircularProgressIndicator(),
                                ) : Container(
                                  width: double.infinity,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (cubit.isLogin) {
                                        if (cubit.formKey.currentState!
                                            .validate()) {
                                          cubit.formKey.currentState!.save();
                                          cubit.userLogin(context: context);
                                        }
                                      } else {
                                        if (cubit.formKey.currentState!
                                            .validate()) {
                                          cubit.formKey.currentState!.save();
                                          cubit.userRegister(context: context);
                                        }
                                      }
                                    },
                                    color: Colors.indigo,
                                    height: 50.0,
                                    child: Text(
                                      cubit.isLogin ? 'Login' : 'Register',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Center(
                                  child: Text(
                                    "OR",
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodyText1!.color!,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      /*Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RegisterScreen()),
                                      );*/
                                      cubit.loginChange();
                                    },
                                    color: Colors.indigoAccent,
                                    height: 50.0,
                                    child: Text(
                                      cubit.isLogin ? 'Register' : 'Login',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    ClipPath(
                      clipper: ClippingClass3(),
                      child: Container(
                        color: color3,
                        height: size.height * 0.4,
                        width: size.width,
                      ),
                    ),
                    ClipPath(
                      clipper: ClippingClass2(),
                      child: Container(
                        color: color2,
                        height: size.height * 0.38,
                        width: size.width,
                      ),
                    ),
                    ClipPath(
                      clipper: ClippingClass(),
                      child: Container(
                        color: color1,
                        height: size.height * 0.25,
                        width: size.width,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.isLogin ? "Login" : "Registration",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginScreen()));
                                  },
                                  child: Text(
                                    "Support",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 2);
    path.cubicTo(size.width * 0.3, size.height, size.width / 2, size.height,
        size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ClippingClass2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 2);
    path.cubicTo(size.width * 0.1, size.height, size.width * 0.9,
        size.height * 0.5, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ClippingClass3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.51);
    path.cubicTo(size.width * 0.1, size.height, size.width * 0.9,
        size.height * 0.5, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
