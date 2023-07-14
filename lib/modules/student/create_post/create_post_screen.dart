import 'package:englizy_app/modules/student/create_post/cubit/cubit.dart';
import 'package:englizy_app/modules/student/create_post/cubit/states.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostsScreen extends StatelessWidget {
  const CreatePostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CreatePostsCubit(),
      child: BlocConsumer<CreatePostsCubit, CreatePostsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          CreatePostsCubit cubit = CreatePostsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Create Post',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 20.0,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    cubit.createPost(context: context);
                  },
                  child: Text(
                    "Post",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          userModel!.image
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Text(
                          userModel!.studentName,
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: 15,
                      controller: cubit.textController,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                        hintText: 'what is on your mind ...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
