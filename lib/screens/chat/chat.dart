import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:novalinguo/common/loading.dart';
import 'package:novalinguo/models/chat_params.dart';
import 'package:novalinguo/models/message.dart';
import 'package:novalinguo/services/message_database.dart';
import 'message_item.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key, required this.chatParams}) : super(key: key);
  final ChatParams chatParams;

  @override
  _ChatState createState() => _ChatState(chatParams);
}

class _ChatState extends State<Chat> {
  final MessageDatabaseService messageService = MessageDatabaseService();

  final ChatParams chatParams;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  _ChatState(this.chatParams);

  int _nbElement = 20;
  static const int PAGINATION_INCREMENT = 20;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _nbElement += PAGINATION_INCREMENT;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(50, 60, 0, 10),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/bulle.png",
                      ),
                      Expanded(
                        child: Text(
                          '  40',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          children: [
                            Container(
                                width: 60,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(131, 133, 238, 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft: Radius.circular(4),
                                  ),
                                )),
                            Container(
                              width: 70,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(children: [
                          Text(
                            'XP 1308',
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 170.0),
          padding: const EdgeInsets.only(top: 20.0),
          width: MediaQuery.of(context).size.width,
          height: 770,
          decoration: BoxDecoration(
            color: Color.fromRGBO(131, 133, 238, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              buildListMessage(),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
              ),
              buildInput(),
              Padding(
                padding: EdgeInsets.all(65.0),
              ),
            ],
          ),
        ),
        isLoading ? Loading() : Container()
      ],
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder<List<Message>>(
        stream:
            messageService.getMessage(chatParams.getChatGroupId(), _nbElement),
        builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
          if (snapshot.hasData) {
            List<Message> listMessage = snapshot.data ?? List.from([]);
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => MessageItem(
                  message: listMessage[index],
                  userId: chatParams.userUid,
                  isLastMessage: isLastMessage(index, listMessage)),
              itemCount: listMessage.length,
              reverse: true,
              controller: listScrollController,
            );
          } else {
            return Center(child: Loading());
          }
        },
      ),
    );
  }

  bool isLastMessage(int index, List<Message> listMessage) {
    if (index == 0) return true;
    if (listMessage[index].idFrom != listMessage[index - 1].idFrom) return true;
    return false;
  }

  Widget buildInput() {
    return Container(
      width: 330.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11.0),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
          ),
          Flexible(
            child: TextField(
              onSubmitted: (value) {
                onSendMessage(textEditingController.text, 0);
              },
              style: TextStyle(fontSize: 15.0),
              controller: textEditingController,
              decoration: InputDecoration.collapsed(
                hintText: 'Your message...',
              ),
            ),
          ),
          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: Colors.yellow,
              ),
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(100.0),
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadFile(pickedFile);
    }
  }

  Future uploadFile(PickedFile file) async {
    String fileName =
        DateTime.now().millisecondsSinceEpoch.toString() + ".jpeg";
    try {
      Reference reference = FirebaseStorage.instance.ref().child(fileName);
      final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': file.path});
      TaskSnapshot snapshot;
      if (kIsWeb) {
        snapshot = await reference.putData(await file.readAsBytes(), metadata);
      } else {
        snapshot = await reference.putFile(File(file.path), metadata);
      }

      String imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 1);
      });
    } on Exception {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "Error! Try again!");
    }
  }

  void onSendMessage(String content, int type) {
    if (content.trim() != '') {
      messageService.onSendMessage(
          chatParams.getChatGroupId(),
          Message(
              idFrom: chatParams.userUid,
              idTo: chatParams.peer.uid,
              timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
              content: content,
              type: type));
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      textEditingController.clear();
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send',
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }
}
