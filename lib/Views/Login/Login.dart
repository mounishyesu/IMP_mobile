import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/Views/Login/ForgotorCreate_Password.dart';
import 'package:music_player/Views/Tabs/Tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers/Utilities.dart';
import 'Sign_Up.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  var Name = TextEditingController();
  var Password = TextEditingController();
  bool _showPassword = false;
  var _userName;
  var _password;

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
           height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
          child: Container(
          decoration: new BoxDecoration(
                color: Colors.black87,
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/Services_BG.png",
                    ),
                    fit: BoxFit.fill)),
            child: ListView(children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 15),
                        child: Image.asset(
                          "assets/images/imp_logo.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: GestureDetector(
                        child: AutoSizeText(
                          "Do You Have an IMP generated PIN Code?",
                          style: TextStyle(
                            color: Colors.white,
                            // fontSize: 14,
                            fontFamily: 'Crimson',
                          ),
                          minFontSize: 12,
                          maxFontSize: 16,
                          maxLines: null,
                        ),
                        onTap: () {
                          String typeCreate = "Create";
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ForgororCreate_password(type: typeCreate,)));
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Color(0xFFffab00),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: Name,
                          onChanged: ((String userName) {
                            setState(() {
                              _userName = userName;
                            });
                          }),
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFffab00),
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFffab00),
                                width: 1.0,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                              fontFamily: 'Crimson',
                            ),
                            prefixIcon: Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: Color(0xFFffab00), width: 1)),
                              ),
                              child: Icon(
                                Icons.mail_outline_sharp,
                                color: Color(0xFFffab00),
                                size: MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          // validator: (value) {
                          //   if (value!.isEmpty || value.length < 3) {
                          //     return "Please enter valid Email";
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          controller: Password,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Crimson',
                          ),
                          onChanged: ((String password) {
                            setState(() {
                              _password = password;
                            });
                          }),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFffab00),
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFffab00),
                                width: 1.0,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: " Password",
                            prefixIcon: Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                    color: Color(0xFFffab00),
                                    width: 1,
                                  )),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  child: Icon(
                                      _showPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0xFFffab00),
                                      size: MediaQuery.of(context).size.width *
                                          0.05),
                                )),
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white70),
                          ),
                          obscureText: !_showPassword,
                          textAlign: TextAlign.center,
                          // validator: (value) {
                          //   // Pattern pattern = ("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");
                          //   // RegExp regex = new RegExp(pattern);
                          //   if (value!.length == 0) {
                          //     return 'Please enter Password';
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Container(
                            height: 50,
                            width: 100,
                            // padding: EdgeInsets.only(left: 5,right: 5),
                            child: TextButton(
                              // color: Color(0xFF2c2924),
                              // color:Colors.yellow.shade500,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              //   side: BorderSide(color: Color(0xFFffab00)),
                              // ),
                              child: Text("Submit",
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Color(0xFFffab00),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              onPressed: () {
                                if (Name.text.length == 0 ||
                                    Name.text.length <= 2) {
                                  emailAlert(context);
                                } else if (Password.text.length == 0) {
                                  passwordAlert(context);
                                }else{
                                  Utilities.displayDialog(context);
                                  Map<String, dynamic>    formMap = {
                                    "token": "",
                                    "email": Name.text.toString(),
                                    "password": Password.text.toString(),
                                  } ;
                                  ApiService.postcall("app-login",formMap)
                                      .then((success) async {
                                    final body =
                                    json.decode(success);
                                    print("response====================================");
                                    userDetail(success);

                                  });
                                }
                              },
                            ),
                          )),
                      SizedBox(
                        height: 150,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: GestureDetector(
                        child: Text(
                          "SignUp?",
                          style: TextStyle(
                              fontFamily: 'Crimson',
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Sign_Up()));
                        },
                      ),
                    ),
                    SizedBox(
                      child: GestureDetector(
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Crimson',
                          ),
                        ),
                        onTap: () {
                          String typeForget = "Forgot";
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ForgororCreate_password(type: typeForget,)));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ])),
    ),
    );
  }

  emailAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Container(
              height: 100,
              child: Center(
                child: Text("Please enter a valid email",
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
                      Navigator.of(context).pop();
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

  passwordAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 1.5,
              child: Center(
                child: Text("Please chech your password",
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
                      Navigator.of(context).pop();
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

  userDetail(success) async {
  Navigator.pop(context);
  final body = json.decode(success.toString());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('username',body["data"]["First_Name"].toString()+""+body["data"]["Last_Name"].toString() );
  prefs.setString('userid',body["data"]["id"].toString());
  prefs.setString('email',body["data"]["Email"].toString());
  prefs.setString('contact',body["data"]["Contact"].toString());
  prefs.setString('websitelink',body["data"]["Website_Link"].toString());
  prefs.setString('profileimage',body["data"]["Profile_Image"].toString());
  prefs.setString('companyname',body["data"]["Company_Name"].toString());
  prefs.setString('designation1',body["data"]["Designation1"].toString());
  prefs.setString('designation2',body["data"]["Designation2"].toString());
  prefs.setString('designation1content',body["data"]["Designation1_content"].toString());
  prefs.setString('designation2content',body["data"]["Designation2_content"].toString());
  prefs.setString('artistgenre',body["data"]["artist_genre"].toString());
  prefs.setString('userdescription',body["data"]["User_Description"].toString());
  prefs.setString('tradedoc',body["data"]["Trade_Doc"].toString());
  prefs.setString('businesscard',body["data"]["Business_Card"].toString());
  prefs.setString('userfacebook',body["data"]["User_Facebook"].toString());
  prefs.setString('userinstagram',body["data"]["User_Instagram"].toString());
  prefs.setString('linkedinURL',body["data"]["Linkedin_URL"].toString());
  prefs.setString('pincode',body["data"]["pincode"].toString());
  prefs.setString('invitedby',body["data"]["Invited_by"].toString());
  prefs.setString('companyid',body["data"]["Company_Id"].toString());
  prefs.setString('role',body["data"]["role"].toString());
  prefs.setString('token',body["data"]["token"].toString());
  prefs.setString('status',body["data"]["Status"].toString());
  prefs.setString('emailnotify',body["data"]["email_notify"].toString());
  prefs.setString('createdat',body["data"]["created_at"].toString());
  prefs.setString('lastlogin',body["data"]["last_login"].toString());
  prefs.setString('profileimagepath',body["profile_image_path"].toString());
  prefs.setString('coverimagepath',body["cover_image_path"].toString());
  prefs.setString('companylogopath',body["company_logo_path"].toString());
  prefs.setString('companylogo',body["data"]["Company_Logo"].toString());
  prefs.setBool('islogin', true);

  if(body["status"] == "success"){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Tabs()));  }



  print(body["data"]["First_Name"] +" "+body["data"]["Last_Name"]);
  print(body["data"]["Email"]);
  print(body["data"]["Contact"]);
  print(body["data"]["Company_Name"]);
  print(body["data"]["Website_Link"]);
  print(body["data"]["Company_Logo"]);
  print("mounish");
}
}
