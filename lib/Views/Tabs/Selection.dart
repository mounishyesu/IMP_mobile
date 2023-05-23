import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/NonEditableCompanyPage.dart';
import 'package:music_player/Views/companyPage.dart';
import 'package:music_player/helpers/Utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenreSelection extends StatefulWidget {
  const GenreSelection({Key? key}) : super(key: key);

  @override
  _GenreSelectionState createState() => _GenreSelectionState();
}

class _GenreSelectionState extends State<GenreSelection> {
  String dropdownvalue1 = 'Genre';
  String dropdownvalue2 = 'City';
  var genre = [
    'Genre',
    'Hip-Hop/Rap',
    'Pop',
    'Rnb/Blues',
    'Classical',
    'Folk/Regional',
  ];
  var city = [
    'City',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  List Selection = [];
  String? selfImage;
  String? baseUrl = " ";
  bool isGuest = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeTutorialApicall();
    getRoledata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
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
                  margin: EdgeInsets.only(
                    left: 50,
                    top: 30,
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          border: Border.all(
                            color: Color(0xFFffab00).withOpacity(0.4),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 15,
                        ),
                        width: 150,
                        height: 40,
                        child: DropdownButton(
                          isExpanded: true,
                          underline: DropdownButtonHideUnderline(
                            child: Container(),
                          ),
                          dropdownColor: Colors.black.withOpacity(0.8),
                          iconSize: 20,
                          iconDisabledColor: Colors.white,
                          iconEnabledColor: Colors.white,
                          value: dropdownvalue1,
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: Color(0xFFffab00)),
                          items: genre.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items,
                                  style: TextStyle(
                                    fontFamily: 'Crimson',
                                    color: Color(0xFFffab00).withOpacity(0.4),
                                  )),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue1 = newValue.toString();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFffab00).withOpacity(0.4),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
                        width: 150,
                        height: 40,
                        child: TextField(
                          style: TextStyle(color: Colors.white70),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 50,
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFffab00).withOpacity(0.4),
                              ),
                            ),
                            hintText: "City",
                            hintStyle: TextStyle(
                                fontFamily: 'Crimson',
                                color: Color(0xFFffab00).withOpacity(0.4),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Visibility(
                  visible: isGuest,
                  child: Container(
                      height: 150,
                      width: 150,
                      child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child:
                          SelectCard(
                            pluginImage: selfImage.toString(),c_name: "", hideImage: true, hideText: false, cId: '', nonCId: false, userId: '',
                          ),)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 500,
                    width: 350,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child:GridView.count(
                      shrinkWrap: true,
                            physics: ScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 50,
                            mainAxisSpacing: 30,
                            children: List.generate(Selection.length, (index) {
                              if(Selection[index]["Company_Logo"].toString() == "null"){
                                return Center(
                                  child: SelectCard(
                                    pluginImage: baseUrl.toString() +
                                        Selection[index]["Company_Logo"].toString(),c_name: Selection[index]["c_name"].toString(), hideImage: false, hideText: true, cId: Selection[index]["id"].toString(), nonCId: true, userId: Selection[index]["userid"].toString(),
                                  ),
                                );

                              }else{
                                return Center(
                                  child: SelectCard(
                                    pluginImage: baseUrl.toString() +
                                        Selection[index]["Company_Logo"].toString(),c_name: Selection[index]["c_name"].toString(), hideImage: true, hideText: false,cId: Selection[index]["id"].toString(), nonCId: true, userId: Selection[index]["userid"].toString(),
                                  ),
                                );

                              }
                            })))
              ],
            ),
          ),
        ),
    );
  }

  makeTutorialApicall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Utilities.displayDialog(context);
    Map<String, dynamic> formMap = {
      "company_id": prefs.getString('companyid'),
      "role": prefs.getString('role'),
    };
    Timer.periodic(const Duration(seconds: 2), (t) {
      Navigator.pop(context);
      t.cancel(); //stops the timer
    });
    ApiService.postcall("app-league", formMap).then((success) async {
      final body = json.decode(success);
      print("response====================================");
      setState(() {
        Selection = body["league_list"] as List;
        baseUrl = body["company_logo_path"].toString();
        if(isGuest) {
          selfImage =
              baseUrl.toString() + body["self_company"]["Company_Logo"].toString();
        }else{
          selfImage="";
        }
      });
      // print(body["company_logo_path"] + body["league_list"][0]["Company_Logo"]);
      // print(body["self_company"]["c_name"].toString());
      print(Selection);
      print("mounish");
    });
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
}

class SelectCard extends StatelessWidget {
   SelectCard({required this.pluginImage,required this.c_name,required this.hideImage,required this.hideText, required this.cId, required this.nonCId, required this.userId}) : super();
  final String pluginImage;
  final String c_name;
  final String cId;
  final String userId;
  final bool nonCId;
 bool hideImage = false;
 bool hideText = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if(nonCId == false) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CompanyPage()),
            );
          }else{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NoEditCompanyPage(
                userId: userId,companyId: cId,
              )),
            );
          }
        },
        child: Center(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: hideImage,
              child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
          image: DecorationImage(
                image: AssetImage("assets/images/Badge.png"),
                fit: BoxFit.cover),
        ),
              alignment: Alignment.center,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        const Radius.circular(180.0)),
                    // shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 110,
                    width: 110,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(pluginImage.toString(),),
                      backgroundColor: Colors.transparent,
                    ),
                  )),
               )),
            ),
            Visibility(
              visible: hideText,
              child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
          image: DecorationImage(
                image: AssetImage("assets/images/Badge.png"),
                fit: BoxFit.cover),
        ),
              alignment: Alignment.center,
              child: AutoSizeText(c_name,
                textAlign: TextAlign.center,
                maxLines: null,
                style: TextStyle(
                            fontFamily: 'Crimson',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),),)),
            ),
          ]),
        ));
  }
}
