import 'package:flutter/material.dart';
import 'package:interview_app/page/controller_page.dart';
import 'package:interview_app/page/home_page.dart';
import 'package:interview_app/page/particle_page.dart';
import 'package:interview_app/page/shadow_page.dart';

class DashBoardPage extends StatelessWidget {
  DashBoardPage({Key key}) : super(key: key);

  final pages = {
    'app': MyHomePage(),
    'shadow': ShadowPage(),
    'paint': PaintPage(size: 300),
    'particle': ParticlePage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('选择页面')),
      body: Center(
        child: Wrap(
          children: pages.keys
              .map((e) => ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => pages[e]));
                  },
                  child: Text(e)))
              .toList(),
        ),
      ),
    );
  }
}
