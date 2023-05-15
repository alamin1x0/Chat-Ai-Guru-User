import 'package:probot/models/chat_model.dart';

class ChatListDateWise {
  int? dateTime;
  List<ChatMessage>? chat;

  ChatListDateWise({this.dateTime, this.chat});

  ChatListDateWise.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    if (json['chat'] != null) {
      chat = <ChatMessage>[];
      json['chat'].forEach((v) {
        chat!.add(ChatMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateTime'] = dateTime;
    if (chat != null) {
      data['chat'] = chat!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ChatMessage {
  String? text;
  ChatMessageType? chatMessageType;
  int? time;

  ChatMessage({this.chatMessageType, this.text, this.time});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    chatMessageType = json['chatMessageType'];
    text = json['text'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatMessageType'] = chatMessageType;
    data["text"] = text;
    data['time'] = time;

    return data;
  }
}
