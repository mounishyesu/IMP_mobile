import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../Apiservice/restApi.dart';

class Tutorial_Details extends StatefulWidget {
  final String id;
  final  String Title;
  const Tutorial_Details({Key? key, required this.id, required this.Title}) : super(key: key);

  @override
  State<Tutorial_Details> createState() => _Tutorial_DetailsState();
}

class _Tutorial_DetailsState extends State<Tutorial_Details> {
  String? baseUrl;
  String? selfImage;
  String? noDateFound = "";
  List Selection = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeTutorialPostApicall();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    print("post id/////////////////");
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.Title,style: TextStyle(
              fontFamily: 'Crimson',
              color: Color(0xFFffab00),
              fontSize: 15),
          ),
          centerTitle: true,
        backgroundColor: Colors.black,
        leading: Row(
          children: [
            SizedBox(
              width: 8,
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFFffab00),
                size: 20,
              ),
            ),
          ],
        ),
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
        child:Selection.isNotEmpty ? ListView.builder(
            itemCount: Selection.length,
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
                            Text(Selection[index]["tutorial_title"].toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Crimson',
                                  color: Color(0xFFffab00),
                                  fontWeight: FontWeight.bold,
                                )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Html(
                          data: Selection[index]["tutorial_description"]
                              .toString(),
                          style: {
                            "body": Style(
                              color: Colors.white70,
                              fontFamily: 'crimson',
                              fontSize: FontSize(16),
                            ),
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        child: Selection[index]["tutorial_image"].toString() ==
                                null
                            ? Container()
                            : Image.network(baseUrl.toString() +
                                Selection[index]["tutorial_image"].toString()),
                      ),
                    ],
                  ),
                ),
              );
            },) : Container(
          alignment: Alignment.center,
              child: Text(noDateFound.toString(),
          style: TextStyle(
                color: Color(0xFFffab00),
                fontFamily: 'crimson',
                fontSize: 20),
        ),
            ),),
    );
  }

  makeTutorialPostApicall() async {
    Map<String, dynamic> formMap = {
      "tutorial_id": widget.id,
    };
    ApiService.postcall("app-tutorial-posts", formMap).then((success) async {
      final body = json.decode(success);
      print("response====================================");
      setState(() {
        Selection = body["data"] as List;
        baseUrl = body["tutorials_image_path"].toString();
        if(Selection.length == 0){
          noDateFound = "No Records Found";
        }
      });
      print(body["tutorials_image_path"] + body["data"][0]["tutorial_image"]);
      print(body["self_company"]["c_name"].toString());
      print(Title);
      print(body);
      print("mounish");
    });
  }
}
