import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/Apiservice/restApi.dart';
import 'package:music_player/Views/companyPage.dart';
import 'package:music_player/helpers/Utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyLocation extends StatefulWidget {
  const CompanyLocation({Key? key, required this.Country, required this.State, required this.City, required this.email, required this.mobNumber}) : super(key: key);
  final String Country;
  final String State;
  final String City;
  final String email;
  final String mobNumber;
  @override
  _CompanyLocationState createState() => _CompanyLocationState();
}

class _CompanyLocationState extends State<CompanyLocation> {
  List designation_one = [];
  List infoUpdate = [];
  String? countryValue;
  String? industryLocaton;
  String? companyNumber;
  String? companyMail;
  String? industryName;
  String? stateValue;
  String? cityValue;
  String? countryId;
  String? stateId;
  String? cityId;
  List countryList = [];
  List cityList = [];
  List stateList = [];
  String? desig1Value;
  String? desig1Id;
  List companyList = [];
  List companyTeamsList = [];
  List companyServicesList = [];
  String? companyImage;
  String? companyName = " ";
  String? companyDescription = "";
  bool isGuest = false;
  String services1Display = "";
  String services2Display = "";
  String services3Display = "";
  String services4Display = "";
  String services5Display = "";
  String services6Display = "";
  String coverImage = "assets/images/img1.jpg";
  TextEditingController web2visual = TextEditingController();
  TextEditingController companyDescriptionEdit = TextEditingController();
  TextEditingController service1 = TextEditingController();
  TextEditingController service2 = TextEditingController();
  TextEditingController service3 = TextEditingController();
  TextEditingController service4 = TextEditingController();
  TextEditingController service5 = TextEditingController();
  TextEditingController service6 = TextEditingController();
  TextEditingController infoEmail = TextEditingController();
  TextEditingController infoMobnum = TextEditingController();
  TextEditingController infoPageurl = TextEditingController();
  TextEditingController infoAlbumurl = TextEditingController();
  TextEditingController faceBook = TextEditingController();
  TextEditingController instaGram = TextEditingController();
  TextEditingController linkedIn = TextEditingController();
String? selectedCountry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeCountry();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      selectedCountry = widget.Country;
    });

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Services_BG.png",
                ),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 70,),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 50),
                  child: const Text('Company Information Update',
                      style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.white,
                        fontSize: 20
                      )),
                ),
                const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black12,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 15,
              ),
              width: 300,
              height: 50,
              child: DropdownButton(
                hint: Text("--Select Industry--"),
                isExpanded: true,
                underline: DropdownButtonHideUnderline(
                  child: Container(),
                ),
                dropdownColor: Colors.white,
                iconSize: 20,
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                items: designation_one.map((item) {
                  return new DropdownMenuItem(
                    child: Text(item['name'].toString(),
                        style: TextStyle(
                          fontFamily: 'Crimson',
                          color: Colors.black,
                        )),
                    value: item['name'],
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (value) {
                  setState(() {
                    desig1Value = value.toString();
                    print(desig1Value);
                    print(".........");
                    for (int i = 0; i < designation_one.length; i++) {
                      if (value == designation_one[i]['name']) {
                        desig1Id = designation_one[i]['id'].toString();
                      }
                    }
                    print(desig1Id);
                    print("////id////");
                  });
                },
                value: desig1Value,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black12,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 15,
              ),
              width: 300,
              height: 50,
              child: DropdownButton(
                hint: Text(widget.Country),
                isExpanded: true,
                underline: DropdownButtonHideUnderline(
                  child: Container(),
                ),
                dropdownColor: Colors.white,
                iconSize: 20,
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                items: countryList.map((item) {
                  return new DropdownMenuItem(
                    child: Text(item['name'].toString(),
                        style: TextStyle(
                          fontFamily: 'Crimson',
                          color: Colors.black,
                        )),
                    value: item['name'],
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (value) {
                  setState(() {
                    countryValue = value.toString();
                    print(countryValue);
                    print(".........");
                    for (int i = 0; i < countryList.length; i++) {
                      if (value == countryList[i]['name']) {
                        countryId = countryList[i]['id'].toString();
                      }
                    }
                    stateList = [];
                    makeStatesAPicall();
                    print(countryId);
                    print("////id////");
                  });
                },
                value: countryValue,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black12,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 15,
              ),
              width: 300,
              height: 50,
              child: DropdownButton(
                hint: Text(widget.State),
                isExpanded: true,
                underline: DropdownButtonHideUnderline(
                  child: Container(),
                ),
                dropdownColor: Colors.white,
                iconSize: 20,
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                items: stateList.map((item) {
                  return new DropdownMenuItem(
                    child: Text(item['name'].toString(),
                        style: TextStyle(
                          fontFamily: 'Crimson',
                          color: Colors.black,
                        )),
                    value: item['name'],
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (value) {
                  setState(() {
                    stateValue = value.toString();
                    print(stateValue);
                    print(".........");
                    for (int i = 0; i < stateList.length; i++) {
                      if (value == stateList[i]['name']) {
                        stateId = stateList[i]['id'].toString();
                      }
                    }
                    cityList = [];
                    print(stateId);
                    makeCityAPicall();
                    print("////id////");
                  });
                },
                value: stateValue,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black12,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 15,
              ),
              width: 300,
              height: 50,
              child: DropdownButton(
                hint: Text(widget.City),
                isExpanded: true,
                underline: DropdownButtonHideUnderline(
                  child: Container(),
                ),
                dropdownColor: Colors.white,
                iconSize: 20,
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                items: cityList.map((item) {
                  return new DropdownMenuItem(
                    child: Text(item['name'].toString(),
                        style: TextStyle(
                          fontFamily: 'Crimson',
                          color: Colors.black,
                        )),
                    value: item['name'],
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (value) {
                  setState(() {
                    cityValue = value.toString();
                    print(cityValue);
                    print(".........");
                    for (int i = 0; i < cityList.length; i++) {
                      if (value == cityList[i]['name']) {
                        cityId = cityList[i]['id'].toString();
                      }
                    }
                    print(cityId);
                    print("////id////");
                  });
                },
                value: cityValue,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white70,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
              width: 300,
              height: 50,
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: infoMobnum,
                style:
                    TextStyle(fontFamily: 'crimson', color: Colors.white70),
                decoration: InputDecoration(
                  hintText: widget.mobNumber,
                  hintStyle: TextStyle(fontFamily: 'crimson', color: Colors.white70),
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
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white70,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
              width: 300,
              height: 50,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: infoEmail,
                style:
                    TextStyle(fontFamily: 'crimson', color: Colors.white70),
                decoration: InputDecoration(
                  hintText:  widget.email,
                  hintStyle: TextStyle(fontFamily: 'crimson', color: Colors.white70),
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
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white70,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
              width: 300,
              height: 50,
              child: TextField(
                controller: infoPageurl,
                style:
                    TextStyle(fontFamily: 'crimson', color: Colors.white70),
                decoration: InputDecoration(
                  hintText: 'Page Url',
                  hintStyle: TextStyle(fontFamily: 'crimson', color: Colors.white70),
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
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white70,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
              width: 300,
              height: 50,
              child: TextField(
                controller: infoAlbumurl,
                style:
                    TextStyle(fontFamily: 'crimson', color: Colors.white70),
                decoration: InputDecoration(
                  hintText: 'Album Link',
                  hintStyle: TextStyle(fontFamily: 'crimson', color: Colors.white70),
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
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white70,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
              width: 300,
              height: 50,
              child: TextField(
                controller: faceBook,
                style:
                    TextStyle(fontFamily: 'crimson', color: Colors.white70),
                decoration: InputDecoration(
                  hintText: 'Facebook',
                  hintStyle: TextStyle(fontFamily: 'crimson', color: Colors.white70),
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
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white70,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
              width: 300,
              height: 50,
              child: TextField(
                controller: instaGram,
                style:
                    TextStyle(fontFamily: 'crimson', color: Colors.white70),
                decoration: InputDecoration(
                  hintText: 'Instagram',
                  hintStyle: TextStyle(fontFamily: 'crimson', color: Colors.white70),
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
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white70,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
              width: 300,
              height: 50,
              child: TextField(
                controller: linkedIn,
                style:
                    TextStyle(fontFamily: 'crimson', color: Colors.white70),
                decoration: InputDecoration(
                  hintText: 'Linkedin',
                  hintStyle: TextStyle(fontFamily: 'crimson', color: Colors.white70),
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
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 50),
                    child: TextButton(
                      // color: Color(0xFFffab00),
                      child: Text(
                        "Update",
                        style: TextStyle(
                            fontFamily: 'crimson',
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      onPressed: () {
                        setState(() {
                          makeCompanyInfoUpdateAPicall();
                        });
                        Navigator.pop(context);
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
            ),
          ),
        ),
      ),
    );
  }

  makeCompanyInfoUpdateAPicall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formMap = {
      "user_id": prefs.getString('userid'),
      "company_id": prefs.getString('companyid'),
      "Industry_Type": "101",
      "countryid": countryId.toString(),
      "state_id": stateId.toString(),
      "city_id": cityId.toString(),
      "Company_Email": infoEmail.text.toString(),
      "Company_Contact": infoMobnum.text.toString(),
      "Facebook": faceBook.text.toString(),
      "Instagram": instaGram.text.toString(),
      "Linkedin": linkedIn.text.toString(),
    };
    print(formMap);
    ApiService.postcall("app-company-contact-update", formMap)
        .then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body);
      setState(() {
        infoUpdate = body["data"] as List;
        companyNumber = infoMobnum.text.toString();
        companyMail = infoEmail.text.toString();
        industryLocaton = countryValue.toString();
      });
      Utilities.showAlert(context, body["message"].toString());
      print(infoUpdate);
      print("jhjjhjhj");
    });
  }

  makeCountry() async {
    ApiService.getcall("app-country-list").then((success) async {
      final body = json.decode(success);
      setState(() {
        countryList = body["countries_list"] as List;
      });
      print("response====================================");
      print(body["countries_list"][0]["name"]);
      print(designation_one);
    });
  }

  makeStatesAPicall() async {
    Map<String, dynamic> formMap = {
      "country_id": countryId,
    };
    print(formMap);
    ApiService.postcall("app-state-list", formMap).then((success) async {
      final body = json.decode(success);
      print("data////");

      print(body);
      setState(() {
        stateList = body["data"] as List;
      });
      print(stateList);
      print("jhjjhjhj");
    });
  }

  makeCityAPicall() async {
    Map<String, dynamic> formMap = {
      "country_id": countryId,
      "state_id": stateId,
    };
    print(formMap);
    ApiService.postcall("app-citis-list", formMap).then((success) async {
      final body = json.decode(success);
      print("data////");

      print(body);
      setState(() {
        cityList = body["data"] as List;
      });
      print(cityList);
      print("jhjjhjhj");
    });
  }
}
