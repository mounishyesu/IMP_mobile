import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:music_player/Views/MusicPlayer/Screens/Home/home.dart';

import '../Views/Tabs/BulletIn.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(
              fontFamily: 'Crimson', color: Colors.black87, fontSize: 15),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFffab00),
        leading: IconButton(onPressed: (){
          Navigator.pop(
              context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body:  Container(
        decoration: new BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Services_BG.png",
                ),
                fit: BoxFit.fill)),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20,bottom: 10),
                    alignment: Alignment.topLeft,
                    child: Text('Hello, how are you...',
                        style: TextStyle(
                          fontFamily: 'Crimson',
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20,bottom: 10),
                          child: Text('pavan',
                              style: TextStyle(
                                fontFamily: 'Crimson',
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, right: 20,bottom: 10),
                          child: Text(Jiffy(DateTime.now()).format('dd-MM-yyyy  HH:mm'),
                              style: TextStyle(
                                fontFamily: 'Crimson',
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                ]),
              ),
            );
          },
        )),
    );
  }
}
