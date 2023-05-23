import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/Views/Login/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitched = false;
  List userList = [];
  String emailnotfy="";
  String role="";
  String username="";
  bool isUservisible=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
              fontFamily: 'Crimson', color: Colors.black87, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFffab00),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                height: 20,
              ),
              Container(
                height: 100,
                width: 300,
                child: Card(
                  color: Colors.black87,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Email Notifications",
                          style: TextStyle(
                              fontFamily: 'Crimson',
                              color: Color(0xFFffc107),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Off",
                            style: TextStyle(
                                fontFamily: 'Crimson',
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                print(isSwitched);
                                makeEmailApi();
                              });
                            },
                            inactiveTrackColor: Colors.white70,
                            activeTrackColor: Color(0xFFffc107),
                            activeColor: Colors.white70,
                          ),
                          Text(
                            "On",
                            style: TextStyle(
                                fontFamily: 'Crimson',
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.orange,
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: isUservisible,
                child: Container(
                  // decoration: BoxDecoration(
                  //     border: Border.all(
                  //   color: Colors.orange,
                  // )),
                  width: 300,
                  child: Card(
                    color: Colors.black87,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              Text(
                                "Delete User Accounts",
                                style: TextStyle(
                                    fontFamily: 'Crimson',
                                    color: Color(0xFFffc107),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "(can select other users as well)",
                                style: TextStyle(
                                    fontFamily: 'Crimson',
                                    color: Colors.white70,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            physics: ScrollPhysics(),
                              itemCount: userList.isEmpty ? 0 : userList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(userList[index]["fname"].toString(),
                                        style: TextStyle(
                                            fontFamily: 'Crimson',
                                            color: Colors.white70,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Container(
                                        width: 70,
                                        // padding: EdgeInsets.only(left: 5,right: 5),
                                        child: TextButton(
                                          // color: Color(0xFF2c2924),
                                          // shape: RoundedRectangleBorder(
                                          //   borderRadius: BorderRadius.circular(10),
                                          //   side: BorderSide(color: Color(0xFFffab00)),
                                          // ),
                                          child: Text("Delete",
                                              style: TextStyle(
                                                  fontFamily: 'Crimson',
                                                  color: Color(0xFFffab00),
                                                  fontWeight: FontWeight.bold,
                                                  )),
                                          onPressed: () {
                                            setState(() {
                                              useraccountsShowDialog(context,userList[index]["userId"].toString());
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.orange,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                child: Card(
                  color: Colors.black87,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            Text(
                              "Delete Personal Account",
                              style: TextStyle(
                                  fontFamily: 'Crimson',
                                  color: Color(0xFFffc107),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "(Exit IMP)",
                              style: TextStyle(
                                  fontFamily: 'Crimson',
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            username,
                            style: TextStyle(
                                fontFamily: 'Crimson',
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                            width: 70,
                            // padding: EdgeInsets.only(left: 5,right: 5),
                            child: TextButton(
                              // color: Color(0xFF2c2924),
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              //   side: BorderSide(color: Color(0xFFffab00)),
                              // ),
                              child: Text("Delete",
                                  style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Color(0xFFffab00),
                                      fontWeight: FontWeight.bold,
                                      )),
                              onPressed: () {
                                setState(() {
                                  personalaccountShowDialog(context);
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.orange,
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }

  useraccountsShowDialog(BuildContext context,String userid) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 10,
            alignment: Alignment.center,
            backgroundColor: Colors.black12,
            insetPadding: EdgeInsets.all(10),
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(3),
                      topLeft: Radius.circular(3))),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFffab00),
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(3),
                          topLeft: Radius.circular(3),
                        ),
                        color: Colors.black),
                    child: Text(
                      "Are you sure you want to delete!",
                      style: TextStyle(
                          fontFamily: 'Crimson',
                          color: Color(0xFFffab00),
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Text(
                      'Note: All the Data about the user will be deleted permanently and this action cannot be undone.',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: 'Crimson',
                          color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color(0xFFffab00),
                            side: BorderSide(style: BorderStyle.solid,),
                            padding: EdgeInsets.only(left: 40, right: 40)),
                        child: Text("Delete",
                            style: TextStyle(fontFamily: 'Crimson',color: Colors.black87,fontWeight: FontWeight.bold)),
                        onPressed: () {
                          makeDeleteUserApi(userid);
                          Navigator.pop(context);
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                            side: BorderSide(style: BorderStyle.solid,),
                            padding: EdgeInsets.only(left: 30, right: 30)),
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontFamily: 'Crimson',color: Colors.black87,fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  personalaccountShowDialog(BuildContext context,) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 10,
            alignment: Alignment.center,
            backgroundColor: Colors.black12,
            insetPadding: EdgeInsets.all(10),
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(3),
                      topLeft: Radius.circular(3))),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFffab00),
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(3),
                          topLeft: Radius.circular(3),
                        ),
                        color: Colors.black),
                    child: Text(
                      "Are you sure you want to delete!",
                      style: TextStyle(
                          fontFamily: 'Crimson',
                          color: Color(0xFFffab00),
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Text(
                      'Note: All the Data will be deleted permanently and this action cannot be undone.',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: 'Crimson',
                          color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color(0xFFffab00),
                            side: BorderSide(style: BorderStyle.solid,),
                            padding: EdgeInsets.only(left: 40, right: 40)),
                        child: Text("Delete",
                            style: TextStyle(fontFamily: 'Crimson',color: Colors.black87,fontWeight: FontWeight.bold)),
                        onPressed: () {
                          makeDeleteAdminApi();
                          Navigator.pop(context);
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                            side: BorderSide(style: BorderStyle.solid,),
                            padding: EdgeInsets.only(left: 30, right: 30)),
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontFamily: 'Crimson',color: Colors.black87,fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  getSharedData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailnotfy = prefs.getString('emailnotify');
      role = prefs.getString('role');
      username = prefs.getString('username');
      print(emailnotfy);
      if(emailnotfy=="0"){
        isSwitched = false;
      }else{
        isSwitched = true;
      }
      if(role == "Admin"){
        isUservisible = true;
      }else{
        isUservisible = false;
      }
    });
    makeUserListApi();
  }


  makeEmailApi() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid'),
      "mail_status":prefs.getString('emailnotify')

    };
    print(formMap);
    ApiService.postcall("app-email-notification", formMap)
        .then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body["data"]);
      if(body["data"] == false) {
        prefs.setString('emailnotify', "0");
      }else{
        prefs.setString('emailnotify', "1");
      }
      getSharedData();
      print("jhjjhjhj");
    });
  }

  makeDeleteAdminApi() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid')
    };
    print(formMap);
    ApiService.postcall("app-delete-admin", formMap)
        .then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body);
      print("jhjjhjhj");

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
    });
  }

  makeDeleteUserApi(String deleteUserid) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid'),
      "deleteUserId": deleteUserid
    };
    print(formMap);
    ApiService.postcall("app-delete-user", formMap)
        .then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body);
      print("jhjjhjhj");
    });
  }

  makeUserListApi() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid'),
      "companyId": prefs.getString('companyid')
    };
    print(formMap);
    ApiService.postcall("app-company-delete-users", formMap)
        .then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body);
      setState(() {
        userList = body["company_users_list"] as List;

        if(userList.length>0){
          isUservisible = true;
        }else{
          isUservisible = false;
        }
      });
      print("jhjjhjhj");
    });
  }



}
