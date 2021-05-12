import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String msg;
  final String time;
  final String employer;
  final String company;

  const ChatCard({Key key, this.msg, this.time, this.employer, this.company})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5FA),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            offset: Offset(8, 6),
            blurRadius: 10,
            color: const Color(0x1A2E2F82),
          ),
          BoxShadow(
            offset: Offset(-8, -8),
            blurRadius: 10,
            color: const Color(0xFDFFFFFF),
          ),
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 10,
            spreadRadius: -20,
            color: const Color(0x0C000000),
          ),
          BoxShadow(
            offset: Offset(6, 6),
            blurRadius: 10,
            spreadRadius: -20,
            color: const Color(0x64FFFFFF),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://sf6-ttcdn-tos.pstatp.com/img/user-avatar/f94d2b8bb7e476fe4644bcbf88fae948~300x300.image',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          employer,
                          style: TextStyle(
                            height: 1,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          time,
                          style: TextStyle(
                            height: 1,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFA3A3B4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      company,
                      style: TextStyle(
                        height: 1,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFA3A3B4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            msg,
            style: TextStyle(
              height: 1.6,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
