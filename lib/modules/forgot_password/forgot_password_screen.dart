import 'package:englizy_app/shared/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: Color.fromRGBO(102, 144, 206, 1),
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/englizy.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          color: Theme.of(context)
              .scaffoldBackgroundColor
              .withOpacity(0.7),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormFieldWidget(
                        controller: emailController,
                        type: TextInputType.text,
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
                        height: 20,
                      ),
                      isLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : Container(
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              formKey.currentState!.save();
                              FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) {
                                Fluttertoast.showToast(
                                  msg: "Check your email",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black38,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }).catchError((error) {
                                Fluttertoast.showToast(
                                  msg: error.message,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                print(error.message);
                              });
                            }
                          },
                          color: Colors.indigoAccent,
                          height: 50.0,
                          child: const Text(
                            'Send Email',
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
          ),
        ),
      ),
    );
  }
}
