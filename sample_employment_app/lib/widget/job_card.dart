import 'package:flutter/material.dart';
import 'package:interview_app/config/style.dart';
import 'package:interview_app/widget/tag.dart';

class JobCard extends StatelessWidget {
  final String jobName;
  final String wage;
  final String companyDescription;
  final String employer;
  final String location;
  final List<String> tags;

  const JobCard(
      {Key key,
      this.jobName,
      this.wage,
      this.tags,
      this.companyDescription,
      this.employer,
      this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                jobName,
                style: TextStyle(
                  height: 1,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                wage,
                style: TextStyle(
                  height: 1,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Style.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (tags != null)
            Wrap(
              runAlignment: WrapAlignment.start,
              spacing: 6,
              children: tags.map((e) => Tag(tag: e)).toList(),
            ),
          const SizedBox(height: 14),
          Text(
            companyDescription,
            style: TextStyle(
              height: 1,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Style.tagTextColor,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
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
                  const SizedBox(width: 8),
                  Text(
                    employer,
                    style: TextStyle(
                      height: 1,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ],
              ),
              Text(
                location,
                style: TextStyle(
                  height: 1,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFA3A3B4),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// class HireCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Neumorphic(
//       drawSurfaceAboveChild: false,
//       boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
//       // padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Container(
//         height: 155,
//         decoration: BoxDecoration(
//           // color: const Color(0xFFF5F5FA),
//           borderRadius: BorderRadius.circular(8),
//           // boxShadow: const [
//           //   BoxShadow(
//           //     offset: Offset(8, 6),
//           //     blurRadius: 10,
//           //     color: const Color(0x1A2E2F82),
//           //   ),
//           //   BoxShadow(
//           //     offset: Offset(-8, -8),
//           //     blurRadius: 10,
//           //     color: const Color(0xFDFFFFFF),
//           //   ),
//           // BoxShadow(
//           //   offset: Offset(0, 0),
//           //   blurRadius: 10,
//           //   spreadRadius: -20,
//           //   color: const Color(0x0C000000),
//           // ),
//           // BoxShadow(å
//           //   offset: Offset(6, 6),
//           //   blurRadius: 10,
//           //   spreadRadius: -20,
//           //   color: const Color(0x64FFFFFF),
//           // ),
//           // ],
//         ),
//       ),
//     );
//   }
// }
