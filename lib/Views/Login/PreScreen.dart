import 'package:flutter/material.dart';

import 'Login.dart';
import 'Sign_Up.dart';

class PreScreen extends StatefulWidget {
  const PreScreen({Key? key}) : super(key: key);

  @override
  State<PreScreen> createState() => _PreScreenState();
}

class _PreScreenState extends State<PreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child:Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/images/imp_logo.png",
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.25,
              ),
              Container(
                width: 125,
                // padding: EdgeInsets.only(left: 5,right: 5),
                child: TextButton(
                  // color: Color(0xFF2c2924),
                  // color:Colors.yellow.shade500,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  //   side: BorderSide(color: Color(0xFFffab00)),
                  // ),
                  child: Text("SING UP",
                      style: TextStyle(
                          fontFamily: 'Crimson',
                          color: Color(0xFFffab00),
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        Sign_Up()), (Route<dynamic> route) => false);
                    }
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: 125,
                // padding: EdgeInsets.only(left: 5,right: 5),
                child: TextButton(
                  // color: Color(0xFF2c2924),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  //   side: BorderSide(color: Color(0xFFffab00)),
                  // ),
                  child: Text("LOGIN",
                      style: TextStyle(
                          fontFamily: 'Crimson',
                          color: Color(0xFFffab00),
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        Login()), (Route<dynamic> route) => false);
                  },
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
