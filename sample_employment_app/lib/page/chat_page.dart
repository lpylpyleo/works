import 'package:flutter/material.dart';
import 'package:interview_app/config/style.dart';
import 'package:interview_app/widget/chat_card.dart';
import 'package:interview_app/widget/search.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor,
      body: Column(
        children: [
          Container(
            height: 44,
            color: Style.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      '聊天',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Search(),
              ],
            ),
          ),
          Expanded(
              child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16),
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 16);
            },
            itemBuilder: (BuildContext context, int index) {
              return ChatCard(
                company: '南宁华和结文化传播有限公司·hr',
                msg: '你好，看了你的简历想再了解一下您的具体情…',
                time: '11:30',
                employer: '唐先生',
              );
            },
          ))
        ],
      ),
    );
  }

  const ChatPage();
}
