import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/details/alarms_details.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart';
import '../../../../../../../core/services/theme/theme_services.dart';
import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../shared/widgets/location_path_widget.dart';
import 'package:collection/collection.dart';

class FireAlarmCard extends StatelessWidget {
  const FireAlarmCard({
    required this.eventLogs,
    super.key,
  });

  final EventLogs eventLogs;

  @override
  Widget build(BuildContext context) {
    String eventTime = eventLogs.eventTime == null
        ? "N/A"
        : format(DateTime.fromMillisecondsSinceEpoch(eventLogs.eventTime!));

    List sourceTagPath = eventLogs.sourceTagPath ?? [];

    var panelData =
        sourceTagPath.singleWhereOrNull((element) => element['type'] == "FACP");

    var siteData = sourceTagPath.singleWhereOrNull((element) =>
        element['parentType'] == "Site" || element['parentType'] == "Building");

    List<String> spacesNames = sourceTagPath
        .where((element) {
          return element['parentType'] == "Space" && element['name'] != null;
        })
        .map((e) => e['name'].toString())
        .toList();

    String? panelName = panelData?['name'];

    String? sourceName = eventLogs.sourceName;

    String name = spacesNames.isNotEmpty
        ? spacesNames.join(" - ")
        : siteData == null
            ? eventLogs.name ?? "N/A"
            : siteData['name'] ?? "N/A";

    return Bounce(
      duration: const Duration(milliseconds: 100),
      onPressed: () {
        Navigator.of(context).pushNamed(
          AlarmsDetailsScreen.id,
          arguments: {
            "identifier": eventLogs.eventId,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.sp),
        margin: EdgeInsets.symmetric(horizontal: 5.sp),
        decoration: BoxDecoration(
          color: ThemeServices().getContainerBgColor(context),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: Colors.orangeAccent,
                  size: 40.sp,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              // "609 - 6th Floor ",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            eventTime,
                            style: TextStyle(
                              fontSize: 8.sp,
                            ),
                          )
                        ],
                      ),
                      buildSourceName(sourceName),
                      SizedBox(
                        height: 3.sp,
                      ),
                      Visibility(
                        visible: panelName != null,
                        child: Text(
                          panelName ?? "N/A",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.sp,
            ),
            bulidLocationPath(sourceTagPath),
          ],
        ),
      ),
    );
  }

  // ======================================================================

  Widget bulidLocationPath(List sourceTagPath) {
    if (sourceTagPath.isEmpty) {
      return const SizedBox();
    }

    List<String> value = sourceTagPath
        .where(
          (element) {
            return element['name'] != null &&
                element['type'] != "FACP" &&
                element['parentType'] != "Equipment" &&
                element['parentType'] != "Site" &&
                element['parentType'] != "Space";
          },
        )
        .map((e) => e['name'].toString())
        .toList();

    return Padding(
      padding: EdgeInsets.only(top: 5.sp),
      child: LocationPathWidget(
        value: value.join(" - "),
      ),
    );
  }

  // ==========================================================================

  Widget buildSourceName(String? sourceName) {
    if (sourceName == null) {
      return const SizedBox();
    }

    return Padding(
      padding: EdgeInsets.only(top: 3.sp),
      child: Row(
        children: [
          const Icon(
            Icons.sensors,
            color: Colors.red,
          ),
          SizedBox(
            width: 5.sp,
          ),
          Expanded(
            child: Text(
              sourceName,
              maxLines: 2,
              style: TextStyle(
                fontSize: 10.sp,
                color: kGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
