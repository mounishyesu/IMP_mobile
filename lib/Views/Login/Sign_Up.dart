import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/Views/Login/ForgotorCreate_Password.dart';
import 'package:music_player/Views/Login/Login.dart';
import 'package:music_player/helpers/Utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({Key? key}) : super(key: key);

  @override
  _Sign_UpState createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  var firstName = TextEditingController();
  var firstName1 = TextEditingController();
  var songUrl = TextEditingController();
  var lastName = TextEditingController();
  var lastName1 = TextEditingController();
  var email = TextEditingController();
  var email1 = TextEditingController();
  var forgotEmail = TextEditingController();
  var contact = TextEditingController();
  var contact1 = TextEditingController();
  var designation_1 = TextEditingController();
  var designation_2 = TextEditingController();
  var category = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<PlatformFile>? _paths;
  List designation_one = [];
  List designation_two = [];
  List? artist_genre = [];
  String? _directoryPath;
  String? _extension;
  String? desig1Value = "Designation One";
  String? desig2Value = "Designation Two";
  String? artistValue = "Artist Genre";
  String? desigId1 = "";
  String? desigId2 = "";
  String? artistId = "";
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();
  bool checked = true;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
    makedesignationsone();
    makedesignationstwo();
    makeArtistgenre();
  }

  void _openFileExplorer() async {
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      print(_paths!.first.extension);
    });
  }

  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result! ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backwardsCompatibility: true,
            backgroundColor: Colors.black,
            bottom: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              unselectedLabelStyle:
                  TextStyle(fontFamily: 'Crimson', color: Colors.white),
              indicator: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Color(0xFFffab00)),
              tabs: [
                Tab(
                  child: Container(
                    child: Text(
                      "Artist",
                      style: TextStyle(
                          fontFamily: 'Crimson',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Enthusiast",
                    style: TextStyle(
                        fontFamily: 'Crimson',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ],
              indicatorColor: Colors.white,
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    height: MediaQuery.of(context).size.height * 0.85,
                    decoration: new BoxDecoration(
                        color: Colors.black87,
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/Services_BG.png",
                            ),
                            fit: BoxFit.fill)),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                height: 52,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70),
                                  controller: firstName,
                                  onChanged: ((String firstName) {
                                    setState(() {
                                      firstName = firstName;
                                    });
                                  }),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'First Name',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                    prefixIcon: Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                          color: Color(0xFFffab00)
                                              .withOpacity(0.4),
                                          width: 2.0,
                                        )),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Color(0xFFffab00),
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 52,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70),
                                  controller: lastName,
                                  onChanged: ((String lastName) {
                                    setState(() {
                                      lastName = lastName;
                                    });
                                  }),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Last Name',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                    prefixIcon: Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                          color: Color(0xFFffab00)
                                              .withOpacity(0.4),
                                          width: 2.0,
                                        )),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Color(0xFFffab00),
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 52,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70),
                                  controller: email,
                                  onChanged: ((String email) {
                                    setState(() {
                                      email = email;
                                    });
                                  }),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                    prefixIcon: Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                          color: Color(0xFFffab00)
                                              .withOpacity(0.4),
                                          width: 2.0,
                                        )),
                                      ),
                                      child: Icon(
                                        Icons.email,
                                        color: Color(0xFFffab00),
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 52,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70),
                                  keyboardType: TextInputType.phone,
                                  controller: contact,
                                  onChanged: ((String contact) {
                                    setState(() {
                                      contact = contact;
                                    });
                                  }),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Contact',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                    prefixIcon: Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                          color: Color(0xFFffab00)
                                              .withOpacity(0.4),
                                          width: 2.0,
                                        )),
                                      ),
                                      child: Icon(
                                        Icons.phone,
                                        color: Color(0xFFffab00),
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  border: Border.all(
                                    color: Color(0xFFffab00).withOpacity(0.4),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ListTile(
                                  leading: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                            color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                            width: 2.0,
                                          )),
                                    ),
                                    child: Icon(
                                      Icons.work,
                                      color: Color(0xFFffab00),
                                      size: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    padding: EdgeInsets.only(right: 10),
                                    margin: EdgeInsets.only(
                                      right: 60,
                                    ),
                                  ),
                                  title: ListTile(
                                    title: Text(desig1Value.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    onTap: () {
                                      _designationOne();
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  border: Border.all(
                                    color: Color(0xFFffab00).withOpacity(0.4),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ListTile(
                                  leading: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      )),
                                    ),
                                    child: Icon(
                                      Icons.work,
                                      color: Color(0xFFffab00),
                                      size: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    padding: EdgeInsets.only(right: 10),
                                    margin: EdgeInsets.only(
                                      right: 60,
                                    ),
                                  ),
                                  title: ListTile(
                                    title: Text(desig2Value.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    onTap: () {
                                      _designationTwo();
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  border: Border.all(
                                    color: Color(0xFFffab00).withOpacity(0.4),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ListTile(
                                  leading: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      )),
                                    ),
                                    child: Icon(
                                      Icons.work,
                                      color: Color(0xFFffab00),
                                      size: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    padding: EdgeInsets.only(right: 10),
                                    margin: EdgeInsets.only(
                                      right: 60,
                                    ),
                                  ),
                                  title: ListTile(
                                    title: Text(artistValue.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    onTap: () {
                                      _artistGenre();
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 52,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70),
                                  controller: category,
                                  onChanged: ((String category) {
                                    setState(() {
                                      category = category;
                                    });
                                  }),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Company Name',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                    prefixIcon: Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                          color: Color(0xFFffab00)
                                              .withOpacity(0.4),
                                          width: 2.0,
                                        )),
                                      ),
                                      child: Icon(
                                        Icons.dashboard,
                                        color: Color(0xFFffab00),
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text("Song Url",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: 'Crimson',
                                        color: Colors.white,
                                        fontSize: 20)),
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    height: 52,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: TextFormField(
                                        style: TextStyle(
                                            fontFamily: 'Crimson',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white70),
                                        controller: songUrl,
                                        onChanged: ((String url) {
                                          setState(() {
                                            url = url;
                                          });
                                        }),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFffab00)
                                                  .withOpacity(0.4),
                                              width: 2.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFffab00)
                                                  .withOpacity(0.4),
                                              width: 2.0,
                                            ),
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Song url',
                                          hintStyle: TextStyle(
                                              fontFamily: 'Crimson',
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white70),
                                          prefixIcon: Container(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                color: Color(0xFFffab00)
                                                    .withOpacity(0.4),
                                                width: 2.0,
                                              )),
                                            ),
                                            child: Icon(
                                              Icons.link_sharp,
                                              color: Color(0xFFffab00),
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )),
                              Container(
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: checked,
                                      onChanged: (value) {
                                        getCheckBoxValue(value!);
                                      },
                                      activeColor: Colors.white,
                                      checkColor: Colors.black,
                                    ),
                                    Text(
                                      "I agree to the Terms and Conditins",
                                      style: TextStyle(
                                          fontFamily: 'Crimson',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    // color: Color(
                                    //     0xFF2c2924), // color:Colors.yellow.shade500,
                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    //   side: BorderSide(
                                    //     color: Color(0xFFffab00),
                                    //   ),
                                    // ),
                                    child: Text("Submit",
                                        style: TextStyle(
                                            fontFamily: 'Crimson',
                                            color: Color(0xFFffab00),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    onPressed: () {
                                      if (firstName.text.length == 0) {
                                        Utilities.showAlert(
                                            context, "Please Enter First Name");
                                      } else if (lastName.text.length == 0) {
                                        Utilities.showAlert(
                                            context, "Please Enter Last Name");
                                      } else if (email.text.length == 0) {
                                        Utilities.showAlert(
                                            context, "Please Enter Email");
                                      } else if (contact.text.length == 0) {
                                        Utilities.showAlert(
                                            context, "Please Enter Contact");
                                      }else if(desig1Value == "Designation One"){
                                        Utilities.showAlert(
                                            context, "Please Enter Designation One");
                                      }else if(desig2Value == "Designation Two"){
                                        Utilities.showAlert(
                                            context, "Please Enter Designation Two");
                                      } else if (category.text.length == 0) {
                                        Utilities.showAlert(
                                            context, "Please Enter Category");
                                      } else {
                                        Map<String, dynamic> formMap = {
                                          "First_Name":
                                              firstName.text.toString(),
                                          "Last_Name": lastName.text.toString(),
                                          "Email": email.text.toString(),
                                          "Contact": contact.text.toString(),
                                          "Designation1":desigId1,
                                          "Designation2":desigId2,
                                          "company_name":
                                              category.text.toString(),
                                          "song_url": "",
                                        };
                                        print(formMap);
                                        ApiService.postcall(
                                                "app-signup", formMap)
                                            .then((success) async {
                                          final body = json.decode(success);
                                          if(body["status"] == "fail"){
                                            signupAlert(context, body["message"].toString(),body["status"].toString());
                                          }else{
                                            setState(() {
                                              signupAlert(context, body["message"].toString(),body["status"].toString());
                                            });
                                          }
                                          print(
                                              "response====================================");
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => ForgororCreate_password(type: "",)));
                                        });
                                        /* Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                        );*/
                                      }
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    height: MediaQuery.of(context).size.height * 0.85,
                    decoration: new BoxDecoration(
                        color: Colors.black87,
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/Services_BG.png",
                            ),
                            fit: BoxFit.fill)),
                    child: ListView(
                      children: [
                        Container(
                          child: Text(
                            "Lorem lpsum is simply dummy text of the printing and typesetting industry. Lorem lpsum has been the industry's standard  dummy text ever since the 1500s, when an unknown printer took a gallery of type and scrambled it to make a type specimen book",
                            style: TextStyle(
                                fontFamily: 'Crimson',
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70),
                                  controller: firstName1,
                                  onChanged: ((String firstName) {
                                    setState(() {
                                      firstName = firstName;
                                    });
                                  }),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'First Name',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                    prefixIcon: Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                          color: Color(0xFFffab00)
                                              .withOpacity(0.4),
                                          width: 2.0,
                                        )),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Color(0xFFffab00),
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70),
                                  controller: lastName1,
                                  onChanged: ((String lastName) {
                                    setState(() {
                                      lastName = lastName;
                                    });
                                  }),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Last Name',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                    prefixIcon: Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                          color: Color(0xFFffab00)
                                              .withOpacity(0.4),
                                          width: 2.0,
                                        )),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Color(0xFFffab00),
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: email1,
                                  onChanged: ((String email) {
                                    setState(() {
                                      email = email;
                                    });
                                  }),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                    prefixIcon: Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                          color: Color(0xFFffab00)
                                              .withOpacity(0.4),
                                          width: 2.0,
                                        )),
                                      ),
                                      child: Icon(
                                        Icons.email,
                                        color: Color(0xFFffab00),
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70),
                                  keyboardType: TextInputType.phone,
                                  controller: contact1,
                                  onChanged: ((String contact) {
                                    setState(() {
                                      contact = contact;
                                    });
                                  }),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color(0xFFffab00).withOpacity(0.4),
                                        width: 2.0,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Contact',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                    prefixIcon: Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                          color: Color(0xFFffab00)
                                              .withOpacity(0.4),
                                          width: 2.0,
                                        )),
                                      ),
                                      child: Icon(
                                        Icons.phone,
                                        color: Color(0xFFffab00),
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    // color: Color(
                                    //     0xFF2c2924), // color:Colors.yellow.shade500,
                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    //   side:
                                    //       BorderSide(color: Color(0xFFffab00)),
                                    // ),
                                    child: Text("Submit",
                                        style: TextStyle(
                                            fontFamily: 'Crimson',
                                            color: Color(0xFFffab00),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    onPressed: () {
                                      if (firstName1.text.length == 0) {
                                        Utilities.showAlert(
                                            context, "Please Enter First Name");
                                      } else if (lastName1.text.length == 0) {
                                        Utilities.showAlert(
                                            context, "Please Enter Last Name");
                                      } else if (email1.text.length == 0) {
                                        Utilities.showAlert(
                                            context, "Please Enter Email");
                                      } else if (contact1.text.length == 0) {
                                        Utilities.showAlert(
                                            context, "Please Enter Contact");
                                      }else {
                                        Map<String, dynamic> formMap = {
                                          "First_Name": firstName1.text.toString(),
                                          "Last_Name": lastName1.text.toString(),
                                          "Email": email1.text.toString(),
                                          "Contact": contact1.text.toString(),
                                        };
                                        ApiService.postcall(
                                                "app-guest-pincode", formMap)
                                            .then((success) async {
                                          final body = json.decode(success);
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          prefs.setString('type',"Guest");
                                          prefs.setString("First_Name", firstName1.text.toString());
                                          prefs.setString("Last_Name" ,lastName1.text.toString());
                                          prefs.setString("Email", email1.text.toString());
                                          prefs.setString("Contact",contact1.text.toString());
                                          prefs.setString("pincode",body["data"]["pincode"].toString());

                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => ForgororCreate_password(type: '',)));
                                          print(
                                              "response====================================");
                                        });
                                        /* Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                        );*/
                                      }
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Future getPdfAndUpload(int position) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      return "User canceled the picker";
    }

  }

  void getCheckBoxValue(bool value) {
    if (checked == false) {
      // Put your code here which you want to execute on CheckBox Checked.
      setState(() {
        checked = true;
      });
    } else {
      // Put your code here which you want to execute on CheckBox Un-Checked.
      setState(() {
        checked = false;
      });
    }
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

  _designationOne() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              color: Colors.white70,
              height: 300,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Color(0xFFffab00).withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    height: 50,
                    width: 350,
                    child: Text("Designation One",
                      style: TextStyle(fontSize: 20,
                        fontFamily: 'Crimson',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFffab00),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: designation_one.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          height: 50,
                          child: Column(
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      var selectedItem;
                                      selectedItem = designation_one[index]['name'].toString();
                                      desigId1 = designation_one[index]['id'].toString();
                                      print(desigId1);
                                      desig1Value = selectedItem.toString();
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text(
                                    designation_one[index]['name'].toString(),
                                  )),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          color: Color(0xFFffab00).withOpacity(0.4),
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      height: 50,
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 120,
                              child: TextButton(
                                // color: Color(0xFFffab00),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child:Text("Ok",
                                  style: TextStyle(fontSize: 20,
                                    fontFamily: 'Crimson',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                          ),
                          SizedBox(width: 20,),
                          Container(
                              width: 120,
                              child: TextButton(
                                // color: Color(0xFFffab00),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child:Text("Cancel",
                                  style: TextStyle(fontSize: 20,
                                    fontFamily: 'Crimson',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          );
        });
  }

  _designationTwo() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              color: Colors.white70,
              height: 300,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Color(0xFFffab00).withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    height: 50,
                    width: 350,
                    child: Text("Designation Two",
                      style: TextStyle(fontSize: 20,
                        fontFamily: 'Crimson',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFffab00),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: designation_two.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          height: 50,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    var selectedItem;
                                    selectedItem = designation_two[index]['name'].toString();
                                    desigId2 = designation_two[index]['id'].toString();
                                    print(desigId2);
                                    desig2Value = selectedItem.toString();
                                    Navigator.pop(context);
                                  });
                                },
                                  child: Text(
                                designation_two[index]['name'].toString(),
                              )),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Color(0xFFffab00).withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    height: 50,
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          child: TextButton(
                            // color: Color(0xFFffab00),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child:Text("Ok",
                              style: TextStyle(fontSize: 20,
                                fontFamily: 'Crimson',
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ),
                        SizedBox(width: 20,),
                        Container(
                          width: 120,
                          child: TextButton(
                            // color: Color(0xFFffab00),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child:Text("Cancel",
                              style: TextStyle(fontSize: 20,
                                fontFamily: 'Crimson',
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          );
        });
  }

  _artistGenre() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              color: Colors.white70,
              height: 300,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Color(0xFFffab00).withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    height: 50,
                    width: 350,
                    child: Text("Designation Two",
                      style: TextStyle(fontSize: 20,
                        fontFamily: 'Crimson',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFffab00),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: artist_genre!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          height: 50,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    var selectedItem;
                                    selectedItem = artist_genre![index]['name'].toString();
                                    artistId = artist_genre![index]['id'].toString();
                                    print(artistId);
                                    artistValue = selectedItem.toString();
                                    Navigator.pop(context);
                                  });
                                },
                                  child: Text(artist_genre![index]['name'].toString(),
                              )),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Color(0xFFffab00).withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    height: 50,
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          child: TextButton(
                            // color: Color(0xFFffab00),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child:Text("Ok",
                              style: TextStyle(fontSize: 20,
                                fontFamily: 'Crimson',
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ),
                        SizedBox(width: 20,),
                        Container(
                          width: 120,
                          child: TextButton(
                            // color: Color(0xFFffab00),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child:Text("Cancel",
                              style: TextStyle(fontSize: 20,
                                fontFamily: 'Crimson',
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          );
        });
  }

  signupAlert(BuildContext context, String message,String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 1.5,
              child: Center(
                child: Text(message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              )),
          actions: <Widget>[
            Column(
              children: [
                Center(
                  child: TextButton(
                    // color: Colors.black,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    //   side: BorderSide(color: Color(0xFFffab00)),
                    // ),
                    child: Text("Ok",
                        style: TextStyle(
                            fontFamily: 'Crimson',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    onPressed: () {
                      if(status == "fail" ){
                        Navigator.of(context).pop();
                      }else{
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
