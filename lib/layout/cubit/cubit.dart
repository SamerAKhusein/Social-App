import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/social_user_model.dart';
import 'package:social/modules/chats/chats_screen.dart';
import 'package:social/modules/feeds/feeds_screen.dart';
import 'package:social/modules/new_post/new_post_screen.dart';
import 'package:social/modules/settings/settings_screen.dart';
import 'package:social/modules/users/users_screen.dart';
import 'package:social/shared/components/constants.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value)
    {

      userModel = SocialUserModel.fromJson(value.data() ?? {});
      emit(SocialGetUserSuccessState());
    })
        .catchError((error) {

      emit(SocialGetUserErrorState(error.toString()));

    });
  }

  /* Nav Bottom Bar */

  int currentIndex = 0;

  List<Widget> screens =
  [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];


  List<String> titles =
  [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index)
  {
    if(index == 2)
      emit(SocialNewPostState());
    else
    {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }


  /* get Profile Image */

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  /* get Cover Profile Image */

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  /* upload profile image */


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
}) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage?.path ?? '').pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());

        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      })
          .catchError((error) {
        print("1**"+error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print("2**"+error.toString());

      emit(SocialUploadProfileImageErrorState());
    });
  }

  // void uploadProfileImage({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //
  //   if (profileImage != null) { // Check if profileImage is not null
  //     firebase_storage.FirebaseStorage.instance
  //         .ref()
  //         .child('users/${Uri.file(profileImage?.path ?? '').pathSegments.last}') // Use null-aware operator and provide a fallback value for the path
  //         .putFile(profileImage!) // Use the non-null assertion operator (!) to pass a non-null value
  //         .then((value) {
  //       value.ref.getDownloadURL().then((value) {
  //         emit(SocialUploadProfileImageSuccessState());
  //
  //         updateUser(
  //           name: name,
  //           phone: phone,
  //           bio: bio,
  //           image: value,
  //         );
  //       }).catchError((error) {
  //         emit(SocialUploadProfileImageErrorState());
  //       });
  //     })
  //         .catchError((error) {
  //       emit(SocialUploadProfileImageErrorState());
  //     });
  //   } else {
  //     emit(SocialUploadProfileImageErrorState());
  //   }
  // }


  /* upload Cover profile image */

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
}) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          coverImage: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  /*  update User */


  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? coverImage,
    String? image,

  })
  {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: image??userModel?.image,
      coverImage: coverImage??userModel?.coverImage,
      email: userModel?.email,
      uId: userModel?.uId,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

}

