class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  bool? isVoiceMessage;
  String? fileUrl; // URL to the voice message file
  int? voiceDuration; // Duration of the voice message in seconds
  FileType? fileType;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
    this.isVoiceMessage = false,
    this.fileUrl,
    this.voiceDuration,
    this.fileType,

  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    isVoiceMessage = json['isVoiceMessage'] ?? false;
    fileUrl = json['fileUrl'];
    voiceDuration = json['voiceDuration'];
    fileType = json['fileType'];

  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'isVoiceMessage': isVoiceMessage,
      'fileUrl': fileUrl,
      'voiceDuration': voiceDuration,
      'fileType': fileType,

    };
  }

  bool get isImage => fileType == FileType.Image;
  bool get isVideo => fileType == FileType.Video;
  bool get isPdf => fileType == FileType.Pdf;
  bool get isVoice => fileType == FileType.Voice;

}

enum FileType {
  Image,
  Video,
  Pdf,
  Voice,
}