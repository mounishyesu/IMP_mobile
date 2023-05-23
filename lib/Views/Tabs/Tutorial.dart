import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/Views/Tabs/TutorialDetail.dart';
import 'package:music_player/helpers/Utilities.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key}) : super(key: key);

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {

  List tutorialList = [];

  String? baseurl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeTutorialApicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Services_BG.png",
                ),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'TUTORIAL',
                    style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Color(0xFFffab00),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                      color: Colors.transparent,
                      child: GridView.count(
                        physics: ScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 30,
                          children: List.generate(tutorialList.length, (index) {
                            return Center(
                              child: SelectCard(
                                pluginImage: baseurl! +
                                    tutorialList[index]["tutorial_image"].toString(),
                                pluginName: tutorialList[index]["tutorial_name"].toString(), tutorialId:tutorialList[index]["id"].toString(),
                              ),
                            );
                          }))))
            ],
          ),
        ),
      ),
    );
  }

  makeTutorialApicall() async {
    Timer.periodic(const Duration(seconds: 3), (t) {
      Navigator.pop(context);
      t.cancel(); //stops the timer
    });
    ApiService.getcall("app-tutorials-list")
        .then((success) async {
      final body =
      json.decode(success);
      Utilities.displayDialog(context);
      print("response====================================");

      print(body["tutorials_list"][0]["tutorial_name"].toString());
      setState(() {
        tutorialList = body["tutorials_list"] as List;

        baseurl = body["tutorials_image_path"].toString();
      });
    });
  }
}
class SelectCard extends StatelessWidget {
  const SelectCard({required this.pluginImage, required this.pluginName, required this.tutorialId}) : super();
  final String pluginImage;
  final String pluginName;
  final String tutorialId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Tutorial_Details(id: tutorialId,Title: pluginName,)));
          print('ONTAP');
          },
        child: Container(
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Container(
                            height: 700,
                            width: 700,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: NetworkImage(pluginImage),
                                    fit: BoxFit.fill,
                                )
                                // shape: BoxShape.circle
                            ),
                            // child: Image.network(pluginImage,height: 800,width: 800,),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(pluginName,textAlign: TextAlign.center,style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Crimson',
                                  color: Color(0xFFffab00),
                                  fontWeight: FontWeight.bold,
                                ),),
                              ],
                            ),
                          ),)),
                  ]),
            )));
  }
}

