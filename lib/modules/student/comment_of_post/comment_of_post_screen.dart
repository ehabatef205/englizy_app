import 'package:cloud_firestore/cloud_firestore.dart';
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
              title: const Text(
                'Comments',
                style: TextStyle(
                  color: Color.fromRGBO(102, 144, 206, 1),
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
              centerTitle: true,
            ),
            body: Container(
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
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
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
                                  shrinkWrap: true,
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
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .color!
                                                                  .withOpacity(
                                                                      0.5)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  dataOfUser[
                                                                      "studentName"],
                                                                  style: TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .scaffoldBackgroundColor,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                PopupMenuButton<int>(
                                                                    color: Theme.of(
                                                                        context)
                                                                        .scaffoldBackgroundColor,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .more_vert_outlined,
                                                                      color: Theme.of(
                                                                          context)
                                                                          .scaffoldBackgroundColor
                                                                    ),
                                                                    onSelected: (value) {
                                                                      if (value == 1) {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                            "posts")
                                                                            .doc(id)
                                                                            .collection("comments")
                                                                            .doc(dataOfComment[index]
                                                                            .id)
                                                                            .update({
                                                                          "view": false
                                                                        });
                                                                      }
                                                                    },
                                                                    itemBuilder:
                                                                        (context) => [
                                                                      PopupMenuItem(
                                                                        value: 1,
                                                                        child:
                                                                        Row(
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.delete_outline,
                                                                            ),
                                                                            const SizedBox(
                                                                              width:
                                                                              10,
                                                                            ),
                                                                            Text(
                                                                              "Delete post",
                                                                              style:
                                                                              TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ]),
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
                                                              dataOfComment[
                                                                      index]
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
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return "Comment is required";
                                      }
                                      return null;
                                    }),
                              ),
                              const SizedBox(
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
                                      color: Theme.of(context).iconTheme.color,
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
