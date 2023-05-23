import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/Views/Chat/Chat_Screen.dart';
import 'package:music_player/helpers/Utilities.dart';
import 'package:music_player/widgets/AppBar.dart';
import 'package:music_player/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfile extends StatefulWidget {
  final String userId;
  const UserProfile({Key? key,required this.userId,}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List designation_one = [];
  List designation_two = [];
  List playList = [];
  List discographyList = [];
  List artist_genre = [];
  String? desig1Value;
  String? desig2Value;
  String? artistValue;
  String? baseUrl = " ";
  String? proImage;
  bool isGuest = false;
  String? desig1Id;
  String? desig2Id;
  String? artistId;
  TextEditingController firstName = TextEditingController();
  TextEditingController messageSubject = TextEditingController();
  TextEditingController sentMessage = TextEditingController();
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
          )
      ),
      drawerEnableOpenDragGesture: false,
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
        decoration: new BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Services_BG.png",
                ),
                fit: BoxFit.fill)),
        child: ListView(
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              const Radius.circular(180.0)),
                          // shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(proImage.toString(),
                          ),
                          backgroundColor: Colors.transparent,
                        ))),
                SizedBox(width: 20,),
                Column(
                  children: [
                    IconButton(onPressed: (){
                      _showDialog(context);
                    }, icon: Icon(Icons.chat_bubble_outline,color: Color(0xFFffab00))),
                  ],
                ),
              ],
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
                    onTap: (){
                      _launch_Linkedin_URLApp();
                    },
                    child:  CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundImage: AssetImage(
                          "assets/images/linkedIn_logo.jpg"),
                      radius: 28,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      _launch_Facebook_URLApp();
                    },
                    child: CircleAvatar(
                      foregroundImage: AssetImage(
                          "assets/images/fb_logo.jpg"),
                      radius: 22,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      _launch_Instagram_URLApp();
                    },
                    child: CircleAvatar(
                      foregroundImage: AssetImage(
                          "assets/images/instagram_logo.jpg"),
                      radius: 22,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            /////////Description////////
            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "Lorem lpsum is simply dummy text of the printing and typesetting industry.\n Lorem lpsum has been the industry's standard  dummy text ever since the 1500s,\n when an unknown printer took a gallery of type and scrambled it to make a type specimen book.\nIt has survived not onlu five centuries, but also the\n remaining essentially unchanged.\n It was popularised in the 1960s with the release of\n Letraset sheets containing Lorem lpsum passages,\nand more recentely with desktop publishing software\n like Aldus PageMaker including versions of Lorem lpsum.",
                style: TextStyle(fontFamily: 'Crimson',
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
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
                style: TextStyle(fontFamily: 'Crimson',fontSize: 15, color: Colors.white),
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
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title:  Row(
                children: [
                  SizedBox(width: 20,),
                  Text( "To:" + firstName.text.toString(),style: TextStyle(fontSize: 20,fontFamily: 'crimson',color: Colors.black),),
                  SizedBox(width: 115,),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  },
                      icon: Icon(Icons.close_sharp,color: Colors.black,)),
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
                                    style: TextStyle(fontFamily:'crimson',color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: 'Enter Subject',
                                      contentPadding: EdgeInsets.only(
                                        left: 25,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height:10,),
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
                                    style: TextStyle(fontFamily:'crimson',color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: 'Start Typing...',
                                      contentPadding: EdgeInsets.only(
                                        left: 25,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height:10,),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 50),
                                        child: TextButton(
                                          // color: Color(0xFFffab00),
                                          child: Text("Send",style:TextStyle(
                                              fontFamily: 'crimson', color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 16),),
                                          onPressed: (){
                                            makeMessageSendApi();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        child: TextButton(
                                          // color: Colors.white70,
                                          child: Text("Cancel",style:TextStyle(
                                              fontFamily: 'crimson', color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 16),),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),);
          },);
        });
  }

  makeUserProfilaAPicall(selectedid) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic>    formMap = {
      "user_id": selectedid,
    } ;
    print(formMap.toString());
    ApiService.postcall("app-user-profile",formMap)
        .then((success) async {
      final body =
      json.decode(success);
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
        // baseUrl = body["user_profile_path"].toString();
        proImage = body["data"]["Profile_Image"].toString();
        // proImage = prefs.getString("profileimage");
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

  makeMessageSendApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid'),
      "toUserId": widget.userId,
      "subject": messageSubject.text.toString(),
      "message": sentMessage.text.toString(),

    };
    print(formMap);
    ApiService.postcall("app-private-message", formMap)
        .then((success) async {
      final body = json.decode(success);
      sentMessage.clear();
      messageSubject.clear();
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen()),
      );
    });
  }

  makeDiscographyListApi() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": widget.userId,
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
      "userId": widget.userId,
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
