import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/Views/Login/Login.dart';
import 'package:music_player/helpers/Utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgororCreate_password extends StatefulWidget {
  final String type;

   ForgororCreate_password({Key? key,required this.type}) : super(key: key);

  @override
  _ForgororCreate_passwordState createState() =>
      _ForgororCreate_passwordState();
}

class _ForgororCreate_passwordState extends State<ForgororCreate_password> {
  var email = TextEditingController();
  var email1 = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var pin = TextEditingController();
  String desig1Value = "Designation One";
  String desig2Value = "Designation Two";
  bool checked = true;
  bool _showPassword = false;
  bool _showPassword1 = false;
  var _password;
  var _password1;
  bool isCreate = false;
  bool isForget = false;
  String title = " ";

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if(widget.type.toString() == "Create"){
      setState(() {
        isCreate = true;
        isForget = false;
        title = "Create Password";
      });
    }else{
      setState(() {
        isCreate = false;
        isForget = true;
        title = "Forgot Password";
      });

    }
    return Scaffold(
      appBar: AppBar(
        title:  Row(
          children: [
            Icon(Icons.arrow_back,color: Colors.black87,),
            SizedBox(width: 100,),
            Text(title,
              style: TextStyle(
                color: Colors.black87,
                  fontFamily: 'Crimson',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xFFffab00)),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Services_BG.png",
                ),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Visibility(
                visible: isCreate,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      height: MediaQuery.of(context).size.height * 1,
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
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                    controller: email,
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
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: TextFormField(
                                    controller: password,
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
                                      hintText: " Password",
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
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _showPassword = !_showPassword;
                                              });
                                            },
                                            child: Icon(
                                                _showPassword
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                    .visibility_off_outlined,
                                                color: Color(0xFFffab00),
                                                size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.05),
                                          )),
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white70),
                                    ),
                                    obscureText: !_showPassword,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 52,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: TextFormField(
                                    controller: confirmPassword,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Crimson',
                                    ),
                                    onChanged: ((String password) {
                                      setState(() {
                                        _password1 = password;
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
                                      hintText: "Confirm Password",
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
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _showPassword1 = !_showPassword1;
                                              });
                                            },
                                            child: Icon(
                                                _showPassword1
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                    .visibility_off_outlined,
                                                color: Color(0xFFffab00),
                                                size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.05),
                                          )),
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white70),
                                    ),
                                    obscureText: !_showPassword1,
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
                                    controller: pin,
                                    onChanged: ((String pin) {
                                      setState(() {
                                        pin = pin;
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
                                      hintText: 'Pin',
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
                                          Icons.fiber_pin_rounded,
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
                                        if (email.text.length == 0) {
                                          Utilities.showAlert(
                                              context, "Please Enter Email");
                                        } else if (password.text.length == 0) {
                                          Utilities.showAlert(
                                              context, "Please Enter Password");
                                        } else if (confirmPassword.text.length ==
                                            0) {
                                          Utilities.showAlert(context,
                                              "Please Enter Confirm Password");
                                        }else if (pin.text.length ==
                                            0) {
                                          Utilities.showAlert(context,
                                              "Please Enter Pin");
                                        } else {
                                          makepassswordApi();
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
              ),
              Visibility(
                visible: isForget,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      height: MediaQuery.of(context).size.height * 1,
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
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                        fontFamily: 'Crimson',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                    controller: email1,
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
                                        if (email1.text.length == 0) {
                                          Utilities.showAlert(
                                              context, "Please Enter Email");
                                        } else {
                                          /* Map<String, dynamic> formMap = {
                                              "Email": email.text.toString(),
                                            };
                                            ApiService.postcall(
                                                    "app-signup", formMap)
                                                .then((success) async {
                                              final body = json.decode(success);
                                              print(
                                                  "response====================================");
                                            });*/
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
              ),
            ],
          ),
        ),
      ),
    );
  }
  makepassswordApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   if(pin.text.toString() == prefs.getString('pincode')) {
    if(prefs.getString('type') == "Guest") {
      Map<String, dynamic> formMap = {
        "First_Name": prefs.getString('First_Name'),
        "Last_Name": prefs.getString('Last_Name'),
        "Email": prefs.getString('Email'),
        "Contact": prefs.getString('Contact'),
        "pincode": pin.text.toString(),
        "password": password.text.toString(),
      };
      ApiService.postcall(
          "app-guest-signup", formMap)
          .then((success) async {
        final body = json.decode(success);
        print(
            "response====================================");
        Utilities.showAlert(context, body["message"].toString());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Login()));
      });

    }else{
      Utilities.showAlert(context, "Invalid Pincode");
    }
    }else{
      Map<String, dynamic> formMap = {
        "email": email.text.toString(),
        "password": password.text.toString(),
        "pincode": pin.text.toString(),
      };
      ApiService.postcall(
          "app-password-create", formMap)
          .then((success) async {
        final body = json.decode(success);
       Utilities.showAlert(context, body["message"].toString());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Login()));
      });
    }

  }
}
