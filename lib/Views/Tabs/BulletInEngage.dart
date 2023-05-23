import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/Views/Profile/Profile.dart';
import 'package:music_player/helpers/Utilities.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../widgets/AppBar.dart';
import '../../widgets/drawer.dart';

class BulletInEngage extends StatefulWidget {
  final String postDetailsid;

  BulletInEngage({
    Key? key,
    required this.postDetailsid,
  }) : super(key: key);
  @override
  _BulletInEngageState createState() => _BulletInEngageState();
}

class _BulletInEngageState extends State<BulletInEngage> {
  late YoutubePlayerController _controller;
  List bulletinList = [];
  List engageList = [];
  bool content = false;
  bool music = false;
  bool iframe = false;
  bool image = false;
  var comment = TextEditingController();
  var _engage;
  dynamic body = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeapicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shadowColor: Color(0xFFffab00),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Container(
            child: TitleBar(),
          )),
      drawer: AppDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Services_BG.png",
                ),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 500,
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 30, right: 30),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile(selectedCompanyId: body["bulletins_list"]["companyId"].toString(),userId: body["bulletins_list"]["userId"].toString())),
                                              );
                                            },
                                            child: Image.network(
                                              body["bulletins_list"]
                                                      ["profileImage"]
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
                                                  body["bulletins_list"]
                                                              ["fname"]
                                                          .toString() +
                                                      " " +
                                                      body["bulletins_list"]
                                                              ["lname"]
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontFamily: 'Crimson',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  body["bulletins_list"]
                                                          ["designation"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Crimson',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  body["bulletins_list"]
                                                          ["postAt"]
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
                                  ],
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                                visible: content,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Card(
                                      color: Colors.transparent,
                                      child: AutoSizeText(
                                        body["bulletins_list"]["content"]
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 20,
                                          fontFamily: 'Crimson',
                                        ),
                                        maxLines: null,
                                      ),
                                    ),
                                  ),
                                )),
                            Visibility(
                                visible: music,
                                child: Card(
                                  color: Colors.white,
                                  child: Image.network(
                                    body["bulletins_list"]["postImage"]
                                        .toString(),
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            Visibility(
                                visible: image,
                                child: Card(
                                  color: Colors.white,
                                  child: Image.network(
                                    body["bulletins_list"]["postImage"]
                                        .toString(),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                width: 500,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Card(
                    color: Colors.transparent,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: comment,
                      onChanged: ((String value) {
                        setState(() {
                          _engage = value;
                        });
                      }),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFffab00),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFffab00),
                            width: 1.0,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Create Engage',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                          fontFamily: 'Crimson',
                        ),
                        suffixIcon: Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: Color(0xFFffab00), width: 1)),
                            ),
                            child: IconButton(
                              hoverColor: Colors.grey,
                              tooltip: "send",
                              onPressed: () {
                                if (comment.text.length > 0) {
                                  createComment();
                                } else {
                                  Utilities.showAlert(
                                      context, "Please enter comments");
                                }
                              },
                              icon: Icon(
                                Icons.send,
                                color: Color(0xFFffab00),
                                size: MediaQuery.of(context).size.width * 0.05,
                              ),
                            )),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 500,
                height: 320,
                child: ListView.builder(
                    itemCount: engageList.length,
                    // display each item of the product list
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: SizedBox(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Profile(selectedCompanyId: body["bulletins_list"]["companyId"].toString(),userId: body["bulletins_list"]["userId"].toString(),)),
                                          );
                                        },
                                        child: Image.network(
                                          engageList[index]["profileImage"]
                                              .toString(),
                                          height: 35,
                                          width: 35,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            engageList[index]["fname"]
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: 'Crimson',
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            engageList[index]["designation"]
                                                    .toString() +
                                                " | | " +
                                                engageList[index]["userGenre"]
                                                    .toString(),
                                            style: TextStyle(
                                              fontFamily: 'Crimson',
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left:45),
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(
                                    engageList[index]["comment"].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  makeapicall() async {
    Map<String, dynamic> formMap = {
      "bulletinId": widget.postDetailsid,
    };
    ApiService.postcall("app-get-bulletin-data", formMap).then((success) async {
      setState(() {
        body = json.decode(success);
        print("response====================================");
        print(body);
        getComment();
        print("Mounishhhhhhhhhhhh");
        if (body["bulletins_list"]["btype"].toString() == "Bulletin") {
          content = true;
          music = false;
          iframe = false;
          image = false;
          loadVideo("");
        } else if (body["bulletins_list"]["btype"].toString() == "Music") {
          content = false;
          music = true;
          iframe = false;
          image = false;
          loadVideo("");
        } else if (body["bulletins_list"]["btype"].toString() == "Image") {
          content = false;
          image = true;
          music = false;
          iframe = false;
          loadVideo("");
        } else {
          content = false;
          music = false;
          iframe = true;
          image = false;
          loadVideo(body["bulletins_list"]["postImage"].toString());
        }
      });
    });
  }

  loadVideo(String videoCode) {
    _controller = YoutubePlayerController(
        initialVideoId: videoCode,
        flags: YoutubePlayerFlags(
            autoPlay: false, loop: true, useHybridComposition: false));
  }

  getComment() async {
    Map<String, dynamic> formMap = {
      "bulletinId": widget.postDetailsid,
    };
    ApiService.postcall("app-get-engage-list", formMap).then((success) async {
      setState(() {
        final body1 = json.decode(success);
        print("response====================================");
        print(body1['comments_list']);
        print("Mounishhhhhhhhhhhh");
        setState(() {
          engageList = body1['comments_list'] as List;
        });
      });
    });
  }

  createComment() async {
    Map<String, dynamic> formMap = {
      "userId": "2",
      "bulletinId": widget.postDetailsid,
      "comment": comment.text.toString(),
    };
    ApiService.postcall("app-add-bulletin-engage", formMap)
        .then((success) async {
      setState(() {
        final body1 = json.decode(success);
        print("response====================================");
        print(body1['comments_list']);
        print("Mounishhhhhhhhhhhh");
        if (body1["status"].toString() == "success") {
          getComment();
          comment.clear();
        } else {
          Utilities.showAlert(context, body1["message"].toString());
        }
      });
    });
  }
}

class CreateEngage extends StatelessWidget {
  const CreateEngage({
    required this.pluginImage,
  }) : super();
  final String pluginImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(),
    );
  }
}
