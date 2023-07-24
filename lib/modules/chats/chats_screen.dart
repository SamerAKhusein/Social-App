import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/social_user_model.dart';
import 'package:social/modules/chat_Detalis/chat_detalis_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/styles/colors.dart';

class ChatsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return  ConditionalBuilder(
            condition: SocialCubit.get(context).users.length > 0,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index)  => buildChatItem(SocialCubit.get(context).users[index],context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: SocialCubit.get(context).users.length,

            ),
            fallback: (context) => const Center(child: CircularProgressIndicator(),),


          );
        },

    );
  }

  Widget buildChatItem(UserModel model, context)
  {
    return  InkWell(
      onTap: ()
      {
        navigateTo(context, ChatDetailsScreen(userModel: model,));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                '${model.image}'
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
                      ],
                    ),

                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}