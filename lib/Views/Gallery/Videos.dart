import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Videos extends StatefulWidget {
  final String userId;
  final String companyId;
  const Videos({Key? key, required this.userId, required this.companyId}) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  List videosList = [];
  late YoutubePlayerController _controller;
  String? noDateFound = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeAlbumsListApi();
    print(widget.userId);
    print(widget.companyId);
    print('============');
    _controller = YoutubePlayerController(
        initialVideoId: " ",
        flags: YoutubePlayerFlags(
            autoPlay: false, loop: true, useHybridComposition: false));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Videos",
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
              child:videosList.isNotEmpty ? ListView.builder(
                itemCount: videosList.length,
                itemBuilder: (BuildContext context, int index) {

                    _controller = YoutubePlayerController(
                        initialVideoId: videosList[index]["source"].toString(),
                        flags: YoutubePlayerFlags(
                            autoPlay: false,
                            loop: true,
                            useHybridComposition: false));

                  return Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Card(
                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Column(
                                children: [
                                  SizedBox(
                                width: 700,
                                height: 220,
                                child: Card(
                                  color: Colors.transparent,
                                  child: YoutubePlayer(
                                    controller: _controller,
                                    showVideoProgressIndicator: true,
                                  ),
                                ),
                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                  );
                },
              ) :  Container(
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
        ));
  }


  makeAlbumsListApi() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": widget.userId,
      "companyId": widget.companyId
    };
    print(formMap);
    ApiService.postcall("app-company-videos", formMap)
        .then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body);
      setState(() {
        videosList = body["videos_list"] as List;
        if(videosList.length == 0){
          noDateFound = "No Records Found";
        }
      });
      print("jhjjhjhj");
    });
  }
}
