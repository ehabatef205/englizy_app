import 'package:englizy_app/modules/register/cubit/cubit.dart';
import 'package:englizy_app/modules/register/cubit/states.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              title: Text(
                "Registration",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              elevation: 1,
              actions: [
                TextButton(
                  onPressed: () {},
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
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
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
                        type: TextInputType.phone,
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
                      //Register
                      Container(
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.formKey.currentState!.save();
                            }
                          },
                          color: Colors.indigo,
                          height: 50.0,
                          child: const Text(
                            'Register',
                            style: TextStyle(
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
                            Navigator.pop(context);
                          },
                          color: Colors.indigoAccent,
                          height: 50.0,
                          child: const Text(
                            'Login',
                            style: TextStyle(
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
          );
        },
      ),
    );
  }
}