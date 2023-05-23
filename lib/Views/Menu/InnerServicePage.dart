import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InnerService extends StatefulWidget {
  final String serviceid;
  final String serviceName;
  const InnerService({Key? key, required this.serviceid,required this.serviceName}) : super(key: key);

  @override
  State<InnerService> createState() => _InnerServiceState();
}

class _InnerServiceState extends State<InnerService> {
  TextEditingController messageSubject = TextEditingController();
  TextEditingController sentMessage = TextEditingController();
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
          widget.serviceName,
          style: TextStyle(
              fontFamily: 'Crimson', color: Colors.black87, fontSize: 22),
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
          child: services.isNotEmpty ? ListView.builder(
            itemCount: services.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: Card(
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(services[index]['category_name'].toString(),
                          style: TextStyle(
                              fontFamily: 'Crimson',
                              color: Color(0xFFffab00),
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                          services[index]['category_description'].toString(),
                          style: TextStyle(
                            fontFamily: 'Crimson',
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, right: 20,bottom: 20),
                      alignment: Alignment.topRight,
                      child: TextButton(
                        // padding: EdgeInsets.all(10),
                        // color: Color(0xFF2c2924),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        //   side: BorderSide(color: Color(0xFFffab00)),
                        // ),
                        child: Text('Enquiry',
                            style: TextStyle(
                                fontFamily: 'Crimson',
                                color: Color(0xFFffab00),
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        onPressed: () {
                          messageSubject.text = services[index]['category_name'].toString();
                            _showDialog(context);
                        },
                      ),
                    ),
                  ]),
                ),
              );
            },
          ) : Container(
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

  _showDialog(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "To:" + "Support",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'crimson',
                          color: Colors.black38),
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
                                    child: TextFormField(
                                      maxLines: 2,
                                      controller: messageSubject,
                                      style: TextStyle(
                                          fontFamily: 'crimson',
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        hintText: 'Subject',
                                        contentPadding: EdgeInsets.only(
                                          left: 25,top: 11
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (val){
                                        messageSubject.text = val;
                                      },
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
                                    child: TextFormField(
                                      maxLines: 5,
                                      controller: sentMessage,
                                      style: TextStyle(
                                          fontFamily: 'crimson',
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        hintText: 'Message...',
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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 50),
                                          child: TextButton(
                                            // color: Color(0xFFffab00),
                                            child: Text(
                                              "Send",
                                              style: TextStyle(
                                                  fontFamily: 'crimson',
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            onPressed: () {

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
  makeServicesApiCall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid'),
      "serviceId": widget.serviceid,
    };

    print(formMap);
    ApiService.postcall("app-services-categories", formMap).then((success) async {
      final body = json.decode(success);
      print("response====================================");
      setState(() {
        services = body["services_categories"] as List;
        if(services.length == 0){
          noDataFound = "No Records Found";
        }
      });
      print(body["services_list"][0]["category_name"]);
      print(body["services_list"][0]["category_description"]);
      print(body);
      print("sarma");
    });
  }

}