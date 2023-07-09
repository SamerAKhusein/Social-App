import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/modules/edit_profile/edit_profile_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget
{
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
          var userModel = SocialCubit.get(context).userModel;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 190.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,

                        child: Container(
                          height: 140.0,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    '${userModel?.coverImage}',
                                ),
                                fit: BoxFit.cover,
                              )

                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 64.0,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor ,
                        child:  CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                              '${userModel?.image}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${userModel?.name}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '${userModel?.bio}',
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '125',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Photo',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '10k',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '90',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Following',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),

                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                           onPressed: () {},
                           child: Text(
                              'Add Photo',
                            ),
                        ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    OutlinedButton(
                      onPressed: ()
                      {
                        navigateTo(context, EditProfileScreen());
                      },

                      child: const Icon(
                        IconBroken.Edit,
                        size: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
    );
  }
}