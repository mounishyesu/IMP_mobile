import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/Views/Login/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'InnerServicePage.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  List services = [];
  String? noDataFound = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeServicesApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Services",
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
        child: services.isNotEmpty ? Container(
          child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: 300,
                        child: Padding(
                          padding:  EdgeInsets.all(10),
                          child: TextButton(
                            // padding: EdgeInsets.all(10),
                            // color: Color(0xFF2c2924),
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            //   side: BorderSide(color: Color(0xFFffab00)),
                            // ),
                            child: Text(services[index]['service_name'].toString(),
                                style: TextStyle(
                                    fontFamily: 'Crimson',
                                    color: Color(0xFFffab00),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            onPressed: () {
                              setState(() {
                                // for(int i = 0;i<services.length;i++){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => InnerService(serviceid: services[index]['service_id'].toString(),serviceName: services[index]['service_name'].toString())));
                                // }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })
        ): Container(
          alignment: Alignment.center,
          child: Text(noDataFound.toString(),
            style: TextStyle(
                color: Color(0xFFffab00),
                fontFamily: 'crimson',
                fontSize: 20),
          ),
        ),
      ),
    );
  }


  makeServicesApiCall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid'),
    };
    ApiService.postcall("app-services", formMap).then((success) async {
      final body = json.decode(success);
      print("response====================================");
      setState(() {
        services = body["services_list"] as List;
        if(services.length == 0){
          noDataFound = "No Records Found";
        }
      });
      print(body["services_list"][0]["service_name"]);
      print(body);
      print("sarma");
    });
  }

}
