import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Views/Login/PreScreen.dart';
import 'package:music_player/Views/Tabs/Tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      _changeOpacity();
    });

    getLoginstatus();
  }

  getLoginstatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getBool('islogin'));
    await Future.delayed(Duration(milliseconds: 1500));
    if (prefs.getBool('islogin') == null || prefs.getBool('islogin') == false) {
      _navigateToPreScreen();
      // print('IF');
    }
    else{
      _navigateToHome();
      // print('ELSE');
    }
  }

  void _navigateToHome() {
    Timer(Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Tabs())));
  }
  void _navigateToPreScreen() {
    Timer(Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PreScreen())));
  }

  @override


  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/Services_BG.png",
                    ),
                    fit: BoxFit.fill)),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: AnimatedOpacity(
                      opacity: opacityLevel,
                      duration: const Duration(seconds: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/imp_logo.png',
                            fit: BoxFit.cover,
                            height: 300,
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
