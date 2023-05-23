import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Albums extends StatefulWidget {
  final String userId;
  final String companyId;
  const Albums({Key? key, required this.userId, required this.companyId}) : super(key: key);

  @override
  State<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {

  List albumsList = [];
  String? noDateFound = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeAlbumsListApi();
    print(widget.userId);
    print(widget.companyId);
    print('============');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Albums",
            style: TextStyle(
                fontFamily: 'Crimson', color: Colors.black87, fontSize: 15),
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
            child: albumsList.isNotEmpty ? Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                  ),
                    itemCount: albumsList.isEmpty ? 0 : albumsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Image.network(albumsList[index]['source'].toString(),fit: BoxFit.fill,height: 130,width: 130,),
                            Container(
                              child: Text(
                                albumsList[index]["title"].toString(),
                                style: TextStyle(
                                  fontFamily: 'Crimson',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    albumsList[index]["applaud"].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    albumsList[index]["played"].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
            ) : Container(
              alignment: Alignment.center,
              child: Text(noDateFound.toString(),
                style: TextStyle(
                    color: Color(0xFFffab00),
                    fontFamily: 'crimson',
                    fontSize: 20),
              ),
            ),
            ),
          ),
        );
    /*Column(children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/alb_11.png",
                              width: 150,
                              height: 150,
                            ),
                            Container(
                              child: Text(
                                "Nirvana...",
                                style: TextStyle(
                                  fontFamily: 'Crimson',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/alb_10.png",
                              width: 150,
                              height: 150,
                            ),
                            Container(
                              child: Text(
                                "Guns Roses...",
                                style: TextStyle(
                                  fontFamily: 'Crimson',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/alb_9.png",
                              width: 150,
                              height: 150,
                            ),
                            Container(
                              child: Text(
                                "Nirvana...",
                                style: TextStyle(
                                  fontFamily: 'Crimson',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/alb_8.png",
                              width: 150,
                              height: 150,
                            ),
                            Container(
                              child: Text(
                                "Guns Roses...",
                                style: TextStyle(
                                  fontFamily: 'Crimson',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/alb_11.png",
                              width: 150,
                              height: 150,
                            ),
                            Container(
                              child: Text(
                                "Nirvana...",
                                style: TextStyle(
                                  fontFamily: 'Crimson',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/alb_10.png",
                              width: 150,
                              height: 150,
                            ),
                            Container(
                              child: Text(
                                "Guns Roses...",
                                style: TextStyle(
                                  fontFamily: 'Crimson',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/alb_9.png",
                              width: 150,
                              height: 150,
                            ),
                            Container(
                              child: Text(
                                "Nirvana...",
                                style: TextStyle(
                                  fontFamily: 'Crimson',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/alb_8.png",
                              width: 150,
                              height: 150,
                            ),
                            Container(
                              child: Text(
                                "Guns Roses...",
                                style: TextStyle(
                                  fontFamily: 'Crimson',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "123",
                                    style: TextStyle(
                                      fontFamily: 'Crimson',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ])*/
  }


  makeAlbumsListApi() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": widget.userId,
      "companyId": widget.companyId
    };
    print(formMap);
    ApiService.postcall("app-company-albums", formMap)
        .then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body);
      setState(() {
        albumsList = body["albums_list"] as List;
        if(albumsList.length == 0){
          noDateFound = "No Records Found";
        }
      });
      print("jhjjhjhj");
    });
  }
}
