import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  List privacyList = [];
  String? noDataFound = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makePrivacyApicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy",style: TextStyle(
            fontFamily: 'Crimson',
            color: Colors.black87,
            fontSize: 15),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFffab00),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Services_BG.png",
                ),
                fit: BoxFit.fill)),
        child:privacyList.isNotEmpty ? ListView.builder(
          itemCount: privacyList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child:
                      Text(privacyList[index]["title"].toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Crimson',
                            color: Color(0xFFffab00),
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                      child: Text(privacyList[index]["content"].toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Crimson',
                            color: Color(0xFFffffff),
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            );
          },) : Container(
          alignment: Alignment.center,
          child: Text(noDataFound.toString(),
            style: TextStyle(
                color: Color(0xFFffab00),
                fontFamily: 'crimson',
                fontSize: 20),
          ),
        ),),
    );
  }

  makePrivacyApicall() async {
    ApiService.getcall("app-privacy").then((success) async {
      final body = json.decode(success);
      print("response====================================");
      setState(() {
        privacyList = body["privacy_list"] as List;
        if(privacyList.length == 0){
          noDataFound = "No Records Found";
        }
      });
      print(body["about_list"][0]["title"]);
      print(body["about_list"][0]["content"]);
      print(body);
      print("sarma");
    });
  }
}
