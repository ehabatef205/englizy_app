import 'package:englizy_app/modules/logIn/cubit/cubit.dart';
import 'package:englizy_app/modules/logIn/cubit/states.dart';
import 'package:englizy_app/modules/register/register_screen.dart';
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
            /*appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Login",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              elevation: 1,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    "Support",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),*/
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
                                SizedBox(height: size.height * 0.25,),
                                cubit.isLogin? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello dear student",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      "We'd love you to join us",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormFieldWidget(
                                      controller: cubit.studentNumberController,
                                      type: TextInputType.phone,
                                      context: context,
                                      labelText: "Student phone number",
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "Student phone number is required";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    TextFormFieldWidget(
                                      controller: cubit.passwordController,
                                      type: TextInputType.visiblePassword,
                                      context: context,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          cubit.isPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
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
                                    InkWell(
                                      onTap: () {
                                        /*Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GetIdScreen()));*/
                                      },
                                      child: Text(
                                        "Forgot your password?",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                  ],
                                ) : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello dear student",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormFieldWidget(
                                      controller: cubit.quadrupleNameController,
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
                                      height: 5.0,
                                    ),
                                    TextFormFieldWidget(
                                      controller: cubit.parentsPhoneNumberController,
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
                                      height: 5,
                                    ),
                                    TextFormFieldWidget(
                                      controller: cubit.studentPhoneNumberController,
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
                                      height: 5,
                                    ),
                                    TextFormFieldWidget(
                                      controller: cubit.passwordController2,
                                      type: TextInputType.visiblePassword,
                                      context: context,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          cubit.isPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
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
                                      height: 5,
                                    ),
                                    TextFormFieldWidget(
                                      controller: cubit.confirmPasswordController,
                                      type: TextInputType.visiblePassword,
                                      context: context,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          cubit.isConfirmPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
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
                                      height: 5,
                                    ),
                                    Text(
                                      "The email used to reset the password",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w900,
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
                                Container(
                                  width: double.infinity,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if(cubit.isLogin){
                                        if (cubit.formKey.currentState!.validate()) {
                                          cubit.formKey.currentState!.save();
                                          cubit.userLogin();
                                        }
                                      }else{
                                        if (cubit.formKey2.currentState!.validate()) {
                                          cubit.formKey2.currentState!.save();
                                          cubit.userRegister();
                                        }
                                      }
                                    },
                                    color: Colors.indigo,
                                    height: 50.0,
                                    child: Text(
                                      cubit.isLogin? 'Login' : 'Register',
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
                                      color: Colors.black54,
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
                                      cubit.isLogin? 'Register' : 'Login',
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.isLogin? "Login" : "Registration",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
    path.lineTo(0, size.height/2);
    path.cubicTo(size.width * 0.3, size.height,size.width / 2, size.height, size.width, size.height * 0.7);
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
    path.lineTo(0, size.height/2);
    path.cubicTo(size.width * 0.1, size.height, size.width * 0.9, size.height * 0.5, size.width, size.height * 0.7);
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
    path.cubicTo(size.width * 0.1, size.height, size.width * 0.9, size.height * 0.5, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}