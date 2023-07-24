import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/social_user_model.dart';
import 'package:social/modules/AudioPlayerWidget.dart';
import 'package:social/modules/timer_widget.dart';
import 'package:social/shared/styles/colors.dart';
import 'package:social/shared/styles/icon_broken.dart';


class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;

  ChatDetailsScreen({
    this.userModel,
  });

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(
          receiverId: userModel?.uId ?? '',
        );

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${userModel?.image}',
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                        '${userModel?.name}'
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconBroken.Video,

                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconBroken.Call,

                    ),
                  ),

                ],
              ),
              body: ConditionalBuilder(
                condition: true,
                builder: (context) =>
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              reverse: true,
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,

                                itemBuilder: (context, index) {
                                  var message = SocialCubit
                                      .get(context)
                                      .messages[index];

                                  if (SocialCubit
                                      .get(context)
                                      .userModel
                                      ?.uId == message.senderId) {
                                    return buildMyMessage(message);
                                  }

                                  return buildMessage(message);
                                },
                                separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 15.0,
                                ),
                                itemCount: SocialCubit
                                    .get(context)
                                    .messages
                                    .length,

                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(

                            children: [
                              if(state is! SocialStartRecordingState)
                                IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  IconBroken.Plus,

                                ),
                              ),
                              if(state is! SocialStartRecordingState)
                                Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      15.0,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                    ),
                                    child: TextFormField(

                                      controller: messageController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'type your message here ...',
                                      ),

                                    ),
                                  ),
                                ),
                              ),
                              if(state is! SocialStartRecordingState)
                                const SizedBox(
                                width: 5.0,
                              ),
                              if(state is! SocialStartRecordingState)
                                IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: userModel?.uId ?? '',
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                },
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: defaultColor,
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if(state is! SocialStartRecordingState)
                                IconButton(
                                icon: Icon(
                                  state is SocialStartRecordingState ? Icons.stop : Icons.mic,
                                  size: 30,
                                  color: defaultColor,
                                ),
                                onPressed: () {
                                  if (state is SocialStartRecordingState) {
                                    stopRecordAndSendVoiceMessage(context);
                                  } else {
                                    startRecordVoiceMessage(context);
                                  }
                                },
                              ),
                              if(state is SocialStartRecordingState)
                                Expanded(child: TimerWidget()),
                              if(state is SocialStartRecordingState)
                                IconButton(
                                  icon: Icon(
                                    state is SocialStartRecordingState ? Icons.stop : Icons.mic,
                                    size: 30,
                                    color: defaultColor,
                                  ),
                                  onPressed: () {
                                    if (state is SocialStartRecordingState) {
                                      stopRecordAndSendVoiceMessage(context);
                                    } else {
                                      startRecordVoiceMessage(context);
                                    }
                                  },
                                ),



                            ],
                          ),
                        ],
                      ),
                    ),
                fallback: (context) =>
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) =>
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child:_buildMessageContent(model),
        ),
      );
  Widget buildMyMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        color: defaultColor.withOpacity(.2),
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: _buildMessageContent(model),
    ),
  );

  Widget _buildMessageContent(MessageModel model) {
    if (model.text == null) {
      return AudioPlayerWidget(audioUrl: '${model.fileUrl}');
    }  else {
      return Text('${model.text}');
    }
  }

  String? voiceFilePath;
  FlutterSoundRecorder audioRecorder = FlutterSoundRecorder();
 bool isRecording = false;

  void startRecordVoiceMessage(context) async{

    // Microphone permission

    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone permission not granted");
    }

    // Start Recording
    SocialCubit.get(context).startRecord();
    isRecording = true;
    await audioRecorder.openRecorder();

    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    voiceFilePath = '${appDocDirectory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac';
    await audioRecorder.startRecorder(toFile: voiceFilePath!, codec: Codec.aacADTS);
    print('SocialStopRecordingState  222 : $voiceFilePath');

    // Wait for some time while recording (you can use a timer here)
    await Future.delayed(Duration(seconds: 5));
  }
  void stopRecordAndSendVoiceMessage(context) async {
    // Stop recording voice
    await audioRecorder.stopRecorder();
    SocialCubit.get(context).StopRecord();

    // Upload the voice recording to Firebase Storage
    String? storageUrl = await SocialCubit.get(context).uploadVoiceRecording(File(voiceFilePath!));

    // Check if the upload was successful
    if (storageUrl != null) {
      // Call the sendVoiceMessage method with the Firebase Storage URL
      SocialCubit.get(context).sendVoiceMessage(
        receiverId: userModel?.uId ?? '',
        dateTime: DateTime.now().toString(),
        fileUrl: storageUrl, // Use the Firebase Storage URL here
      );
      SocialCubit.get(context).sendRecord();
    } else {
      print('Failed to upload voice recording.');
    }

    isRecording = false;
  }

}