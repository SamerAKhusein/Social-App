

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/styles/icon_broken.dart';



class EditProfileScreen extends StatelessWidget
{
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();




  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;


        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                defaultTextButton(
                    function: ()
                    {
                      SocialCubit.get(context).updateUser(
                          name: nameController.text,
                          phone:  phoneController.text,
                          bio: bioController.text);
                    },
                    text: 'Update'
                ),
                SizedBox(
                  width: 15.0,
                ),
              ]
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:  const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                      const LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                    const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration:  BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage('${userModel?.coverImage}') as ImageProvider<Object>
                                          : FileImage(coverImage),
                                      fit: BoxFit.cover,
                                    )

                                ),
                              ),
                              IconButton(
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).getCoverImage();

                                  },
                                  icon: const CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16.0,
                                    ),
                                  ),
                              ),

                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 64.0,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor ,
                          child:  Stack(
                            alignment: AlignmentDirectional.bottomEnd,

                            children: [
                              CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel?.image}') as ImageProvider<Object>
                                    : FileImage(profileImage),
                              ),
                              IconButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                    Row(
                    children:
                    [
                      if(SocialCubit.get(context).profileImage != null)
                        Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                function: ()
                                {
                                  SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: nameController.text,
                                      bio: nameController.text);

                                },
                                text: 'upload profile '
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              const SizedBox(
                              height: 5.0,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              const LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if(SocialCubit.get(context).coverImage != null)
                        Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                function: ()
                                {
                                  SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: nameController.text,
                                      bio: nameController.text
                                  );
                                },
                                text: 'upload cover '
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              const SizedBox(
                              height: 5.0,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              const LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value)
                    {
                      if(value == null)
                        {
                          return 'name must not be empty';
                        }
                      return null;
                    },
                      label: 'Name',
                      prefix: IconBroken.User,

                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String? value)
                    {
                      if(value == null)
                      {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,

                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value)
                    {
                      if(value == null)
                      {
                        return 'phone number must not be empty';
                      }
                      return null;
                    },
                    label: 'phone',
                    prefix: IconBroken.Call,

                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}