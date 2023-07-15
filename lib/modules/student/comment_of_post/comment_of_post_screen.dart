import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/models/post_model.dart';
import 'package:englizy_app/modules/student/create_post/create_post_screen.dart';
import 'package:englizy_app/modules/student/comment_of_post/cubit/cubit.dart';
import 'package:englizy_app/modules/student/comment_of_post/cubit/states.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentOfPostScreen extends StatelessWidget {
  final String id;

  const CommentOfPostScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => CommentOfPostCubit(),
      child: BlocConsumer<CommentOfPostCubit, CommentOfPostStates>(
        listener: (context, state) {},
        builder: (context, state) {
          CommentOfPostCubit cubit = CommentOfPostCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Comments',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
                displayFullTextOnTap: true,
              ),
              /*Text(
                'Comments',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),*/
              centerTitle: true,
            ),
            body: Container(
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
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: cubit.getComments(id: id),
                          builder: (context, snapshot4) {
                            if (snapshot4.hasData) {
                              var dataOfComment = snapshot4.data!.docs;
                              return ListView.builder(
                                  itemCount: dataOfComment.length,
                                  itemBuilder: (context, index) {
                                    return StreamBuilder<DocumentSnapshot>(
                                        stream: cubit.getDataOfUser(
                                            uid: dataOfComment[index]["uid"]),
                                        builder: (context, snapshot2) {
                                          if (snapshot2.hasData) {
                                            var dataOfUser = snapshot2.data!;
                                            return Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 25.0,
                                                  backgroundImage: NetworkImage(
                                                    dataOfUser["image"],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(10),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10),
                                                          color: Theme.of(context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .color!
                                                              .withOpacity(0.5)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  dataOfUser[
                                                                      "studentName"],
                                                                  style: TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .scaffoldBackgroundColor,
                                                                      fontSize: 16),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            /*Text(DateTime.fromMillisecondsSinceEpoch(
                                                                    int.parse(dataOfComment[index]
                                                                                [
                                                                                "time"]
                                                                            .seconds
                                                                            .toString()) *
                                                                        1000)
                                                                .toString())*/

                                                            Text(
                                                              dataOfComment[index]
                                                                  ["text"],
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .scaffoldBackgroundColor,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: color2,
                                              ),
                                            );
                                          }
                                        });
                                  });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: color2,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Form(
                          key: cubit.formKey,
                          child: Row(
                            children: [
                              Flexible(
                                child: TextFormFieldWidget(
                                  controller: cubit.commentController,
                                  type: TextInputType.text,
                                  context: context,
                                  hint: "Write comment...",
                                  validate: (value){
                                    if(value!.isEmpty){
                                      return "Comment is required";
                                    }
                                    return null;
                                  }
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: color2,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                        cubit.sendComment(id: id);
                                    },
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
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
