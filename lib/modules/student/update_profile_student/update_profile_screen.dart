// ignore_for_file: deprecated_member_use

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:englizy_app/modules/student/settings_student/settings_student_screen.dart';
import 'package:englizy_app/modules/student/update_profile_student/cubit/cubit.dart';
import 'package:englizy_app/modules/student/update_profile_student/cubit/states.dart';
import 'package:englizy_app/shared/color.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileStudentScreen extends StatelessWidget {
  const UpdateProfileStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => UpdateProfileStudentCubit(),
      child:
          BlocConsumer<UpdateProfileStudentCubit, UpdateProfileStudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          UpdateProfileStudentCubit cubit =
              UpdateProfileStudentCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Update Profile',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
                displayFullTextOnTap: true,
              ),
              /*Text(
                "Update Profile",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),*/
              centerTitle: true,
            ),
            body: SafeArea(
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/englizy.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Form(
                          key: cubit.formKey,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  cubit.chooseImage();
                                },
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage('assets/back2.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1.0,
                              ),
                              const SizedBox(
                                height: 5,
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
                                height: 8.0,
                              ),
                              TextFormFieldWidget(
                                controller: cubit.nameController,
                                type: TextInputType.name,
                                context: context,
                                labelText: "Name",
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Name is required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              TextFormFieldWidget(
                                controller: cubit.phoneController,
                                type: TextInputType.text,
                                context: context,
                                labelText: "Phone",
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Phone is required";
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
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!
                                            .withOpacity(0.7),
                                        width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!
                                            .withOpacity(0.7),
                                        width: 2),
                                  ),
                                  filled: true,
                                ),
                                hint: Text(
                                  cubit.dropdownValue,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  cubit.changeItem(newValue);
                                },
                                style: TextStyle(
                                  color:
                                      Theme.of(context).textTheme.bodyText1!.color,
                                ),
                                items: cubit.academicYearList
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              DropdownButtonFormField(
                                style: TextStyle(
                                  color:
                                      Theme.of(context).textTheme.bodyText1!.color,
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!
                                            .withOpacity(0.7),
                                        width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!
                                            .withOpacity(0.7),
                                        width: 2),
                                  ),
                                  filled: true,
                                ),
                                hint: Text(
                                  cubit.dropdownValue2,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  cubit.changeItem2(newValue);
                                },
                                items: cubit.centerList
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              cubit.isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: colorButton,
                                      ),
                                    )
                                  : Container(
                                      width: size.width * 0.7,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          if (cubit.formKey.currentState!
                                              .validate()) {
                                            cubit.formKey.currentState!.save();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SettingsStudentScreen()),
                                            );
                                          }
                                        },
                                        color: Colors.indigo,
                                        height: 50.0,
                                        child: const Text(
                                          'Update',
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
            ),
          );
        },
      ),
    );
  }
}
