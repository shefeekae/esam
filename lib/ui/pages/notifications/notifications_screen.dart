import 'package:flutter/material.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  static const String id = "/notifications";

  final List<Map> list = [
    {
      "title":
          "A new service request was created. Car maintenance for Toyota Hilux.",
      "icon": Icons.support_agent_outlined
    },
    {
      "title": "EX178 is not communicating since 17 Nov 2023 01:10 PM.",
      "icon": Icons.business_center_outlined,
    },
    {
      "title": "21 alarms requires attention.",
      "icon": Icons.alarm_outlined,
    },
    {
      "title": "15 documents is going to expire this month.",
      "icon": Icons.note_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView.separated(
        itemCount: list.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 5.sp,
        ),
        itemBuilder: (context, index) {
          var map = list[index];

          String title = map['title'];
          IconData iconData = map['icon'];

          return ListTile(
            leading: CircleAvatar(
              maxRadius: 12.sp,
              backgroundColor: kWhite,
              child: Icon(
                iconData,
                color: kBlack,
              ),
            ),
            title: RichText(
              text: TextSpan(
                text: title,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: kBlack,
                ),
                children: [
                  TextSpan(
                    text: " 1d",
                    style: TextStyle(
                      // fontSize: 8.sp,
                      color: kGrey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
