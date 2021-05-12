import 'package:flutter/material.dart';
import 'package:interview_app/widget/inner_shadow.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InnerShadow(
      offset: Offset(-1, -1),
      blur: 3,
      color: Color(0x17FFFFFF),
      child: InnerShadow(
        offset: Offset(1, 1),
        blur: 3,
        color: Color(0x41000000),
        child: Container(
          width: 80,
          height: 32,
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2F9A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/search.png',
                width: 20,
                height: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 4),
              Text(
                '搜索',
                style: TextStyle(
                  fontSize: 14,
                  height: 1,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
