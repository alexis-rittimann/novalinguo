import 'package:flutter/material.dart';
import 'package:novalinguo/common/bottomBar.dart';
import 'package:novalinguo/models/chat_params.dart';

import 'chat.dart';

class ChatScreen extends StatelessWidget {
  final ChatParams chatParams;

  const ChatScreen({Key? key, required this.chatParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     elevation: 0.0, title: Text('Chat with ' + chatParams.peer.name)),
      body: Chat(chatParams: chatParams),

      floatingActionButton: FloatingButton(),
      bottomNavigationBar: BottomNavigation(),
      // Je place ensuite le Bouton au millieu
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Permet de voir les element de la page entre le bouton Acceuil et footerBar
      extendBody: true,
    );
  }
}
