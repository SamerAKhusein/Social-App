import 'package:social/models/message_model.dart';

abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

// Get user
class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates
{
  final String error;

  SocialGetUserErrorState(this.error);
}

// get all users
class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates
{
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

// Change Bottom Nav
class SocialChangeBottomNavState extends SocialStates {}

// New Post
class SocialNewPostState extends SocialStates {}

// Profile Image Picked

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

// Upload Profile Image


class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

// CoverImagePicked

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

// Upload Cover Image

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

// User Update

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}


// create post

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

// Post Image Picked

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

// Get Post

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates
{
  final String error;

  SocialGetPostsErrorState(this.error);
}

// like post

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates
{
  final String error;

  SocialLikePostErrorState(this.error);
}


// Send Message

class SocialSendMessageSuccessState extends SocialStates {}
class SocialSendMessageErrorState extends SocialStates
{
  final String error;

  SocialSendMessageErrorState(this.error);
}

// Get Message

class SocialGetMessagesSuccessState extends SocialStates {}

// Start Record

class SocialStartRecordingState extends SocialStates {}

// Stop Record

class SocialStopRecordingState extends SocialStates {}

// start Send Recording

class SocialSendRecordingState extends SocialStates {}

// start Timer

class TimerRunningState extends SocialStates {
  final int seconds;
  TimerRunningState(this.seconds);
}