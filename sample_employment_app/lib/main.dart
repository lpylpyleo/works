import 'dart:io';

import 'package:flutter/material.dart';
import 'package:interview_app/config/style.dart';
import 'package:interview_app/page/dashboard_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interview App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
            subtitle1: TextStyle(textBaseline: TextBaseline.alphabetic)),
        primaryColor: Style.primaryColor,
        backgroundColor: Style.backgroundColor,
        fontFamily: Platform.isIOS ? 'PingFang SC' : null,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: DashBoardPage(),
    );
  }
}
