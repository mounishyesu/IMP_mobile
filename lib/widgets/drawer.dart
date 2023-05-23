import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Views/Menu/AboutUs.dart';
import 'package:music_player/Views/Menu/Services.dart';
import 'package:music_player/Views/Tabs/BulletIn.dart';
import 'package:music_player/Views/Login/Login.dart';
import 'package:music_player/Views/Tabs/Tabs.dart';

import '../Views/Menu/PrivacyPolicy.dart';
import '../Views/Menu/Settings.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  TextEditingController messageSubject = TextEditingController();
  TextEditingController sentMessage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 500,
      color: Colors.black.withOpacity(0.8),
      child: Column(
        children: [
          SizedBox(height: 50,),
          Container(
            margin: EdgeInsets.only(right: 50),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close,color: Colors.grey,size: 40,),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              width: 300,
              child: Column(
                children: [
                  ListTile(
                    title: Text("Home",style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,),),
                    leading: Icon(Icons.home,color: Colors.grey,),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Tabs()));
                    },
                  ),
                  Divider(color: Colors.orange,),
                  ListTile(
                    title: Text("About Us",style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,),),
                    leading: Icon(Icons.info,color: Colors.grey,),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutUs()));
                    },
                  ),
                  Divider(color: Colors.orange,),
                  ListTile(
                    title: Text("Services",style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,),),
                    leading: Icon(Icons.miscellaneous_services,color: Colors.grey,),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Services()));
                    },
                  ),
                  Divider(color: Colors.orange,),
                  ListTile(
                    title: Text("Privacy Policy",style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,),),
                    leading: Icon(Icons.policy_outlined,color: Colors.grey,),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                    },
                  ),
                  Divider(color: Colors.orange,),
                  ListTile(
                    title: Text("Support",style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,),),
                    leading: Icon(Icons.support_agent_sharp,color: Colors.grey,),
                    onTap: (){
                      _showDialog(context);
                    },
                  ),
                  Divider(color: Colors.orange,),
                  ListTile(
                    title: Text("Settings",style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,),),
                    leading: Icon(Icons.settings,color: Colors.grey,),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings()));
                    },
                  ),
                  Divider(color: Colors.orange,),
                  ListTile(
                    title: Text("Logout",style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,),),
                    leading: Icon(Icons.login_outlined,color: Colors.grey,),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _showDialog(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "To:" + "Support",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'crimson',
                          color: Colors.black38),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close_sharp,
                          color: Colors.black,
                        )),
                  ],
                ),
                content: SingleChildScrollView(
                  child: Container(
                    color: Colors.white24,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ListBody(
                        children: [
                          Container(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black12,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
                                    width: 300,
                                    height: 50,
                                    child: TextField(
                                      maxLines: 2,
                                      controller: messageSubject,
                                      style: TextStyle(
                                          fontFamily: 'crimson',
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        hintText: 'Subject',
                                        contentPadding: EdgeInsets.only(
                                          left: 25,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black12,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
                                    width: 300,
                                    child: TextField(
                                      maxLines: 5,
                                      controller: sentMessage,
                                      style: TextStyle(
                                          fontFamily: 'crimson',
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        hintText: 'Message...',
                                        contentPadding: EdgeInsets.only(
                                          left: 25,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 50),
                                          child: TextButton(
                                            // color: Color(0xFFffab00),
                                            child: Text(
                                              "Send",
                                              style: TextStyle(
                                                  fontFamily: 'crimson',
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            onPressed: () {

                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          child: TextButton(
                                            // color: Colors.white70,
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  fontFamily: 'crimson',
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

}
