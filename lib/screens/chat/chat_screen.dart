import 'package:flutter/material.dart';
import 'package:novalinguo/models/chat_params.dart';

import 'chat.dart';

class ChatScreen extends StatelessWidget {
  final ChatParams chatParams;

  const ChatScreen({Key? key, required this.chatParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
          backgroundColor: Colors.purple,
          elevation: 0.0,
          title: Text('Chat with ' + chatParams.peer.name)),
      body: Chat(chatParams: chatParams),
    );
  }
}
