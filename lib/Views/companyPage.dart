import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/CompanyLocation.dart';
import 'package:music_player/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helpers/Utilities.dart';
import '../widgets/AppBar.dart';
import 'Gallery/Albums.dart';
import 'Gallery/Pictures.dart';
import 'Gallery/Videos.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _CompanyPageState extends State<CompanyPage> {
  List designation_one = [];
  List infoUpdate = [];
  String? countryValue;
  String? industryLocaton;
  String? companyNumber;
  String? companyMail;
  String? industryName;
  String? stateValue;
  String? cityValue;
  String? countryId;
  String? stateId;
  String? cityId;
  List countryList = [];
  List cityList = [];
  List stateList = [];
  String? desig1Value;
  String? desig1Id;
  dynamic companyList = [];
  List companyTeamsList = [];
  List companyServicesList = [];
  String? companyImage;
  String? ownuserId;
  String? owncompanyId;
  String? companyName = " ";
  String? companyDescription = "";
  bool isGuest = false;
  String services1Display = "";
  String services2Display = "";
  String services3Display = "";
  String services4Display = "";
  String services5Display = "";
  String services6Display = "";
  String? coverImage;
  TextEditingController web2visual = TextEditingController();
  TextEditingController companyDescriptionEdit = TextEditingController();
  TextEditingController service1 = TextEditingController();
  TextEditingController service2 = TextEditingController();
  TextEditingController service3 = TextEditingController();
  TextEditingController service4 = TextEditingController();
  TextEditingController service5 = TextEditingController();
  TextEditingController service6 = TextEditingController();
  TextEditingController infoEmail = TextEditingController();
  TextEditingController infoMobnum = TextEditingController();
  TextEditingController infoPageurl = TextEditingController();
  TextEditingController infoAlbumurl = TextEditingController();
  TextEditingController faceBook = TextEditingController();
  TextEditingController instaGram = TextEditingController();
  TextEditingController linkedIn = TextEditingController();
  late AppState state;
  File? imageFile;
  String? filePath;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      makeApiupload();
      print("upload");
      makeCoverApiupload();
    });
    makeCompanyProfilaAPicall();
    makeCompanyTeamsAPicall();
    getRoledata();
    state = AppState.free;
  }

  onGoBack(dynamic value) {
    makeApiupload();
    makeCompanyProfilaAPicall();
    makeCompanyTeamsAPicall();
    getRoledata();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Color(0xFFffab00),
        backgroundColor: Colors.black,
        title: Container(
          child: TitleBar(),
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Services_BG.png",
                ),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(children: [
                Container(
                    height: 300,
                    padding: EdgeInsets.only(left: 20, bottom: 30),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(coverImage!), fit: BoxFit.fill),
                    ),
                    child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                      AssetImage("assets/images/Badge.png"),
                                      fit: BoxFit.contain),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            const Radius.circular(180.0)),
                                        // shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        radius: 35.0,
                                        backgroundImage: NetworkImage(companyImage.toString(),),
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          margin: EdgeInsets.only(top:50,left: 50),
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Color(0xFFffab00),
                                          ),
                                        ),
                                      )),
                                )),
                            SizedBox(
                              width: 200,
                            ),
                            Visibility(
                              visible: isGuest,
                              child: IconButton(
                                tooltip: 'Upload cover photo',
                                icon: Icon(
                                  Icons.cloud_upload,
                                  color: Color(0xFFffab00),
                                  size: 50,
                                ),
                                onPressed: () {
                                  _CoverpickImage();
                                },
                              ),
                            )
                          ],
                        ))),
              ]),
              Container(
                padding: EdgeInsets.all(10),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  collapsedIconColor: Color(0xFFffab00),
                  iconColor: Color(0xFFffab00),
                  title: Text(
                    companyName.toString(),
                    style: TextStyle(
                        color: Color(0xFFffab00),
                        fontFamily: 'crimson',
                        fontSize: 20),
                  ),
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        style: TextStyle(
                            color: Color(0xFFffab00),
                            fontFamily: 'crimson',
                            fontSize: 16),
                        maxLines: null,
                        enabled: false,
                        controller: web2visual,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          label: Container(
                            child: Html(
                              data: companyDescription,
                              style: {
                                "body": Style(
                                  color: Colors.white70,
                                  fontFamily: 'crimson',
                                  fontSize: FontSize(16),
                                ),
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Visibility(
                        visible: isGuest,
                        child: IconButton(
                            onPressed: () {
                              _web2Visual(context);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Color(0xFFffab00),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Color(0xFFffab00),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  collapsedIconColor: Color(0xFFffab00),
                  iconColor: Color(0xFFffab00),
                  title: Text(
                    companyName.toString(),
                    style: TextStyle(
                        color: Color(0xFFffab00),
                        fontFamily: 'crimson',
                        fontSize: 20),
                  ),
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                            color: Colors.transparent,
                            child: GridView.count(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 30,
                                children: List.generate(companyTeamsList.length,
                                        (index) {
                                      return Column(
                                        children: [
                                          Center(
                                            child: SelectCard(
                                              pluginImage: companyTeamsList[index]
                                              ["profileImage"]
                                                  .toString(),
                                              pluginName: companyTeamsList[index]
                                              ["fname"]
                                                  .toString(),
                                              designation: companyTeamsList[index]
                                              ["designation"]
                                                  .toString(),
                                            ),
                                          ),
                                        ],
                                      );
                                    })))),
                    ///////////////////////////////////////////////////////
                  ],
                ),
              ),
              Divider(
                color: Color(0xFFffab00),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  // trailing: Icon(
                  //   Icons.keyboard_double_arrow_down_outlined,
                  // ),
                  collapsedIconColor: Color(0xFFffab00),
                  iconColor: Color(0xFFffab00),
                  title: Text(
                    "Services",
                    style: TextStyle(
                        color: Color(0xFFffab00),
                        fontFamily: 'crimson',
                        fontSize: 20),
                  ),
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(left: 20),
                      height: 520,
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            child: Card(
                              color: Colors.black87,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    services1Display,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'crimson',
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 70,
                            child: Card(
                              color: Colors.black87,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    services2Display,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'crimson',
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 70,
                            child: Card(
                              color: Colors.black87,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    services3Display,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'crimson',
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 70,
                            child: Card(
                              color: Colors.black87,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    services4Display,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'crimson',
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 70,
                            child: Card(
                              color: Colors.black87,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    services5Display,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'crimson',
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 70,
                            child: Card(
                              color: Colors.black87,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    services6Display,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'crimson',
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Visibility(
                        visible: isGuest,
                        child: IconButton(
                            onPressed: () {
                              _services(context);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Color(0xFFffab00),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Color(0xFFffab00),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  // trailing: Icon(
                  //   Icons.keyboard_double_arrow_down_outlined,
                  // ),
                  collapsedIconColor: Color(0xFFffab00),
                  iconColor: Color(0xFFffab00),
                  title: Text(
                    "Company Info.",
                    style: TextStyle(
                        color: Color(0xFFffab00),
                        fontFamily: 'crimson',
                        fontSize: 20),
                  ),
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(left: 20),
                      height: 360,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 180,
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        Card(
                                          color: Colors.black87,
                                          child: Icon(
                                            Icons.fact_check_sharp,
                                            color: Colors.orange,
                                            size: 100,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AutoSizeText(
                                      industryName.toString(),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.black87,
                                            child: Icon(
                                              Icons.phone,
                                              color: Colors.orange,
                                              size: 100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AutoSizeText(
                                      companyNumber.toString(),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 180,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.black87,
                                            child: Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.orange,
                                              size: 100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AutoSizeText(
                                      industryLocaton.toString(),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.black87,
                                            child: Icon(
                                              Icons.mail_outline,
                                              color: Colors.orange,
                                              size: 100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    AutoSizeText(
                                      companyMail.toString(),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
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
                                      foregroundImage: AssetImage(
                                          "assets/images/linkedIn_logo.jpg"),
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
                                      foregroundImage: AssetImage(
                                          "assets/images/fb_logo.jpg"),
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
                                      foregroundImage: AssetImage(
                                          "assets/images/instagram_logo.jpg"),
                                      radius: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              companyName.toString(),
                              style: TextStyle(
                                  color: Color(0xFFffab00),
                                  fontFamily: 'crimson',
                                  fontSize: 20),
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Visibility(
                                visible: isGuest,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => CompanyLocation(City:companyList["cityName"].toString() ,State: companyList["stateName"].toString(),Country:companyList["countryName"].toString(),email: companyMail.toString(),mobNumber: companyNumber.toString(),))).then(onGoBack);
                                      print("POPUP");
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Color(0xFFffab00),
                                    )),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Divider(
                color: Color(0xFFffab00),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  // trailing: Icon(
                  //   Icons.keyboard_double_arrow_down_outlined,
                  // ),
                  collapsedIconColor: Color(0xFFffab00),
                  iconColor: Color(0xFFffab00),
                  title: Text(
                    "Gallery",
                    style: TextStyle(
                        color: Color(0xFFffab00),
                        fontFamily: 'crimson',
                        fontSize: 20),
                  ),
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(left: 20),
                      height: 300,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 100,
                            // padding: EdgeInsets.only(left: 5,right: 5),
                            child: TextButton(
                              // color: Color(0xFF2c2924),
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              //   side: BorderSide(color: Color(0xFFffab00)),
                              // ),
                              child: Text("Pictures",
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Color(0xFFffab00),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Pictures(userId: ownuserId.toString(),companyId: owncompanyId.toString(),)));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 100,
                            // padding: EdgeInsets.only(left: 5,right: 5),
                            child: TextButton(
                              // color: Color(0xFF2c2924),
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              //   side: BorderSide(color: Color(0xFFffab00)),
                              // ),
                              child: Text("Videos",
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Color(0xFFffab00),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Videos(userId: ownuserId.toString(),companyId: owncompanyId.toString(),)));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 100,
                            // padding: EdgeInsets.only(left: 5,right: 5),
                            child: TextButton(
                              // color: Color(0xFF2c2924),
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              //   side: BorderSide(color: Color(0xFFffab00)),
                              // ),
                              child: Text("Albums",
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Color(0xFFffab00),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Albums(userId: ownuserId.toString(),companyId: owncompanyId.toString())));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Color(0xFFffab00),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _web2Visual(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Add Text",
                  style: TextStyle(fontFamily: 'crimson', color: Colors.black),
                ),
                SizedBox(width: 120,),
                IconButton(onPressed: () {
                  Navigator.pop(context);
                },
                    icon: Icon(Icons.close_sharp, color: Colors.black,)),
              ],
            ),
            content: SingleChildScrollView(
              child: Container(
                color: Colors.white24,
                child: ListBody(
                  children: [
                    Container(
                      child: TextField(
                        controller: companyDescriptionEdit,
                        maxLines: 25,
                        // expands: true,
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'crimson',
                            fontSize: 16),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: companyDescription.toString(),
                          hintStyle: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'crimson',
                              fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child: TextButton(
                              // color: Color(0xFFffab00),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    fontFamily: 'crimson',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                              ),
                              onPressed: () {
                                setState(() {
                                  companyDescription =
                                      companyDescriptionEdit.text.toString();
                                });
                                onGoBackdescription();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: TextButton(
                              // color: Colors.white70,
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontFamily: 'crimson',
                                    color: Colors.black87),
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
                ),
              ),
            ),
          );
        });
  }

  Future<void> _services(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Add Services",
                  style: TextStyle(fontFamily: 'crimson', color: Colors.black),
                ),
                SizedBox(width: 80,),
                IconButton(onPressed: () {
                  Navigator.pop(context);
                },
                    icon: Icon(Icons.close_sharp, color: Colors.black,)),
              ],
            ),
            content: SingleChildScrollView(
              child: Container(
                color: Colors.white24,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ListBody(
                    children: [
                      Container(
                        child: TextField(
                          controller: service1,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'crimson',
                              fontSize: 16),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: services1Display,
                            hintStyle: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'crimson',
                                fontSize: 16),
                          ),
                          onChanged: (String Value) {},
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextField(
                          controller: service2,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'crimson',
                              fontSize: 16),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: services2Display,
                            hintStyle: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'crimson',
                                fontSize: 16),
                          ),
                          onChanged: (String Value) {},
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextField(
                          controller: service3,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'crimson',
                              fontSize: 16),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: services3Display,
                            hintStyle: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'crimson',
                                fontSize: 16),
                          ),
                          onChanged: (String Value) {},
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextField(
                          controller: service4,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'crimson',
                              fontSize: 16),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: services4Display,
                            hintStyle: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'crimson',
                                fontSize: 16),
                          ),
                          onChanged: (String Value) {},
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextField(
                          controller: service5,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'crimson',
                              fontSize: 16),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: services5Display,
                            hintStyle: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'crimson',
                                fontSize: 16),
                          ),
                          onChanged: (String Value) {},
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextField(
                          controller: service6,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'crimson',
                              fontSize: 16),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: services6Display,
                            hintStyle: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'crimson',
                                fontSize: 16),
                          ),
                          onChanged: (String Value) {},
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child: TextButton(
                                // color: Color(0xFFffab00),
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      fontFamily: 'crimson',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87),
                                ),
                                onPressed: () {
                                  setState(() {
                                    makeCompanyServicesAPicall();
                                    print("services updated Successfully");
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: TextButton(
                                // color: Colors.white70,
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontFamily: 'crimson',
                                      color: Colors.black87),
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
                  ),
                ),
              ),
            ),
          );
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

  makeCountry() async {
    ApiService.getcall("app-country-list").then((success) async {
      final body = json.decode(success);
      setState(() {
        countryList = body["countries_list"] as List;
      });
      print("response====================================");
      print(body["countries_list"][0]["name"]);
      print(designation_one);
    });
  }

  makeStatesAPicall() async {
    Map<String, dynamic> formMap = {
      "country_id": countryId,
    };
    print(formMap);
    ApiService.postcall("app-state-list", formMap).then((success) async {
      final body = json.decode(success);
      print("data////");

      print(body);
      setState(() {
        stateList = body["data"] as List;
      });
      print(stateList);
      print("jhjjhjhj");
    });
  }


  makeCityAPicall() async {
    Map<String, dynamic> formMap = {
      "country_id": countryId,
      "state_id": stateId,
    };
    print(formMap);
    ApiService.postcall("app-citis-list", formMap).then((success) async {
      final body = json.decode(success);
      print("data////");

      print(body);
      setState(() {
        cityList = body["data"] as List;
      });
      print(cityList);
      print("jhjjhjhj");
    });
  }

  Future<Null> _pickImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
        _cropImage();
      });
    }
  }
  Future<Null> _CoverpickImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
        _cropImageCover();
      });
    }
  }

  Future<Null> _cropImage() async {
    setState(() {
      filePath = imageFile!.path;
      // print(filePath);
    });
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile!.path,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            cropFrameColor: Colors.transparent,
            cropGridColor: Colors.transparent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio3x2,
            hideBottomControls: true,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
    makeApiupload();
  }

  Future<Null> _cropImageCover() async {
    setState(() {
      filePath = imageFile!.path;
      // print(filePath);
    });
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile!.path,
        cropStyle: CropStyle.rectangle,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            cropFrameColor: Colors.transparent,
            cropGridColor: Colors.transparent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio16x9,
            hideBottomControls: true,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
    makeCoverApiupload();
  }


  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }

  makeApiupload() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(imageFile!.path.toString());
    ApiService.uploadComapnyLogo("app-company-logo-image",prefs.getString('userid'),prefs.getString('companyid'),imageFile!.path.toString()).then((success) async {
      print("CompanyLogo Response++++++++++++++++");
      makeCompanyProfilaAPicall();
    });
  }
 makeCoverApiupload() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(imageFile!.path.toString());
    ApiService.uploadComapnyCoverLogo("app-company-cover-image",prefs.getString('userid'),prefs.getString('companyid'),imageFile!.path.toString()).then((success) async {
      print(success);
      makeCompanyProfilaAPicall();
      print("CompanyLogo Response++++++++++++++++");
    });
  }

  makeCompanyProfilaAPicall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    companyImage = prefs.getString("companylogo");
    ownuserId = prefs.getString('userid');
    owncompanyId = prefs.getString('companyid');
    Map<String, dynamic> formMap = {
      "company_id": prefs.getString('companyid'),
      "user_id": prefs.getString('userid'),
    };
    ApiService.postcall("app-company-profile", formMap).then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body);
      setState(() {
        companyList = body["companyData"];
        companyName = body["companyData"]["c_name"].toString();
        coverImage = body["companyData"]["Cover_Photo"].toString();
        companyImage = body["companyData"]["Company_Logo"].toString();
        companyDescription = body["companyData"]["Company_Description"].toString() == '' ? '' : body["companyData"]["Company_Description"].toString();
        services1Display = body["companyData"]["Service_1"].toString();
        services2Display = body["companyData"]["Service_2"].toString();
        services3Display = body["companyData"]["Service_3"].toString();
        services4Display = body["companyData"]["Service_4"].toString();
        services5Display = body["companyData"]["Service_5"].toString();
        services6Display = body["companyData"]["Service_6"].toString();
        industryName = body["companyData"]["c_name"].toString();
        companyNumber = body["companyData"]["Company_Contact"].toString();
        companyMail = body["companyData"]["Company_Email"].toString();
        industryLocaton = (body["companyData"]["cityName"].toString() + "," + body["companyData"]["stateName"].toString() + "\n" + body["companyData"]["countryName"].toString());
      });
      print(companyList);
      print(companyName);
      print(coverImage);
      print(companyDescription);
      print(services1Display);
      print(services2Display);
      print(services3Display);
      print(services4Display);
      print(services5Display);
      print(services6Display);
      print(industryName);
      print(companyNumber);
      print(companyMail);
      print(industryLocaton);
      print("jhjjhjhj");
    });
  }

  makeCompanyTeamsAPicall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "companyId": prefs.getString('companyid'),
      "userId": prefs.getString('userid'),
    };
    ApiService.postcall("app-company-team-list", formMap).then((success) async {
      final body = json.decode(success);
      print("response====================================");
      setState(() {
        companyTeamsList = body["company_users_list"] as List;
        if (companyTeamsList.length == 1) {
          for (int i = 0; i < 5; i++) {
            String addUser = jsonEncode({
              "userId": "2",
              "fname": "",
              "lname": "",
              "linkedin_url": "linkedin.com",
              "profileImage": "",
              "designation": "",
              "userGenre": "Hip-Hop"
            });
            companyTeamsList.add(json.decode(addUser));
          }
        } else if (companyTeamsList.length == 2) {
          for (int i = 0; i < 4; i++) {
            String addUser = jsonEncode({
              "userId": "2",
              "fname": "",
              "lname": "",
              "linkedin_url": "linkedin.com",
              "profileImage": "",
              "designation": "",
              "userGenre": "Hip-Hop"
            });
            companyTeamsList.add(json.decode(addUser));
          }
        } else if (companyTeamsList.length == 3) {
          for (int i = 0; i < 3; i++) {
            String addUser = jsonEncode({
              "userId": "2",
              "fname": "",
              "lname": "",
              "linkedin_url": "linkedin.com",
              "profileImage": "",
              "designation": "",
              "userGenre": "Hip-Hop"
            });
            companyTeamsList.add(json.decode(addUser));
          }
        } else if (companyTeamsList.length == 4) {
          for (int i = 0; i < 2; i++) {
            String addUser = jsonEncode({
              "userId": "2",
              "fname": "",
              "lname": "",
              "linkedin_url": "linkedin.com",
              "profileImage": "",
              "designation": "",
              "userGenre": "Hip-Hop"
            });
            companyTeamsList.add(json.decode(addUser));
          }
        } else if (companyTeamsList.length == 5) {
          for (int i = 0; i < 1; i++) {
            String addUser = jsonEncode({
              "userId": "2",
              "fname": "",
              "lname": "",
              "linkedin_url": "linkedin.com",
              "profileImage": "",
              "designation": "Music Producer\/composer",
              "userGenre": "Hip-Hop"
            });
            companyTeamsList.add(json.decode(addUser));
          }
        }
      });
      print(companyTeamsList);
      print("jhjjhjhj");
    });
  }


  makeCompanyServicesAPicall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "user_id": prefs.getString('userid'),
      "company_id": prefs.getString('companyid'),
      "service1" : service1.text.toString() == "" ? services1Display :service1.text.toString(),
      "service2" : service2.text.toString() == "" ? services2Display :service2.text.toString(),
      "service3" : service3.text.toString() == "" ? services3Display :service3.text.toString(),
      "service4" : service4.text.toString() == "" ? services4Display :service4.text.toString(),
      "service5" : service5.text.toString() == "" ? services5Display :service5.text.toString(),
      'service6' : service6.text.toString() == "" ? services6Display :service6.text.toString(),
    };
    ApiService.postcall("app-company-service-update", formMap).then((success) async {
      final body = json.decode(success);
      onGoBackservices();
      print("response====================================");
      setState(() {
        companyServicesList = body["data"] as List;
        // service1.clear();
        // service2.clear();
        // service3.clear();
        // service4.clear();
        // service5.clear();
        // service6.clear();
      });
      print(companyServicesList);
      print("jhjjhjhj");
    });
  }


  onGoBackservices() {
    makeCompanyProfilaAPicall();
    setState(() {});
  }

  onGoBackdescription() {
    makeCompanyProfilaAPicall();
    setState(() {});
  }

  onGoBackinfo() {
    makeCompanyInfoUpdateAPicall();
    setState(() {});
  }

  getRoledata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString('role') == "Guest") {
        isGuest = false;
        print("IF+Mounish");
      } else {
        isGuest = true;
        print("ELSE+Mounish");
      }
    });
  }

  makeCompanyInfoUpdateAPicall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "user_id": prefs.getString('userid'),
      "company_id": prefs.getString('companyid'),
      "Industry_Type": "101",
      "countryid": countryId.toString(),
      "state_id": stateId.toString(),
      "city_id": cityId.toString(),
      "Company_Email": infoEmail.text.toString(),
      "Company_Contact": infoMobnum.text.toString(),
      "Facebook": faceBook.text.toString(),
      "Instagram": instaGram.text.toString(),
      "Linkedin": linkedIn.text.toString(),
    };
    print(formMap);
    ApiService.postcall("app-company-contact-update", formMap).then((success) async {
      final body = json.decode(success);
      print("response====================================");
      onGoBackinfo();
      print(body);
      setState(() {
        infoUpdate = body["data"] as List;
        companyNumber = infoMobnum.text.toString();
        companyMail = infoEmail.text.toString();
        industryLocaton = countryValue.toString();
      });
      Utilities.showAlert(context, body["message"].toString());
      print(infoUpdate);
      print("jhjjhjhj");
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

}


class SelectCard extends StatefulWidget {
  final String pluginImage;
  final String pluginName;
  final String designation;
  const SelectCard({Key? key,required this.pluginImage,
    required this.pluginName,
    required this.designation}) : super(key: key);

  @override
  State<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  List designation_one = [];
  List designation_two = [];
  List inviteData = [];
  String? desig1Value;
  String? desig1Id;
  String? desig2Id;
  String? desig2Value;
  String? artistValue;
  String? artistId;
  List artist_genre = [];
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController confirmEmail = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makedesignationsone();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.pluginImage == ""
                          ? Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showDialog(context);
                            },
                            child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Badge.png"),
                                      fit: BoxFit.fill),
                                ),
                                child: GestureDetector(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black12,
                                        child: Icon(
                                          Icons.person_add,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        radius: 30,
                                      )),
                                  onTap: () {
                                    _showDialog(context);
                                  },
                                )),
                          ),
                        ],
                      )
                          : GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/Services_BG.png",
                                  ),
                                  fit: BoxFit.fill),
                              shape: BoxShape.circle),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent),
                            alignment: Alignment.center,
                            child: Image.network(
                              widget.pluginImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                          // imageFile != null ? Image.file(imageFile!,fit: BoxFit.contain,) : Container(),
                        ),
                      ),
                      widget.pluginName == ""
                          ? Text(
                        'Add User',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Crimson',
                          color: Colors.white70,
                        ),
                      )
                          : Text(
                        widget.pluginName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Crimson',
                          color: Colors.white70,
                        ),
                      ),
                      widget.designation == ""
                          ? Text(
                        'Designation',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Crimson',
                          color: Colors.white70,
                        ),
                      )
                          : AutoSizeText(
                        widget.designation,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Crimson',
                          color: Colors.white70,
                        ),
                        maxLines: null,
                      ),
                      SizedBox(height: 5,),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              "assets/images/Group_275.png", height: 30,
                              width: 30,)
                        ),
                      )
                    ],
                  ),
                ),
              ]),
        ));
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
                  Text( "Invite your c-level executive (5)",style: TextStyle(fontSize: 15,fontFamily: 'crimson',color: Colors.black),),
                  SizedBox(width: 48,),
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
                                    controller: firstName,
                                    style: TextStyle(fontFamily:'crimson',color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: 'First Name',
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
                                  height: 50,
                                  child: TextField(
                                    controller: lastName,
                                    style: TextStyle(fontFamily:'crimson',color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: 'Last Name',
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
                                  child:
                                  DropdownButton(
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
                                        value:item['name'],
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
                                            desig1Id = designation_one[i]['id'].toString();
                                          }
                                        }
                                        print(desig1Id);
                                        print("////id////");
                                      });
                                    },
                                    value: desig1Value,
                                  ),
                                ),
                                SizedBox(height:10,),
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
                                  child:  DropdownButton(
                                    hint: Text("--Designation Two--"),
                                    isExpanded: true,
                                    underline: DropdownButtonHideUnderline(
                                      child: Container(),
                                    ),
                                    dropdownColor: Colors.white,
                                    iconSize: 20,
                                    iconDisabledColor: Colors.white,
                                    iconEnabledColor: Colors.white,
                                    value: desig2Value,
                                    icon: const Icon(Icons.keyboard_arrow_down,
                                        color: Colors.black),
                                    items: designation_two.map((item) {
                                      return DropdownMenuItem(
                                        value:item['name'],
                                        child: Text(item['name'].toString(),
                                            style: TextStyle(
                                              fontFamily: 'Crimson',
                                              color: Colors.black,
                                            )),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (value) {
                                      setState(() {
                                        desig2Value = value as String?;
                                        for (int i = 0;
                                        i < designation_two.length;
                                        i++) {
                                          if (value ==
                                              designation_two[i]['name']) {
                                            desig2Id = designation_two[i]['id'].toString();
                                          }
                                        }
                                        print(desig2Id);
                                        print("////id////");
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height:10,),
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
                                    value: artistValue,
                                    icon: const Icon(Icons.keyboard_arrow_down,
                                        color: Colors.black),
                                    items: artist_genre.map((item) {
                                      return DropdownMenuItem(
                                        value:item['name'],
                                        child: Text(item['name'].toString(),
                                            style: TextStyle(
                                              fontFamily: 'Crimson',
                                              color: Colors.black,
                                            )),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (value) {
                                      setState(() {
                                        artistValue = value as String?;
                                        for (int i = 0;
                                        i < artist_genre.length;
                                        i++) {
                                          if (value ==
                                              artist_genre[i]['name']) {
                                            artistId = artist_genre[i]['id'].toString();
                                          }
                                        }
                                        print(artistId);
                                        print("////id////");
                                      });
                                    },
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
                                  height: 50,
                                  child: TextField(
                                    controller: email,
                                    style: TextStyle(fontFamily:'crimson',color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: 'Email',
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
                                  height: 50,
                                  child: TextField(
                                    controller: confirmEmail,
                                    style: TextStyle(fontFamily:'crimson',color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: 'Confirm Email',
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
                                          child: Text("Invite",style:TextStyle(
                                              fontFamily: 'crimson', color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 16),),
                                          onPressed: (){
                                            if (firstName.text.length == 0) {
                                              Utilities.showAlert(
                                                  context, "Please Enter First Name");
                                            } else if (lastName.text.length == 0) {
                                              Utilities.showAlert(
                                                  context, "Please Enter Last Name");
                                            } else if (email.text.length == 0) {
                                              Utilities.showAlert(
                                                  context, "Please Enter Email");
                                            } else if (confirmEmail.text.length == 0) {
                                              Utilities.showAlert(
                                                  context, "Please Enter Confirm Email");
                                            }else{
                                              makeCompanyInviteAPicall();
                                              Navigator.pop(context);
                                              print(firstName.text.toString());
                                              print(lastName.text.toString());
                                              print(desig1Id);
                                              print(desig2Id);
                                              print(artistId);
                                              print(email.text.toString());
                                              print(confirmEmail.text.toString());
                                              print("/////invite/////");
                                            }
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
      makedesignationstwo();
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
      makeArtistgenre();
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

  onGoBackinvite() {
    makeCompanyInviteAPicall();
    setState(() {});
  }

  makeCompanyInviteAPicall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid'),
      "companyId": prefs.getString('companyid'),
      "companyName": prefs.getString('companyname'),
      "songUrl": prefs.getString('websitelink'),
      "email": email.text.toString(),
      "fname": firstName.text.toString(),
      "lname": lastName.text.toString(),
      "Designation1": desig1Id.toString(),
      "Designation2": desig2Id.toString(),
      "artistGenre": artistId.toString(),
    };
    ApiService.postcall("app-invite-user", formMap).then((success) async {
      final body = json.decode(success);
      onGoBackinvite();
      print("response====================================");
      setState(() {
        inviteData = body["data"] as List;
      });
      print(inviteData);
      print("jhjjhjhj");
    });
  }
}
