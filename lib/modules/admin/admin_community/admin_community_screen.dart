import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/modules/admin/admin_comment_of_post/admin_comment_of_post_screen.dart';
import 'package:englizy_app/modules/admin/admin_community/cubit/cubit.dart';
import 'package:englizy_app/modules/admin/admin_community/cubit/states.dart';
import 'package:englizy_app/modules/admin/admin_create_post/create_post_screen.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCommunityScreen extends StatelessWidget {
  const AdminCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => AdminCommunityCubit(),
      child: BlocConsumer<AdminCommunityCubit, AdminCommunityStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminCommunityCubit cubit = AdminCommunityCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: const SizedBox(),
              title: Text(
                'Question',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminCreatePostsScreen()),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ],
            ),
            body: Column(
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
                              hint: const Text(
                                "Choose level",
                                style: TextStyle(color: Colors.grey),
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
                                            .color),
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
                  child: cubit.levelId == null
                      ? const SizedBox()
                      : StreamBuilder<QuerySnapshot>(
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
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Icon(
                                                                    data[index][
                                                                            "view"]
                                                                        ? Icons
                                                                            .visibility_outlined
                                                                        : Icons
                                                                            .visibility_off_outlined,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .iconTheme
                                                                        .color,
                                                                  )
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
                                                            onSelected:
                                                                (value) async {
                                                              if (value == 1) {
                                                                showDialog<String>(
                                                                  context: context,
                                                                  builder:
                                                                      (BuildContext context) =>
                                                                      AlertDialog(
                                                                        content: const Text(
                                                                            'Do you want to delete this?'),
                                                                        actions: <Widget>[
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(
                                                                                    context),
                                                                            child: const Text('No'),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed: () async{
                                                                              await FirebaseFirestore
                                                                                  .instance
                                                                                  .collection(
                                                                                  "posts")
                                                                                  .doc(data[
                                                                              index]
                                                                                  .id)
                                                                                  .collection(
                                                                                  "comments")
                                                                                  .get()
                                                                                  .then(
                                                                                      (value) async {
                                                                                    for (int i = 0;
                                                                                    i <
                                                                                        value
                                                                                            .docs
                                                                                            .length;
                                                                                    i++) {
                                                                                      await FirebaseFirestore
                                                                                          .instance
                                                                                          .collection(
                                                                                          "posts")
                                                                                          .doc(data[
                                                                                      index]
                                                                                          .id)
                                                                                          .collection(
                                                                                          "comments")
                                                                                          .doc(value
                                                                                          .docs[
                                                                                      i]
                                                                                          .id)
                                                                                          .delete();
                                                                                    }
                                                                                  }).whenComplete(
                                                                                      () async {
                                                                                    await FirebaseFirestore
                                                                                        .instance
                                                                                        .collection(
                                                                                        "posts")
                                                                                        .doc(data[
                                                                                    index]
                                                                                        .id)
                                                                                        .delete();
                                                                                  }).whenComplete(() {
                                                                                    Navigator.pop(context);
                                                                              });
                                                                            },
                                                                            child: const Text('Yes'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                );
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
                                                            AdminCommentOfPostScreen(
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
          );
        },
      ),
    );
  }
}
