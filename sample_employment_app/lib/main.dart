import 'dart:io';

import 'package:flutter/material.dart';
import 'package:interview_app/config/style.dart';
import 'package:interview_app/page/chat_page.dart';
import 'package:interview_app/page/home_page.dart';
import 'package:interview_app/widget/shadow.dart';

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
      home: Shadow(),
      // home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController;
  int page = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              const HomePage(),
              const ChatPage(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                page = 1 - page;
                pageController.jumpToPage(page);
              },
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFF191927).withOpacity(0.88),
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Style.backgroundColor,
    );
  }
}
