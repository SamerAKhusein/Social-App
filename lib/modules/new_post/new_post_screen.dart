import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/styles/colors.dart';
import 'package:social/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget
{
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  Scaffold(
            appBar:
            defaultAppBar(
                context: context,
                title: 'Create Post',
                actions: [
                  defaultTextButton(
                    function: ()
                    {
                      var timeNow = DateTime.now();

                      if(SocialCubit.get(context).postImage == null)
                        {
                          SocialCubit.get(context).createPost(
                              dateTime: timeNow.toString(),
                              text: textController.text,
                              // postImage: postImage
                          );

                        }else
                          {
                          SocialCubit.get(context).uploadPostImage(
                              dateTime: timeNow.toString(),
                              text: textController.text,
                          );
                          }
                    },
                    text: 'Post',
                  ),
                ]
            ),
            body:  Padding(
              padding: EdgeInsets.all(20.0),
              child:  Column(
                children: [
                  if(state is SocialCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if(state is SocialCreatePostLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          'https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg',

                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Text(
                          'Samer Akram',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'what is on your mind ... ',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit.get(context).postImage != null)
                    Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration:  BoxDecoration(
                            borderRadius:  BorderRadius.circular(4.0),
                            image: DecorationImage(
                              image: FileImage(SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover,
                            )

                        ),
                      ),
                      IconButton(
                        onPressed: ()
                        {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: const CircleAvatar(
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 16.0,
                          ),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: ()
                            {
                              SocialCubit.get(context).getpostImage();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconBroken.Image_2,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'add photo'
                                ),
                              ],
                            ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: (){},
                          child: const Text(
                              '# tags',
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          );
        },

    );
  }
}