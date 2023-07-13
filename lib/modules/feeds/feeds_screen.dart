import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/post_model.dart';
import 'package:social/shared/styles/colors.dart';
import 'package:social/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget
{
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return  ConditionalBuilder(
            condition: SocialCubit.get(context).posts.length > 0,
            // condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).posts.length != null,
            // condition: true ,
            builder: (context) => SingleChildScrollView(
             physics: const BouncingScrollPhysics(),
             child: Column(
               children: [
                 const Card(
                   clipBehavior: Clip.antiAliasWithSaveLayer,
                   elevation: 10.0,
                   margin: EdgeInsets.all(8.0),
                   child: Stack(
                     alignment: AlignmentDirectional.bottomEnd,
                     children: [
                       Image(
                         image: NetworkImage('https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg'),
                         fit: BoxFit.cover,
                         height: 150.0,
                         width: double.infinity,
                       ),
                       Padding(
                         padding: EdgeInsets.all(8.0),
                         child: Text(
                           'Communicate with friends',
                           style: TextStyle(
                             fontSize: 14.0,
                             fontWeight: FontWeight.w600,
                             color: Colors.white,
                             height: 1.3,
                           ),
                         ),
                       ),
                     ],

                   ),
                 ),
                 ListView.separated(
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index], context, index),
                   separatorBuilder: (context, index) => const SizedBox(
                     height: 8.0,
                   ),
                   itemCount: SocialCubit.get(context).posts.length,
                 ),
                 const SizedBox(
                   height: 8.0,
                 ),


               ],
             ),
           ),
            fallback: (context) => const Center(child: CircularProgressIndicator(),),

          );
        }

    );
  }

  Widget buildPostItem(PostModel model ,context, index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: const EdgeInsets.all(10.0),
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
                  '${model?.image}',
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
               Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: const TextStyle(
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16.0,
                          ),

                        ],
                      ),
                      Text(
                        '${model?.dateTime}',
                        style: const TextStyle(
                          height: 1.4,
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),

                      ),
                    ],
                  )
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

              )

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
             '${model?.text}',
            style: const TextStyle(
              fontSize: 13.0,
              height: 1.4,
            ),

          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
                top: 5.0,
              ),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 5.0,
                    ),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: (){},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: const Text(
                          '#software',
                          style: TextStyle(
                            color: defaultColor,

                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          if(model.postImage != '')
            Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 15.0,
            ),
            child: Container(
              height: 140.0,
              width: double.infinity,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular
                  (
                    4.0
                ),
                image:  DecorationImage(
                  image: NetworkImage(
                    '${model?.postImage}',
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
                  child:  InkWell(
                    child:  Padding(
                      padding: const  EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child:  Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                            size: 16.0,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',                            // style: TextStyle(
                            //   color: Colors.grey,
                            //   fontSize: 16.0,
                            //
                            // ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child:  InkWell(
                    child: const Padding(
                      padding:  EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '0 comments',
                            // style: TextStyle(
                            //   color: Colors.grey,
                            //   fontSize: 16.0,
                            //
                            // ),
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
                          '${SocialCubit.get(context).userModel?.image}',


                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      const Text(
                        'write a comment ...',
                        style: TextStyle(
                          height: 1.4,
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),

                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                child:  const Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      color: Colors.red,
                      size: 16.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',
                    ),

                  ],
                ),
                onTap: ()
                {
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                },
              ),

            ],
          ),

        ],
      ),
    ),
  );

}