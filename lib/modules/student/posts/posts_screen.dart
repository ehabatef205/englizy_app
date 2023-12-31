import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/student/comment_of_post/comment_of_post_screen.dart';
import 'package:englizy_app/modules/student/create_post/create_post_screen.dart';
import 'package:englizy_app/modules/student/posts/cubit/cubit.dart';
import 'package:englizy_app/modules/student/posts/cubit/states.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => PostsCubit(),
      child: BlocConsumer<PostsCubit, PostsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          PostsCubit cubit = PostsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: const SizedBox(),
              title: const Text(
                'Posts',
                style: TextStyle(
                  color: Color.fromRGBO(102, 144, 206, 1),
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreatePostsScreen()));
                  },
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ],
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
                child: Column(
                  children: [
                    Center(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("levels")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var date = snapshot.data!.docs;
                              return DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  dropdownColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  iconEnabledColor:
                                      Theme.of(context).iconTheme.color,
                                  hint: Text(
                                    levelText!,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  items: date.map((item) {
                                    return DropdownMenuItem(
                                      onTap: () {
                                        cubit.changeLevelId(item.id);
                                      },
                                      value: item["name"],
                                      child: Text(
                                        item["name"],
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  value: cubit.level,
                                  onChanged: (newValue) {
                                    cubit.changeLevel(newValue!.toString());
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: color2,
                                ),
                              );
                            }
                          }),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: cubit.getPosts(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var data = snapshot.data!.docs;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 5.0,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            StreamBuilder<DocumentSnapshot>(
                                                stream: FirebaseFirestore.instance
                                                    .collection("users")
                                                    .doc(data[index]["uid"])
                                                    .snapshots(),
                                                builder: (context, snapshot2) {
                                                  if (snapshot2.hasData) {
                                                    var dataOfUser =
                                                        snapshot2.data!;
                                                    return Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 25.0,
                                                          backgroundImage:
                                                              NetworkImage(
                                                            dataOfUser["image"],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 15.0,
                                                        ),
                                                        Expanded(
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
                                                                    style:
                                                                        TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .color,
                                                                      height: 1.4,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(DateTime.fromMillisecondsSinceEpoch(int.parse(data[index]
                                                                              [
                                                                              "time"]
                                                                          .seconds
                                                                          .toString()) *
                                                                      1000)
                                                                  .toString())
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 15.0,
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
                                                                  .iconTheme
                                                                  .color,
                                                            ),
                                                            onSelected: (value) {
                                                              if (value == 1) {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "posts")
                                                                    .doc(data[
                                                                            index]
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
                                                    );
                                                  } else {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: color2,
                                                      ),
                                                    );
                                                  }
                                                }),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              data[index]["text"],
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            const Divider(),
                                            InkWell(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 5.0,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .messenger_outline_outlined,
                                                        ),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        StreamBuilder<
                                                                QuerySnapshot>(
                                                            stream:
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "posts")
                                                                    .doc(data[
                                                                            index]
                                                                        .id)
                                                                    .collection(
                                                                        "comments")
                                                                    .where("view", isEqualTo: true)
                                                                    .snapshots(),
                                                            builder: (context,
                                                                snapshot3) {
                                                              if (snapshot3
                                                                  .hasData) {
                                                                var comments =
                                                                    snapshot3
                                                                        .data!
                                                                        .docs;
                                                                return Text(
                                                                  '${comments.length} comment',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .color,
                                                                  ),
                                                                );
                                                              } else {
                                                                return Text(
                                                                  '0 comment',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .color,
                                                                  ),
                                                                );
                                                              }
                                                            })
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CommentOfPostScreen(
                                                                id: data[index]
                                                                    .id)));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: color2,
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
