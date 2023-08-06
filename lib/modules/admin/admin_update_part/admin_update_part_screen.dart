import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin/admin_update_part/cubit/cubit.dart';
import 'package:englizy_app/modules/admin/admin_update_part/cubit/states.dart';
import 'package:englizy_app/modules/admin/admin_add_part/video_screen.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AdminUpdatePartScreen extends StatelessWidget {
  final DocumentSnapshot<Object?> data;
  final String unitId;

  const AdminUpdatePartScreen({required this.data, required this.unitId, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => AdminUpdatePartCubit()..changeData(data: data),
      child: BlocConsumer<AdminUpdatePartCubit, AdminUpdatePartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminUpdatePartCubit cubit = AdminUpdatePartCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Update part", style: TextStyle(
                color: Theme
                    .of(context)
                    .textTheme
                    .bodyText1!
                    .color,
              ),),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: cubit.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormFieldWidget(
                        controller: cubit.namePartController,
                        type: TextInputType.text,
                        context: context,
                        labelText: "Name of part",
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Name of part is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                        controller: cubit.descriptionPartController,
                        type: TextInputType.text,
                        context: context,
                        labelText: "Description",
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Description is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                        controller: cubit.numberOfQuestionsController,
                        type: TextInputType.number,
                        context: context,
                        labelText: "Number of questions",
                        suffixIcon: IconButton(
                            onPressed: () {
                              cubit.chooseNumberOfQuestions();
                            },
                            icon: Icon(Icons.send, color: Theme.of(context).iconTheme.color,)),
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Number of questions";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cubit.questions.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                TextFormFieldWidgetExam(
                                  initialValue: cubit.questions[index]
                                  ["question"],
                                  type: TextInputType.text,
                                  context: context,
                                  labelText: "Questions ${index + 1}",
                                  onChanged: (value) {
                                    cubit.changeQuestion(value!, index);
                                  },
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return "Questions ${index + 1}";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: TextFormFieldWidgetExam(
                                        initialValue: cubit.questions[index]
                                        ["answer1"],
                                        type: TextInputType.text,
                                        context: context,
                                        labelText: "Answer 1",
                                        onChanged: (value) {
                                          cubit.changeAnswer1(value!, index);
                                        },
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "Answer 1";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: TextFormFieldWidgetExam(
                                        initialValue: cubit.questions[index]
                                        ["answer2"],
                                        type: TextInputType.text,
                                        context: context,
                                        labelText: "Answer 2",
                                        onChanged: (value) {
                                          cubit.changeAnswer2(value!, index);
                                        },
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "Answer 2";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: TextFormFieldWidgetExam(
                                        initialValue: cubit.questions[index]
                                        ["answer3"],
                                        type: TextInputType.text,
                                        context: context,
                                        labelText: "Answer 3",
                                        onChanged: (value) {
                                          cubit.changeAnswer3(value!, index);
                                        },
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "Answer 3";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: TextFormFieldWidgetExam(
                                        initialValue: cubit.questions[index]
                                        ["answer4"],
                                        type: TextInputType.text,
                                        context: context,
                                        labelText: "Answer 4",
                                        onChanged: (value) {
                                          cubit.changeAnswer4(value!, index);
                                        },
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "Answer 4";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.5,
                                      child: TextFormFieldWidgetExam(
                                        initialValue: cubit.questions[index]
                                        ["correct"],
                                        type: TextInputType.text,
                                        context: context,
                                        labelText: "Correct Answer",
                                        onChanged: (value) {
                                          cubit.changeCorrect(value!, index);
                                        },
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "Correct Answer";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          cubit.removeItem(index);
                                        },
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color:
                                          Theme.of(context).iconTheme.color,
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            );
                          }),
                      cubit.isLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      ) :
                      Container(
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            cubit.uploadVideos(context, data["name"], unitId, data.id);
                          },
                          color: Colors.indigoAccent,
                          height: 50.0,
                          child: const Text(
                            'Update part',
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
