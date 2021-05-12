import 'package:flutter/material.dart';
import 'package:interview_app/config/style.dart';

class Tag extends StatelessWidget {
  final String tag;

  const Tag({Key key, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Style.tagBackgroundColor,
      padding: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child: Text(
        tag,
        style: TextStyle(
          height: 1.2,
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Style.tagTextColor,
        ),
      ),
    );
  }
}
