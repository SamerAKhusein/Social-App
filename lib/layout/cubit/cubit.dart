import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/post_model.dart';
import 'package:social/models/social_user_model.dart';
import 'package:social/modules/chats/chats_screen.dart';
import 'package:social/modules/feeds/feeds_screen.dart';
import 'package:social/modules/new_post/new_post_screen.dart';
import 'package:social/modules/settings/settings_screen.dart';
import 'package:social/modules/users/users_screen.dart';
import 'package:social/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_sound/flutter_sound.dart';


class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  // get User Data

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data() ?? {});
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


  void changeBottomNav(int index) {
    if (index == 1)
      getAllUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
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
        .child('users/${Uri
        .file(profileImage?.path ?? '')
        .pathSegments
        .last}')
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
        print("1**" + error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print("2**" + error.toString());

      emit(SocialUploadProfileImageErrorState());
    });
  }


  /* upload Cover profile image */

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage?.path ?? '')
        .pathSegments
        .last}')
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

  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? userModel?.image,
      coverImage: coverImage ?? userModel?.coverImage,
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

  /* Create Post */

  File? postImage;

  Future<void> getpostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  //  upload Post Image
  void uploadPostImage({
    required String dateTime,
    required String text,

  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postImage?.path ?? '')
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialCreatePostSuccessState());
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  // create Post
  void createPost({
    // required String name,
    // required String uId,
    // required String image,
    required String dateTime,
    required String text,
    String? postImage,

  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel?.name,
      image: userModel?.image,
      uId: userModel?.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }


  // Get Post
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference
            .collection('Likes')
            .get()
            .then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        })
            .catchError((onError) {
          print(onError.toString());
        });
      });
      emit(SocialGetPostsSuccessState());
    })
        .catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel?.uId)
        .set({
      'like': true,
    })
        .then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((onError) {
      emit(SocialLikePostErrorState(onError.toString()));
    });
  }

  // Get All Users

  List<UserModel> users = [];

  void getAllUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            final newUser = UserModel.fromJson(element.data());
            if (!users.contains(newUser)) {
              users.add(newUser);
            }
          }
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  // Send Message

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    bool isVoiceMessage = false,
    String? voiceUrl,
    int? voiceDuration,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel?.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      isVoiceMessage: isVoiceMessage,
      fileUrl: voiceUrl,
      voiceDuration: voiceDuration,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  // Get Message
  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {

        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessagesSuccessState());
    });
  }


  // // Voice Recording

void startRecord()
{
  emit(SocialStartRecordingState());
}

void StopRecord()
{
  emit(SocialStopRecordingState());
}
void sendRecord()
{
  emit(SocialSendRecordingState());
}

  Timer? _timer;
  int _seconds = 1;

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;
      emit(TimerRunningState(_seconds));
    });
  }
  void resetTimer() {
    _timer?.cancel();
    _seconds = 1;
    emit(TimerRunningState(_seconds));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<String?> uploadVoiceRecording(File voiceFile) async {
    try {
      String fileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.aac';
      final ref = firebase_storage.FirebaseStorage.instance.ref().child('voiceMessages/$fileName');

      // Create a task to upload the file and track the progress
      final uploadTask = ref.putFile(voiceFile);

      // Wait for the upload to complete
      await uploadTask;

      // Get the download URL of the uploaded file
      final url = await ref.getDownloadURL();

      return url;
    } catch (e) {
      print('Error uploading voice recording: $e');
      return null;
    }
  }

void sendVoiceMessage({
    required String receiverId,
    required String dateTime,
    required String fileUrl,
  }) {
    MessageModel model = MessageModel(
      senderId: userModel?.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      fileUrl: fileUrl,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }



}
