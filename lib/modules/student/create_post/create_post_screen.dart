import 'package:englizy_app/modules/student/create_post/cubit/cubit.dart';
import 'package:englizy_app/modules/student/create_post/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostsScreen extends StatelessWidget
{
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
                  onPressed: () {},
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
                          'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Text(
                          'Abdallah Salama',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
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
                  SizedBox(
                    height: 20.0,
                  ),
                  if(cubit.postImage != null)
                    Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0,),
                          image: DecorationImage(
                            image: FileImage(cubit.postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 16.0,
                          ),
                        ),
                        onPressed: ()
                        {
                          cubit.removePostImage();
                        },
                      ),
                    ],
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
