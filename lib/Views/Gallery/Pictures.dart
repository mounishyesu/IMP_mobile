import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pictures extends StatefulWidget {
  final String userId;
  final String companyId;
  const Pictures({Key? key, required this.userId, required this.companyId}) : super(key: key);

  @override
  State<Pictures> createState() => _PicturesState();
}

class _PicturesState extends State<Pictures> {
  List image = [];
  String? noDateFound = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeImagesListApi();
    print(widget.userId);
    print(widget.companyId);
    print('============');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pictures",
            style: TextStyle(
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
    child: Container(
    decoration: new BoxDecoration(
    color: Colors.black87,
    image: DecorationImage(
    image: AssetImage(
    "assets/images/Services_BG.png",
    ),
    fit: BoxFit.fill)),
      child: Card(
        color: Colors.black87,
        child:image.isNotEmpty ? ListView.builder(
            physics: ScrollPhysics(),
            itemCount: image.isEmpty ? 0 : image.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(image[index]["source"].toString(),scale: 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              );
            }) : Container(
          alignment: Alignment.center,
          child: Text(noDateFound.toString(),
            style: TextStyle(
                color: Color(0xFFffab00),
                fontFamily: 'crimson',
                fontSize: 20),
          ),
        ),
        /*SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Image.asset('assets/images/img1.jpg',scale: 1),
              SizedBox(height: 10,),
              Image.asset('assets/images/img1.jpg',scale: 1),
              SizedBox(height: 10,),
              Image.asset('assets/images/img1.jpg',scale: 1),
              SizedBox(height: 10,),
             ],
          ),
        )*/
      ),
      ),
    ));
  }

  makeImagesListApi() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId":widget.userId,
      "companyId": widget.companyId
    };
    print(formMap);
    ApiService.postcall("app-company-pictures", formMap)
        .then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body);
      setState(() {
        image = body["pictures_list"] as List;
        if(image.length == 0){
          noDateFound = "No Records Found";
        }
      });
      print("jhjjhjhj");
    });
  }

}
