import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:nectar_assets/core/models/panels/fire_panels_list_model.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/panel_details_screen.dart';
import 'package:nectar_assets/ui/shared/widgets/container_with_text.dart';
import 'package:nectar_assets/ui/shared/widgets/location_path_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../utils/constants/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class PanelCard extends StatelessWidget {
  const PanelCard({
    required this.panel,
    super.key,
  });

  final Assets panel;

  Color getStatusColor(String? status) {
    switch (status) {
      case "Alarm":
        return Colors.red.shade500;

      case "Normal":
        return Colors.green.shade500;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Points> points = panel.points ?? [];

    Points? silenceStatusPoint = points.singleWhereOrNull(
      (element) => element.pointName == "Silence Status",
    );

    Points? resetStatusPoint = points.singleWhereOrNull(
      (element) => element.pointName == "Reset Status",
    );

    Points? commonAlarmPoint = points.singleWhereOrNull(
      (element) => element.pointName == "Common Alarm",
    );

    String? silenceStatus = silenceStatusPoint?.data;
    String? resetStatus = resetStatusPoint?.data;
    String? alarmStatus = commonAlarmPoint?.data;

    int fault = panel.eventMap?.commonFault ?? 0;
    int dirty = panel.eventMap?.dirty ?? 0;
    int disabled = panel.eventMap?.disabled ?? 0;
    int headMissing = panel.eventMap?.headMissing ?? 0;

    return Bounce(
      duration: const Duration(milliseconds: 100),
      onPressed: () {
        Navigator.of(context).pushNamed(
          PanelDetailsScreen.id,
          arguments: {
            "domain": panel.domain,
            "identifier": panel.identifier,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: ThemeServices().getBgColor(context),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              panel.displayName ?? "N/A",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    statusRow(
                        iconData: Icons.notifications_active,
                        title: "Alarm Status",
                        value: alarmStatus ?? "N/A",
                        iconColor: Colors.amber,
                        containerBgcolor: getStatusColor(alarmStatus)),
                    statusRow(
                        iconData: Icons.restore,
                        title: "Reset Status",
                        value: resetStatus ?? "N/A",
                        iconColor: Colors.blue,
                        containerBgcolor: getStatusColor(resetStatus)),
                    statusRow(
                      iconData: Icons.notifications_off,
                      title: "Silence Status",
                      value: silenceStatus ?? "N/A",
                      iconColor: Colors.green,
                      containerBgcolor: getStatusColor(silenceStatus),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    statusRow(
                      iconData: Icons.info_outline,
                      title: "Fault",
                      value: fault.toString(),
                      iconColor: Colors.amber,
                      trailingisText: true,
                    ),
                    statusRow(
                      iconData: Icons.dirty_lens,
                      title: "Dirty",
                      value: dirty.toString(),
                      iconColor: Colors.red.shade900,
                      trailingisText: true,
                    ),
                    statusRow(
                      iconData: Icons.disabled_by_default_outlined,
                      title: "Disabled",
                      value: disabled.toString(),
                      iconColor: Colors.grey,
                      trailingisText: true,
                    ),
                    statusRow(
                      iconData: Icons.cable_outlined,
                      title: "Head Missing",
                      value: headMissing.toString(),
                      iconColor: Colors.red,
                      trailingisText: true,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5.sp,
            ),
            Builder(builder: (context) {
              String? value = panel.path
                  ?.where((element) {
                    return element.name != null &&
                        element.entity?.type != "FACP";
                  })
                  .map((e) => e.name)
                  .join(" - ");

              if (value == null) {
                return const SizedBox();
              }

              return LocationPathWidget(
                value: value,
              );
            })
          ],
        ),
      ),
    );
  }

  Widget statusRow({
    required IconData iconData,
    required String title,
    required String value,
    required Color iconColor,
    Color? containerBgcolor,
    bool trailingisText = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.sp),
      child: Row(
        children: [
          Icon(
            iconData,
            color: iconColor,
            size: 12.sp,
          ),
          SizedBox(
            width: 3.sp,
          ),
          Text(
            "$title:",
            style: const TextStyle(
                // fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(
            width: 3.sp,
          ),
          trailingisText
              ? Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              : ContainerWithTextWidget(
                  value: value,
                  bgColor: containerBgcolor,
                  fgColor: kWhite,
                )
        ],
      ),
    );
  }
}
