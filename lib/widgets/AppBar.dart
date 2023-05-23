import 'package:flutter/material.dart';
import 'package:music_player/Views/Chat/Chat_Screen.dart';
import 'package:music_player/Views/Profile/Profile.dart';
import 'package:music_player/widgets/SearchFilter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Views/companyPage.dart';
import 'Notifications.dart';

class TitleBar extends StatefulWidget {
  const TitleBar({Key? key}) : super(key: key);

  @override
  _TitleBarState createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  bool isGuest = false;
  String? proImage;
  String? companyImage;
  String? companyId;
  String? userid;


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
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        SizedBox(
          width: 5,
        ),
        SizedBox(
          width: 230,
          child: Row(
            children: [
              Visibility(
                visible: isGuest,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CompanyPage()),
                    );
                  },
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/Badge.png"),
                            fit: BoxFit.contain),
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                const Radius.circular(180.0)),
                            // shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(companyImage.toString(),),
                            backgroundColor: Colors.transparent,
                          )),),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile(selectedCompanyId: companyId.toString(),userId: userid.toString())),
                  );
                },
                child:  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          const Radius.circular(180.0)),
                      // shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(proImage.toString(),),
                      backgroundColor: Colors.transparent,
                    ))
              ),
            ],
          ),
        ),
        SizedBox(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchFilter()));
                },
                child: Icon(
                  Icons.search_outlined,
                  color: Color(0xFFffab00),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
                child: Icon(
                  Icons.chat_bubble_outline_sharp,
                  color: Color(0xFFffab00),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationsPage()),
                  );
                },
                child: Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFFffab00),
                ),
              ),
              Container(
                child: Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Color(0xFFffab00),
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
  getRoledata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    proImage = prefs.getString("profileimage");
    companyImage = prefs.getString("companylogo");
    print(proImage);
    companyId = prefs.getString("companyid");
    userid = prefs.getString("userid");
    print(userid);
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
