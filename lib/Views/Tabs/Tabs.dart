import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/Views/SpeedDial/YoutubeVideo.dart';
import 'package:music_player/Views/SpeedDial/bulletInPost.dart';
import 'package:music_player/Views/SpeedDial/pictureUpload.dart';
import 'package:music_player/Views/SpeedDial/songUploadform.dart';
import 'package:music_player/Views/Tabs/BulletIn.dart';
import 'package:music_player/Views/MusicPlayer/Screens/Home/home.dart';
import 'package:music_player/Views/Tabs/Tutorial.dart';
import 'package:music_player/helpers/Utilities.dart';
import 'package:music_player/widgets/AppBar.dart';
import 'package:music_player/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/imagepicker.dart';
import 'Selection.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  PickedFile? _imageFile;
  final String uploadUrl = 'https://api.imgur.com/3/upload';
  final ImagePicker _picker = ImagePicker();
  bool isGuest = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRoledata();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              shadowColor: Color(0xFFffab00),
              // elevation: 3,
              backgroundColor: Colors.black,
              title: Container(
                child: TitleBar(),
              )),
          drawerEnableOpenDragGesture: false,
          drawer: AppDrawer(),
          bottomNavigationBar: menu(),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              BulletIn(),
              HomePage(),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/Services_BG.png",
                        ),
                        fit: BoxFit.fill)),
                child: Image.asset('assets/images/Middle_Icon.png'),
              ),
              Tutorial(),
              Container(
                decoration: new BoxDecoration(
                    color: Colors.black87,
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/Services_BG.png",
                        ),
                        fit: BoxFit.fill)),
                child: GenreSelection(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      height: 60,
      color: Color(0xFF1e2329),
      child: TabBar(
        indicatorColor: Colors.transparent,
        indicator: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "assets/images/Untitled-Artwork-9.png",
          ), /*fit: BoxFit.scaleDown*/
        )),
        tabs: [
          Tab(
            child: Container(
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/Untitled-Artwork-10.png",
                      ),
                      fit: BoxFit.cover)),
              child: Align(
                alignment: Alignment(-0.1, -0.1),
                child: Image.asset(
                  "assets/images/Untitled-Artwork-5.png",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/Untitled-Artwork-10.png",
                      ),
                      fit: BoxFit.cover)),
              child: Align(
                alignment: Alignment(-0.1, -0.1),
                child: Image.asset(
                  "assets/images/Untitled-Artwork-8.png",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
          Tab(
           child: Container(
             child: GestureDetector(
               child: SpeedDial(
                   useRotationAnimation: true,
                   child: Container(
                     decoration: new BoxDecoration(
                         image: DecorationImage(
                             image: AssetImage(
                               "assets/images/Untitled-Artwork-9.png",
                             ),
                             fit: BoxFit.cover)),
                     child: new Icon(
                       Icons.add,
                       size: 50,
                       color: Color(0xFFffab00),
                     ),
                   ),
                   backgroundColor: Color(0xFF1e2329),
                   overlayColor: Colors.transparent,
                   children: [
                     SpeedDialChild(
                       child:
                       const Icon(Icons.music_note, color: Color(0xFFffab00)),
                       label: 'Music',
                       labelStyle: TextStyle(
                         fontFamily: 'Crimson',
                         color: Color(0xFFffab00),
                         fontWeight: FontWeight.bold,
                       ),
                       labelBackgroundColor: Color(0xFF1e2329),
                       backgroundColor: Color(0xFF1e2329),
                       onTap: () {
                         setState(() {
                           if(!isGuest){
                             Utilities.overlayDialog(context);
                           }
                           else{
                             makeStorageIdApicall();
                           }
                         });
                       },
                     ),
                     SpeedDialChild(
                       child: const Icon(Icons.play_arrow_sharp,
                           color: Color(0xFFffab00)),
                       label: 'Youtube Video',
                       labelStyle: TextStyle(
                           fontFamily: 'Crimson',
                           color: Color(0xFFffab00),
                           fontWeight: FontWeight.bold),
                       labelBackgroundColor: Color(0xFF1e2329),
                       backgroundColor: Color(0xFF1e2329),
                       onTap: () {
                           setState(() {
                             if(!isGuest){
                               Utilities.overlayDialog(context);
                             }
                             else{
                               Navigator.push(context,
                                   MaterialPageRoute(builder: (context) => YoutubeUploadForm()));
                             }
                           });
                       },
                     ),
                     SpeedDialChild(
                       child: Icon(Icons.camera_alt, color: Color(0xFFffab00)),
                       label: 'Pictures',
                       labelStyle: TextStyle(
                           fontFamily: 'Crimson',
                           color: Color(0xFFffab00),
                           fontWeight: FontWeight.bold),
                       labelBackgroundColor: Color(0xFF1e2329),
                       backgroundColor: Color(0xFF1e2329),
                       onTap: () {
                         setState(() {
                           if(!isGuest){
                             Utilities.overlayDialog(context);
                           }
                           else{
                             Navigator.push(context,
                                 MaterialPageRoute(builder: (context) => PictureUploadForm()));
                           }
                         });
                       },
                     ),
                     SpeedDialChild(
                       child: const Icon(Icons.edit, color: Color(0xFFffab00)),
                       label: 'Bulletin Post',
                       labelStyle: TextStyle(
                           fontFamily: 'Crimson',
                           color: Color(0xFFffab00),
                           fontWeight: FontWeight.bold),
                       labelBackgroundColor: Color(0xFF1e2329),
                       backgroundColor: Color(0xFF1e2329),
                       onTap: () {
                         setState(() {
                           if(!isGuest){
                             Utilities.overlayDialog(context);
                           }
                           else{
                             Navigator.push(context,
                                 MaterialPageRoute(builder: (context) => BulletInPost()));
                           }
                         });
                       },
                     ),
                   ]),
             ),
           ),),
          Tab(
            // text: "Bulletin",
            child: Container(
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/Untitled-Artwork-10.png",
                      ),
                      fit: BoxFit.cover)),
              child: Align(
                alignment: Alignment(-0.1, -0.1),
                child: Image.asset(
                  "assets/images/Untitled-Artwork-7.png",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/Untitled-Artwork-10.png",
                      ),
                      fit: BoxFit.cover)),
              child: Align(
                alignment: Alignment(-0.1, -0.1),
                child: Image.asset(
                  "assets/images/Untitled-Artwork-4.png",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future<String?> uploadImage(filepath, url) async {
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.files.add(await http.MultipartFile.fromPath('image', filepath));
  //   var res = await request.send();
  //   return res.reasonPhrase;
  // }

  Future<void> retriveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file!;
      });
    } else {
      print('Retrieve error ' + response.exception!.code);
    }
  }

  getRoledata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if(prefs.getString('role') == "Guest"){
        isGuest = false;
        print("IF+Mounish");
      }else{
        isGuest = true;
        print("ELSE+Mounish");
      }
    });
  }

  makeStorageIdApicall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid'),
    };
    print(formMap);
    ApiService.postcall("app-music-storage-id", formMap).then((success) async {
      final body = json.decode(success);
      print("data////");

      print(body["storageId"]);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SongUploadForm(storageId: body["storageId"].toString(),)));
    });

  }

}
