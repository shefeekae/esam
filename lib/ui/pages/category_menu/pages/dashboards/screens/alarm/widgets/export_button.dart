import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/alarms/alarms_services.dart';
import 'package:nectar_assets/core/services/file_services.dart';
import 'package:sizer/sizer.dart';

class AlarmExportPopmenuButton extends StatelessWidget {
  const AlarmExportPopmenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          buildPopmenuItem(
            context,
            fileType: "PDF",
            iconData: Icons.picture_as_pdf,
            label: "Pdf",
          ),
        ];
      },
    );
  }

  PopupMenuItem buildPopmenuItem(
    BuildContext context, {
    required String fileType,
    required IconData iconData,
    required String label,
  }) {
    return PopupMenuItem(
      onTap: () {
        AlarmsServices().openAlarmDashboardCard(
          fileType: fileType,
          context: context,
        );
      },
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.grey,
          ),
          SizedBox(
            width: 5.sp,
          ),
          Text(
            "Export $label",
          ),
        ],
      ),
    );
  }
}
