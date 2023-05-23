import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/Views/Profile/Profile.dart';
import 'package:music_player/Views/Tabs/BulletInEngage.dart';
import 'package:music_player/Views/companyPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BulletIn extends StatefulWidget {
  const BulletIn({Key? key}) : super(key: key);

  @override
  _BulletInState createState() => _BulletInState();
}

class _BulletInState extends State<BulletIn> {
  late YoutubePlayerController _controller;
  List bulletinList = [];
  bool content = false;
  bool music = false;
  bool iframe = false;
  bool image = false;
  bool delete = false;
  String loginUserId = " ";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeBulletinApiCall();
    _controller = YoutubePlayerController(
        initialVideoId: " ",
        flags: YoutubePlayerFlags(
            autoPlay: false, loop: true, useHybridComposition: false));
  }

  onGoBack(dynamic value) {
    makeBulletinApiCall();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Services_BG.png",
                ),
                fit: BoxFit.fill),
          ),
          child: ListView.builder(
            itemCount: bulletinList.length,
            itemBuilder: (BuildContext context, int index) {
              print(bulletinList[index]["userId"]);
              print("UserID");
              if(bulletinList[index]["userId"].toString() == loginUserId){
                delete = true;
              }else{
                delete = false;
              }
              if (bulletinList[index]["btype"].toString() == "Bulletin") {
                content = true;
                music = false;
                iframe = false;
                image = false;
              } else if (bulletinList[index]["btype"].toString() == "Music") {
                content = false;
                music = true;
                iframe = false;
                image = false;
              } else if (bulletinList[index]["btype"].toString() == "Image") {
                content = true;
                music = false;
                iframe = false;
                image = true;
              } else {
                content = false;
                music = false;
                iframe = true;
                image = false;

                _controller = YoutubePlayerController(
                    initialVideoId: bulletinList[index]["postImage"].toString(),
                    flags: YoutubePlayerFlags(
                        autoPlay: false,
                        loop: true,
                        useHybridComposition: false));
              }

              return Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Card(
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width : 310,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              var companyId = " ";
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Profile(
                                                          selectedCompanyId:
                                                              bulletinList[index]
                                                                      ["companyId"]
                                                                  .toString(),
                                                          userId: bulletinList[index]
                                                                  ["userId"]
                                                              .toString(),
                                                        )),
                                              );
                                            },
                                            child: Image.network(
                                              bulletinList[index]["profileImage"]
                                                  .toString(),
                                              height: 35,
                                              width: 35,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  bulletinList[index]["fname"]
                                                          .toString() +
                                                      " " +
                                                      bulletinList[index]["lname"]
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontFamily: 'Crimson',
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  bulletinList[index]["designation"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Crimson',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  bulletinList[index]["postAt"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Crimson',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CompanyPage()),
                                          );
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/Badge.png"),
                                                fit: BoxFit.contain),
                                          ),
                                          alignment: Alignment.center,
                                          child:
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    const Radius.circular(180.0)),
                                                // shape: BoxShape.circle,
                                              ),
                                              alignment: Alignment.center,
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundImage: NetworkImage(bulletinList[index]["companyLogo"]
                                                    .toString(),),
                                                backgroundColor: Colors.transparent,
                                              ))
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                          visible: content,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Card(
                              color: Colors.transparent,
                              child: AutoSizeText(
                                bulletinList[index]["content"].toString(),
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20,
                                  fontFamily: 'Crimson',
                                ),
                                maxLines: null,
                              ),
                            ),
                          )),
                      Visibility(
                          visible: music,
                          child: Card(
                            color: Colors.white,
                            child: Image.network(
                              bulletinList[index]["postImage"].toString(),
                              fit: BoxFit.fill,
                            ),
                          )),
                      Visibility(
                          visible: image,
                          child: Card(
                            color: Colors.white,
                            child: Image.network(
                              bulletinList[index]["postImage"].toString(),
                              fit: BoxFit.fill,
                            ),
                          )),
                      Visibility(
                          visible: iframe,
                          child: SizedBox(
                            width: 700,
                            height: 220,
                            child: Card(
                              color: Colors.transparent,
                              child: YoutubePlayer(
                                controller: _controller,
                                showVideoProgressIndicator: true,
                              ),
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 335,
                              child: Row(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          child: TextButton(
                                            // color: Color(0xFFffab00),
                                            child: Text(
                                              "Engage",
                                              style: TextStyle(
                                                fontFamily: 'Crimson',
                                              ),
                                            ),
                                            // shape: RoundedRectangleBorder(
                                            //   borderRadius:
                                            //       BorderRadius.circular(7),
                                            // ),
                                            onPressed: () {
                                              print(bulletinList[index]["bid"]
                                                  .toString());
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BulletInEngage(
                                                          postDetailsid:
                                                              bulletinList[
                                                                          index]
                                                                      ["bid"]
                                                                  .toString(),
                                                        )),
                                              ).then(onGoBack);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(
                                            bulletinList[index]["engage"]
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: 'Crimson',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          child: TextButton(
                                            // color: Color(0xFFffab00),
                                            child: Text(
                                              "Applaud",
                                              style: TextStyle(
                                                fontFamily: 'Crimson',
                                              ),
                                            ),
                                            // /shape: RoundedRectangleBorder(
                                            //   borderRadius:
                                            //       BorderRadius.circular(7),
                                            // ),
                                            onPressed: () {
                                              applaud(
                                                  index,
                                                  bulletinList[index]["bid"]
                                                      .toString());
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(
                                            bulletinList[index]["applaud"]
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: 'Crimson',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /*SizedBox(
                              child: Visibility(
                                visible: music,
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap:(){},
                                          child: Icon(
                                            Icons.playlist_add,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(
                                            "123",
                                            style: TextStyle(
                                              fontFamily: 'Crimson',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap:(){},
                                            child: Icon(
                                              Icons.play_arrow_outlined,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "12",
                                              style: TextStyle(
                                                fontFamily: 'Crimson',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),

                                  ],
                                ),
                              ),
                            ),*/
                            Visibility(
                              visible: delete,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      deletePost(bulletinList[index]["bid"].toString());
                                    },
                                    child: Align(
                                      alignment: Alignment(1, -1),
                                      child: Icon(
                                        Icons.delete_forever_outlined,
                                        color: Color(0xFFffab00),
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: const Text(
                                      "",
                                      style: TextStyle(
                                        fontFamily: 'Crimson',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  makeBulletinApiCall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserId = prefs.getString('userid');
    ApiService.getcall("app-bulletins-list").then((success) async {
      final body = json.decode(success);
      print("response====================================");
      setState(() {
        bulletinList = body["bulletins_list"] as List;
      });
      print(bulletinList.length);
      print(bulletinList);
      print("/////////");
    });
  }

  applaud(int index, String bulletinId) async {
    Map<String, dynamic> formMap = {
      "userId": loginUserId,
      "bulletinId": bulletinId,
    };
    ApiService.postcall("app-add-bulletin-applaud", formMap)
        .then((success) async {
      setState(() {
        final body1 = json.decode(success);
        print("response====================================");

        print("Mounishhhhhhhhhhhh");
        if (body1["status"].toString() == "success") {
          setState(() {
            bulletinList[index]["applaud"] = body1["applaud_count"];
          });
        } else {}
      });
    });
  }

  deletePost(String bulletinId) async {
    Map<String, dynamic> formMap = {
      "bulletinId": bulletinId,
    };
    ApiService.postcall("app-bulletin-delete", formMap)
        .then((success) async {
        makeBulletinApiCall();
    });
  }
}
