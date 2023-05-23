import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Views/Tabs/Tabs.dart';

class Utilities {
  static List songDetails =[];
  static void showAlert(
    BuildContext context,
    String text,
  ) {
    var alert = new AlertDialog(
      backgroundColor: Colors.black87,
      content: Container(
        child: Row(
          children: <Widget>[Text(text,style: TextStyle(color: Color(0xFFffab00)),)],
        ),
      ),
      actions: <Widget>[
        // ignore: deprecated_member_use
        new TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: TextStyle(color:Color(0xFFffab00)),
            ))
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  static void showAlertHome(
      BuildContext context,
      String text,
      ) {
    var alert = new AlertDialog(
      backgroundColor: Colors.black87,
      content: Container(
        child: Row(
          children: <Widget>[Text(text,style: TextStyle(color: Color(0xFFffab00)),)],
        ),
      ),
      actions: <Widget>[
        // ignore: deprecated_member_use
        new TextButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Tabs(),
                ),
                    (route) => false,
              );
            },
            child: Text(
              "OK",
              style: TextStyle(color:Color(0xFFffab00)),
            ))
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  static void displayDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20),
            color: Colors.black87.withOpacity(0.8),
            child: Center(
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children:<Widget> [
                  SpinKitFadingCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isEven ? Color(0xFF494949) : Color(0xFFffab00),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Text("Loading...",style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'Crimson',
                        color: Color(0xFFffab00).withOpacity(0.4),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void overlayDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 100),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20),
            color: Colors.black87.withOpacity(0.8),
            child: Center(
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children:<Widget> [
                  SizedBox(height: 20,),
                  Container(
                    child: Text("Access Denied",style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'Crimson',
                        color: Color(0xFFffab00),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    },
                    // color: Color(0xFFffab00),
                    child: Text("Close",style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'Crimson',
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}
