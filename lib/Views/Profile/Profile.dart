import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/helpers/Utilities.dart';
import 'package:music_player/widgets/AppBar.dart';
import 'package:music_player/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  final String selectedCompanyId;
  final String userId;
  const Profile({
    Key? key,
    required this.selectedCompanyId,
    required this.userId,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List designation_one = [];
  List designation_two = [];
  List artist_genre = [];
  List discographyList = [];
  List playList = [];
  String? desig1Value;
  String? desig2Value;
  String? artistValue;
  String? baseUrl = " ";
  String? proImage;
  bool isGuest = false;
  String? desig1Id;
  String? desig2Id;
  String? artistId;
  String? userDesignation1;
  String? userDesignation2;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController webSite = TextEditingController();
  TextEditingController faceBook = TextEditingController();
  TextEditingController instaGram = TextEditingController();
  TextEditingController linkedIn = TextEditingController();
  TextEditingController discription = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRoledata(widget.selectedCompanyId);
    makedesignationsone();
    makeUserProfilaAPicall(widget.userId);
    makedesignationstwo();
    makeArtistgenre();
    makeDiscographyListApi();
    makePlayListApi();
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
      drawerEnableOpenDragGesture: false,
      drawer: AppDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
        decoration: new BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Services_BG.png",
                ),
                fit: BoxFit.fill)),
        child: ListView(
          shrinkWrap: true,
          children: [
            ////////Profile image,profile edit////////
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 120),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/Badge.png"),
                          fit: BoxFit.contain),
                    ),
                    child: Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(const Radius.circular(180.0)),
                          // shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            proImage.toString(),
                          ),
                          backgroundColor: Colors.transparent,
                        ))),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Visibility(
                      visible: isGuest,
                      child: IconButton(
                          onPressed: () {
                            _showDialog(context);
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                            color: Color(0xFFffab00),
                          )),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: firstName.text == ""
                  ? Container()
                  : AutoSizeText(
                firstName.text.toString() + lastName.text.toString(),
                style: TextStyle(
                    fontFamily: 'Crimson',
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
                maxLines: null,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: userDesignation1 == "null" && userDesignation2 == "null"
                  ? Container()
                  : AutoSizeText("{"+userDesignation1.toString()+"}"+","+"{"+userDesignation2.toString()+"}",
                style: TextStyle(
                    fontFamily: 'Crimson',
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
                maxLines: null,
              ),
            ),
            /////////Description////////
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: discription.text == ""
                  ? Container()
                  : AutoSizeText(
                discription.text.toString(),
                style: TextStyle(
                    fontFamily: 'Crimson',
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
                maxLines: null,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ///////Social sites///////
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _launch_Linkedin_URLApp();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundImage:
                          AssetImage("assets/images/linkedIn_logo.jpg"),
                      radius: 28,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _launch_Facebook_URLApp();
                    },
                    child: CircleAvatar(
                      foregroundImage: AssetImage("assets/images/fb_logo.jpg"),
                      radius: 22,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _launch_Instagram_URLApp();
                    },
                    child: CircleAvatar(
                      foregroundImage:
                          AssetImage("assets/images/instagram_logo.jpg"),
                      radius: 22,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ///////Discography////////
            Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                "My Discography",
                style: TextStyle(
                    fontFamily: 'Crimson', fontSize: 15, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                  ),
                  itemCount: discographyList.isEmpty ? 0 : discographyList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return  Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(discographyList[index]['album_picture'].toString(),height: 130,width: 130,fit: BoxFit.fill,),
                          Container(
                            child: Text(discographyList[index]['subtitle'].toString(),
                              style: TextStyle(
                                fontFamily: 'Crimson',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Container(
                          //       child: Icon(
                          //         Icons.playlist_add,
                          //         color: Colors.white,
                          //         size: 20,
                          //       ),
                          //     ),
                          //     Container(
                          //       margin: EdgeInsets.only(left: 5),
                          //       child: Text(
                          //         "123",
                          //         style: TextStyle(
                          //           fontFamily: 'Crimson',
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 60,
                          //     ),
                          //     Container(
                          //       child: Icon(
                          //         Icons.play_arrow,
                          //         color: Colors.white,
                          //         size: 20,
                          //       ),
                          //     ),
                          //     Container(
                          //       margin: EdgeInsets.only(left: 5),
                          //       child: Text(
                          //         "123",
                          //         style: TextStyle(
                          //           fontFamily: 'Crimson',
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    );
                  }),
            ),
            ///////playlist////////
            Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                "My Playlist",
                style: TextStyle(
                    fontFamily: 'Crimson', fontSize: 15, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                  ),
                  itemCount: playList.isEmpty ? 0 : playList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return  Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(playList[index]['album_picture'].toString(),height: 130,width: 130,fit: BoxFit.fill,),
                          Container(
                            child: Text(playList[index]['subtitle'].toString(),
                              style: TextStyle(
                                fontFamily: 'Crimson',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Container(
                          //       child: Icon(
                          //         Icons.playlist_add,
                          //         color: Colors.white,
                          //         size: 20,
                          //       ),
                          //     ),
                          //     Container(
                          //       margin: EdgeInsets.only(left: 5),
                          //       child: Text(
                          //         "123",
                          //         style: TextStyle(
                          //           fontFamily: 'Crimson',
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 60,
                          //     ),
                          //     Container(
                          //       child: Icon(
                          //         Icons.play_arrow,
                          //         color: Colors.white,
                          //         size: 20,
                          //       ),
                          //     ),
                          //     Container(
                          //       margin: EdgeInsets.only(left: 5),
                          //       child: Text(
                          //         "123",
                          //         style: TextStyle(
                          //           fontFamily: 'Crimson',
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(height: 10,),
          ],
        ),
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
                  children: [
                    Text(
                      "Insights that we want to hear of your\nstory - journey|Struggles|Inspiration|\nAmbition|Success Mantra",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'crimson',
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: 16,
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
                                  controller: firstName,
                                  style: TextStyle(
                                      fontFamily: 'crimson',
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'First Name',
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
                                height: 50,
                                child: TextField(
                                  controller: lastName,
                                  style: TextStyle(
                                      fontFamily: 'crimson',
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Last Name',
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
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 15,
                                ),
                                width: 300,
                                height: 50,
                                child: DropdownButton(
                                  hint: Text("--Designation One--"),
                                  isExpanded: true,
                                  underline: DropdownButtonHideUnderline(
                                    child: Container(),
                                  ),
                                  dropdownColor: Colors.white,
                                  iconSize: 20,
                                  iconDisabledColor: Colors.white,
                                  iconEnabledColor: Colors.white,
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      color: Colors.black),
                                  items: designation_one.map((item) {
                                    return new DropdownMenuItem(
                                      child: Text(item['name'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Crimson',
                                            color: Colors.black,
                                          )),
                                      value: item['name'],
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (value) {
                                    setState(() {
                                      desig1Value = value.toString();
                                      print(desig1Value);
                                      print(".........");
                                      for (int i = 0;
                                          i < designation_one.length;
                                          i++) {
                                        if (value ==
                                            designation_one[i]['name']) {
                                          desig1Id = designation_one[i]['id']
                                              .toString();
                                        }
                                      }
                                      print(desig1Id);
                                      print("////id////");
                                    });
                                  },
                                  value: desig1Value,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 15,
                                ),
                                width: 300,
                                height: 50,
                                child: DropdownButton(
                                  hint: Text("--Designation Two--"),
                                  isExpanded: true,
                                  underline: DropdownButtonHideUnderline(
                                    child: Container(),
                                  ),
                                  dropdownColor: Colors.white,
                                  iconSize: 20,
                                  iconDisabledColor: Colors.white,
                                  iconEnabledColor: Colors.white,
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      color: Colors.black),
                                  items: designation_two.map((item) {
                                    return new DropdownMenuItem(
                                      child: Text(item['name'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Crimson',
                                            color: Colors.black,
                                          )),
                                      value: item['name'],
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (value) {
                                    setState(() {
                                      desig2Value = value.toString();
                                      print(desig2Value);
                                      print(".........");
                                      for (int i = 0;
                                          i < designation_two.length;
                                          i++) {
                                        if (value ==
                                            designation_two[i]['name']) {
                                          desig2Id = designation_two[i]['id']
                                              .toString();
                                        }
                                      }
                                      print(desig2Id);
                                      print("////id////");
                                    });
                                  },
                                  value: desig2Value,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 15,
                                ),
                                width: 300,
                                height: 50,
                                child: DropdownButton(
                                  hint: Text("--Artist Genre--"),
                                  isExpanded: true,
                                  underline: DropdownButtonHideUnderline(
                                    child: Container(),
                                  ),
                                  dropdownColor: Colors.white,
                                  iconSize: 20,
                                  iconDisabledColor: Colors.white,
                                  iconEnabledColor: Colors.white,
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      color: Colors.black),
                                  items: artist_genre.map((item) {
                                    return new DropdownMenuItem(
                                      child: Text(item['name'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Crimson',
                                            color: Colors.black,
                                          )),
                                      value: item['name'],
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (value) {
                                    setState(() {
                                      artistValue = value.toString();
                                      print(artistValue);
                                      print(".........");
                                      for (int i = 0;
                                          i < artist_genre.length;
                                          i++) {
                                        if (value == artist_genre[i]['name']) {
                                          artistId =
                                              artist_genre[i]['id'].toString();
                                        }
                                      }
                                      print(artistId);
                                      print("////id////");
                                    });
                                  },
                                  value: artistValue,
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
                                height: 50,
                                child: TextField(
                                  controller: webSite,
                                  style: TextStyle(
                                      fontFamily: 'crimson',
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: '@example.com',
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
                                height: 50,
                                child: TextField(
                                  controller: faceBook,
                                  style: TextStyle(
                                      fontFamily: 'crimson',
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Facebook.com',
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
                                height: 50,
                                child: TextField(
                                  controller: instaGram,
                                  style: TextStyle(
                                      fontFamily: 'crimson',
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Instagram.com',
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
                                height: 50,
                                child: TextField(
                                  controller: linkedIn,
                                  style: TextStyle(
                                      fontFamily: 'crimson',
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Linkedin.com',
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
                                  child: discription.text.toString() == ""
                                      ? TextField(
                                          controller: discription,
                                          maxLines: 5,
                                          style: TextStyle(
                                              fontFamily: 'crimson',
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            hintText: 'Description',
                                            contentPadding: EdgeInsets.only(
                                              left: 25,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        )
                                      : TextField(
                                          controller: discription,
                                          maxLines: 5,
                                          style: TextStyle(
                                              fontFamily: 'crimson',
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            hintText: 'Description',
                                            contentPadding: EdgeInsets.only(
                                              left: 25,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 50),
                                      child: TextButton(
                                        // color: Color(0xFFffab00),
                                        child: Text(
                                          "Update",
                                          style: TextStyle(
                                              fontFamily: 'crimson',
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        onPressed: () {
                                            makeUpdateUserProfilaAPicall();
                                            Navigator.pop(context);
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

  makeUserProfilaAPicall(selectedid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "user_id": selectedid,
    };
    print(formMap.toString());
    ApiService.postcall("app-user-profile", formMap).then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body["data"]["First_Name"]);
      setState(() {
        firstName.text = body["data"]["First_Name"].toString();
        lastName.text = body["data"]["Last_Name"].toString();
        webSite.text = body["data"]["Email"].toString();
        faceBook.text = body["data"]["User_Facebook"].toString();
        instaGram.text = body["data"]["User_Instagram"].toString();
        linkedIn.text = body["data"]["Linkedin_URL"].toString();
        discription.text = body["data"]["User_Description"].toString();
        userDesignation1 = body["data"]["Designation1_content"].toString();
        userDesignation2 = body["data"]["Designation2_content"].toString();
        // baseUrl = body["user_profile_path"].toString();
        proImage = body["data"]["Profile_Image"].toString();
        // proImage = prefs.getString("profileimage");
      });
    });
  }

  makeUpdateUserProfilaAPicall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "user_id": prefs.getString('userid'),
      "first_name": firstName.text.toString(),
      "last_name": lastName.text.toString(),
      "company_name": prefs.getString('companyname'),
      "user_description": discription.text.toString(),
      "user_facebook": faceBook.text.toString(),
      "user_instagram": instaGram.text.toString(),
      "linkedin_url": linkedIn.text.toString(),
      "designation1": desig1Id,
      "designation2": desig2Id,
      "artist_genre": artistId,
    };
    print(formMap);
    ApiService.postcall("app-user-profile-update", formMap)
        .then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body["data"]["First_Name"]);
      Utilities.showAlert(context, body["message"].toString());
      setState(() {
        firstName.text = body["data"]["First_Name"].toString();
        lastName.text = body["data"]["Last_Name"].toString();
        webSite.text = body["data"]["Email"].toString();
        faceBook.text = body["data"]["User_Facebook"].toString();
        instaGram.text = body["data"]["User_Instagram"].toString();
        linkedIn.text = body["data"]["Linkedin_URL"].toString();
        discription.text = body["data"]["User_Description"].toString();
      });
    });
  }

  makedesignationsone() async {
    ApiService.getcall("app-designationsone").then((success) async {
      final body = json.decode(success);
      setState(() {
        designation_one = body["designation_one"] as List;
      });
      print("response====================================");
      print(body["designation_one"][0]["name"]);
      print(designation_one);
      // print(designation_one_Name);
    });
  }

  makedesignationstwo() async {
    ApiService.getcall("app-designationstwo").then((success) async {
      final body = json.decode(success);
      setState(() {
        designation_two = body["designation_two"] as List;
      });
      print("response====================================");
      print(body["designation_two"][0]["name"]);
    });
  }

  makeArtistgenre() async {
    ApiService.getcall("app-artist-genre").then((success) async {
      final body = json.decode(success);
      setState(() {
        artist_genre = body["artist_genre"] as List;
      });
      print("response====================================");
      print(body["artist_genre"][0]["name"]);
    });
  }

  getRoledata(selectedid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString('companyid') == selectedid) {
        isGuest = true;
        print("IF+Mounish");
      } else {
        isGuest = false;
        print("ELSE+Mounish");
      }
    });
  }

  _launch_Facebook_URLApp() async {
    const url = 'https://www.facebook.com/';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launch_Instagram_URLApp() async {
    const url = 'https://www.instagram.com/';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launch_Linkedin_URLApp() async {
    const url = 'https://www.linkedin.com/';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  makeDiscographyListApi() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid'),
    };
    print(formMap);
    ApiService.postcall("app-user-discography", formMap)
        .then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body);
      setState(() {
        discographyList = body["discography_list"] as List;
      });
      print("discography_list");
    });
  }

  makePlayListApi() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid'),
    };
    print(formMap);
    ApiService.postcall("app-user-playlist", formMap)
        .then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body);
      setState(() {
        playList = body["discography_list"] as List;
        print(playList[0]["album_picture"]);
      });
      print("playlist");
    });
  }

}
