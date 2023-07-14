import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/models/post_model.dart';
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
    return BlocProvider(
      create: (BuildContext context) => PostsCubit(),
      child: BlocConsumer<PostsCubit, PostsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          PostsCubit cubit = PostsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Posts',
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
                          builder: (context) => CreatePostsScreen()),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ],
            ),
            body: StreamBuilder<QuerySnapshot>(
                stream: cubit.getPosts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.docs;
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 5.0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(data[index]["uid"])
                                          .snapshots(),
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
                                              const SizedBox(
                                                width: 15.0,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          dataOfUser[
                                                              "studentName"],
                                                          style: TextStyle(
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
                                                    Text(DateTime.fromMillisecondsSinceEpoch(
                                                            int.parse(data[index]
                                                                        ["time"]
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
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.more_horiz,
                                                  size: 16.0,
                                                ),
                                                onPressed: () {},
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
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15.0,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1.0,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  Text(
                                    data[index]["text"],
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      fontSize: 20
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          Icons.chat,
                                          size: 16.0,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore
                                                .instance
                                                .collection("posts")
                                                .doc(data[index].id)
                                                .collection("comments")
                                                .snapshots(),
                                            builder: (context, snapshot3) {
                                              if (snapshot3.hasData) {
                                                var comments =
                                                    snapshot3.data!.docs;
                                                return Text(
                                                  '${comments.length} comment',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .color,
                                                  ),
                                                );
                                              } else {
                                                return Text(
                                                  '0 comment',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10.0,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1.0,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 18.0,
                                                backgroundImage: NetworkImage(
                                                  userModel!.image
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              Text(
                                                'write a comment ...',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color,
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                    ],
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
          );
        },
      ),
    );
  }

  Widget buildPostItem(context, index) => Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Abdallah Salama',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              size: 16.0,
                            ),
                          ],
                        ),
                        Text('${DateTime.now()}',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16.0,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                'ahdkajshfkjasfhaksfnlaksfnaklsfjlak',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15.0),
                child: Container(
                  height: 140.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.chat,
                                size: 16.0,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '0 comment',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                              'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'write a comment ...',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
