import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../shared/widgets/listtile/list_tile_with_divider.dart';
import '../../../../../../shared/widgets/listtile/listtile_info_container_card.dart';

class ServicesMoreDetails extends StatelessWidget {
  ServicesMoreDetails({
    super.key,
  });

  final List taggedDetails = [
    {
      "title": 'Executed Services',
      "icon": Icons.task_alt,
      "value": "New Routine 1000",
    },
    {
      "title": 'Tagged Services',
      "icon": Icons.sell_outlined,
      "value": "New Routine 1000",
    },
  ];

  final List moreDetails = [
    {
      "title": 'client',
      "icon": Icons.person_pin,
      "value": "Nectar Smart",
    },
    {
      "title": 'Asset Type',
      "icon": Icons.build_circle_outlined,
      "value": "Water Meter",
    },
    {
      "title": 'Service Type',
      "icon": Icons.sell_outlined,
      "value": "Cyclic",
    },
    {
      "title": 'Desired Runhours',
      "icon": Icons.access_time,
      "value": "Dec 3 2023 10:00 AM",
    },
    {
      "title": 'Actual Runhours',
      "icon": Icons.task_alt,
      "value": "2500",
    },
    {
      "title": 'Desired Odometer',
      "icon": Icons.speed,
      "value": "3452",
    },
    {
      "title": 'Technicians',
      "icon": Icons.build_outlined,
      "value": "Peter Parker, Mechanic Mech",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ContainerInfoCardWithDivider(
          title: "Tag Details",
          children: List.generate(
            taggedDetails.length,
            (index) {
              var map = taggedDetails[index];

              return ListTielWithDivider(
                leadingIconData: map['icon'],
                title: map['title'],
                trailingText: map['value'],
              );
            },
          ),
        ),
        SizedBox(
          height: 10.sp,
        ),
        ContainerInfoCardWithDivider(
          title: "More Details",
          children: List.generate(
            moreDetails.length,
            (index) {
              var map = moreDetails[index];

              return ListTielWithDivider(
                leadingIconData: map['icon'],
                title: map['title'],
                trailingText: map['value'],
              );
            },
          ),
        ),
      ],
    );
  }
}
