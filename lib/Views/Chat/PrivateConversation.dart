import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/Views/Login/Login.dart';
import 'package:music_player/Views/Profile/Profile.dart';
import 'package:music_player/Views/Tabs/Tabs.dart';
import 'package:music_player/models/chatMessageModel.dart';
import 'package:music_player/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/AppBar.dart';
import 'Chat_Screen.dart';

class PrivateConversation extends StatefulWidget {
  final String chatId;
  final String chatIcon;
  final String personName;
  const PrivateConversation({Key? key, required this.chatId, required this.chatIcon, required this.personName}) : super(key: key);

  @override
  _PrivateConversationState createState() => _PrivateConversationState();
}

class _PrivateConversationState extends State<PrivateConversation> {
  List<ChatMessage> messages = [];
  List privateChat = [];
  TextEditingController sendMessage = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makePrivateChatHistoryapi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Color(0xFFffab00),
        elevation: 2,
        backgroundColor: Colors.black,
        title:  Container(
          child: TitleBar(),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: AppDrawer(),
      body: Container(
        decoration: new BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Services_BG.png",
                ),
                fit: BoxFit.fill)),
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 20),
        height: MediaQuery.of(context).size.height,
        child: Container(
            height: MediaQuery.of(context).size.height * 20,
            color: Colors.black,
            child: ListView(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  color: Color(0xFFfcbd2a),
                  child: Row(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/Badge.png"),
                                fit: BoxFit.contain),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                child: Image.network(widget.chatIcon),
                                radius: 10,
                              ))),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.personName,
                                style: TextStyle(fontFamily: 'Crimson',
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
                          'assets/images/return-icon.jpg',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 500,
                  color: Colors.transparent,
                  child: ListView.builder(
                    itemCount: messages.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messages[index].messageType == "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              color: (messages[index].messageType == "receiver"
                                  ? Colors.grey
                                  : Color(0xFFffab00)),
                            ),
                            padding: EdgeInsets.only(
                                left: 5, top: 5, bottom: 5, right: 30),
                            child: Text(
                              messages[index].messageContent,
                              style:
                                  TextStyle(fontFamily: 'Crimson',fontSize: 15, color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: sendMessage,
                          decoration: InputDecoration(
                              hintText: "Message...",
                              hintStyle: TextStyle(fontFamily: 'Crimson',color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          makeMessageComposed();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
  makePrivateChatHistoryapi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid'),
      "chatRoomId": widget.chatId,
    };
    ApiService.postcall("app-private-chat-history", formMap)
        .then((success) async {
      final body = json.decode(success);
      print("////response////");
      // print(body);
      messages = [];
      setState(() {
        privateChat = body["company_chat_list"] as List;
        for (int i = 0; i < privateChat.length; i++) {
          String type = "";
          if (privateChat[i]["msgview"].toString() == "right") {
            type = "sender";
          } else {
            type = "receiver";
          }
          messages.add(ChatMessage(
              messageContent: privateChat[i]["message"].toString(),
              messageType: type));
        }
      });
      print(privateChat);
      print("++++++++++++++");
    });
  }
  makeMessageComposed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid'),
      "chatRoomId": widget.chatId,
      "message": sendMessage.text.toString(),

    };
    print(formMap);
    ApiService.postcall("app-message-composed", formMap)
        .then((success) async {
      final body = json.decode(success);
      sendMessage.clear();
      makePrivateChatHistoryapi();
      print("++++++++++++++");
    });
  }
}
