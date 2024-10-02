import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/shared/widgets/listtile/list_tile_with_divider.dart';
import 'package:nectar_assets/ui/shared/widgets/sheets/custom_modal_bottomsheet.dart';
import 'package:sizer/sizer.dart';
import '../../../../../shared/widgets/listtile/listtile_info_container_card.dart';
import 'widgets/services_attachments_widget.dart';
import 'widgets/services_checklists.dart';
import 'widgets/services_more_details.dart';
import 'widgets/services_parts.dart';

class ServiceDetailsScreen extends StatelessWidget {
  ServiceDetailsScreen({super.key});

  static const String id = '/services/details';

  final List list = [
    {
      "title": 'Asset',
      "icon": Icons.construction_outlined,
      "value": "S A1 Water Meter 01",
    },
    
    {
      "title": 'Status',
      "icon": Icons.info_outline,
      "value": "Upcoming",
    },
     {
      "title": 'Serviced On',
      "icon": Icons.date_range,
      "value": "Dec 3 2023 10:00 AM",
    },
    
    {
      "title": 'Job Id',
      "icon": Icons.assignment_outlined,
      "value": "10123",
    },
  ];

  final SizedBox sizedBox = SizedBox(
    height: 10.sp,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: ListView(
          children: [
            basicInformations(),
            sizedBox,
            const ServicesAttachments(),
            sizedBox,
            const ServicesChecklists(),
            sizedBox,
            const ServicesParts(),
          ],
        ),
      ),
    );
  }

  // ================================================================================

  ContainerInfoCardWithDivider basicInformations() {
    return ContainerInfoCardWithDivider(
      children: List.generate(
        list.length,
        (index) {
          var map = list[index];

          return ListTielWithDivider(
            leadingIconData: map['icon'],
            title: map['title'],
            trailingText: map['value'],
          );
        },
      ),
    );
  }

  // ===========================================================================

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "300 Run hour engine oil Change",
        style: TextStyle(
          fontSize: 12.sp,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showCustomModalBottomSheet(
              context: context,
              child: ServicesMoreDetails(),
            );
          },
          icon: const Icon(Icons.info_outline),
        ),
      ],
    );
  }
}

