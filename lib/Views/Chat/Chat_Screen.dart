import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/Views/Chat/GroupConversation.dart';
import 'package:music_player/Views/Profile/Profile.dart';
import 'package:music_player/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/AppBar.dart';
import 'PrivateConversation.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List groupChat = [];
  List privateChat = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGroupchatConversations();
    getPrivatechatConversations();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title:  Container(
              child: TitleBar(),
            ),
            bottom: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              unselectedLabelStyle: TextStyle(fontFamily: 'Crimson',color: Colors.white),
              indicator: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                color: Color(0xFFffab00),),
              tabs: [
                Tab(
                  child: Container(
                    child: Text(
                      "Company",
                      style: TextStyle(fontFamily: 'Crimson',
                          // color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                Tab(
                  child:Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Text(
                      "Private",
                      style: TextStyle(fontFamily: 'Crimson',
                          // color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
              indicatorColor: Colors.white,
            ),
          ),
          drawerEnableOpenDragGesture: false,
          drawer: AppDrawer(),
          body: Container(
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    height: MediaQuery.of(context).size.height,
                    decoration: new BoxDecoration(
                        color: Colors.black87,
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/Services_BG.png",
                            ),
                            fit: BoxFit.fill)),
                    child:
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: groupChat.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              border: Border.all(
                                  color: Colors.grey
                              )
                          ),
                          child: ListTile(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => GroupConversation(
                                          chatId: groupChat[index]["chatid"].toString(),
                                        groupName:groupChat[index]["name"].toString(),
                                        groupIcon: groupChat[index]["companyLogo"].toString(),
                                      )),
                                    );
                                  },
                                  leading:Container(
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
                                            child: Image.network(groupChat[index]["companyLogo"].toString()),
                                            radius: 10,)
                                      )),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        groupChat[index]["name"].toString(),
                                        style: TextStyle(fontFamily: 'Crimson',fontSize: 20,color: Colors.white),
                                      ),
                                      Text(
                                        groupChat[index]["subject"].toString(),
                                        style: TextStyle(fontFamily: 'Crimson',
                                            fontSize: 10,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )),
                        );
                      },
                    )
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    height: MediaQuery.of(context).size.height,
                    decoration: new BoxDecoration(
                        color: Colors.black87,
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/Services_BG.png",
                            ),
                            fit: BoxFit.fill)),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: privateChat.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              border: Border.all(
                                  color: Colors.grey
                              )
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => PrivateConversation(
                                        chatId: privateChat[index]["chatid"].toString(),
                                        personName:privateChat[index]["name"].toString(),
                                        chatIcon: privateChat[index]["profileImage"].toString(),
                                      )),
                                    );
                                  },
                                  leading:Container(
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
                                            child: Image.network(privateChat[index]["profileImage"].toString()),
                                            radius: 10,)
                                      )),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        privateChat[index]["name"].toString(),
                                        style: TextStyle(fontFamily: 'Crimson',fontSize: 20,color: Colors.white),
                                      ),
                                      Text(
                                        privateChat[index]["subject"].toString(),
                                        style: TextStyle(fontFamily: 'Crimson',
                                            fontSize: 10,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  getGroupchatConversations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic>    formMap = {
      "userId": prefs.getString('userid'),
      "companyId": prefs.getString('companyid'),
    };
    ApiService.postcall("app-company-chat-list",formMap)
        .then((success) async {
      final body = json.decode(success);
      print("////response////");
      // print(body);
      setState(() {
        groupChat = body["company_chat_list"] as List;
      });
print(groupChat);
    });
  }

  getPrivatechatConversations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic>    formMap = {
      "userId": prefs.getString('userid'),
    };
    ApiService.postcall("app-private-chat-list",formMap)
        .then((success) async {
      final body = json.decode(success);
      print("////response////");
       print(body);
setState(() {
  privateChat = body["company_chat_list"] as List;
});
    });
  }

}
