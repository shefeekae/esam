// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nectar_assets/ui/pages/scanner/scanner_screen.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:reorderables/reorderables.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:nectar_assets/ui/pages/home/search/global_search_screen.dart';
import '../../shared/widgets/custom_searchfield.dart';
import 'widgets/document_count_widget.dart';
import 'widgets/custom_title_with_multipledata.dart';
import 'widgets/home_alarms_widgets.dart';
import 'widgets/services_count_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> keys = [
    "fireAlarms",
    "activeAlarms",
    "equipments",
    "criticalAlarms",
    "documents",
    "schedules",
    "overdueServices",
    "upcomingServices",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context),
      body: PermissionChecking(
        featureGroup: "home",
        feature: "home",
        permission: "view",
        showNoAccessWidget: true,
        paddingTop: 50.sp,
        child: ReorderableWrap(
          runSpacing: 15.sp,
          padding: EdgeInsets.all(15.sp),
          alignment: WrapAlignment.spaceBetween,
          buildDraggableFeedback: (context, constraints, child) {
            return Material(
              borderRadius: BorderRadius.circular(10),
              child: ConstrainedBox(
                constraints: constraints,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: child,
                ),
              ),
            );
          },
          onReorder: (oldIndex, newIndex) {
            setState(
              () {
                String key = keys.removeAt(oldIndex);
                keys.insert(newIndex, key);
              },
            );
          },
          children: List.generate(
            keys.length,
            (index) {
              switch (keys[index]) {
                case "fireAlarms":
                  return AlarmCountWidget(
                    grdientColors: [
                      HexColor("FC3C3C"),
                      HexColor("FFCC69"),
                    ],
                    label: "Fire Alarms",
                    iconData: Icons.local_fire_department,
                    value: "3",
                  );

                case "activeAlarms":
                  return AlarmCountWidget(
                    color: Theme.of(context).primaryColor,
                    label: "Active Alarms",
                    iconData: Icons.notifications_on_sharp,
                    value: "100",
                  );

                case "equipments":
                  return const CustomTileWithMultipleData(
                    title: "Equipments",
                    value: "1000",
                    items: [
                      {
                        "title": "Non Communicating",
                        "icon": Icons.link,
                        "iconColor": Colors.red,
                        "value": "50",
                      },
                      {
                        "title": "Under Maintenance",
                        "icon": Icons.miscellaneous_services_outlined,
                        "value": "10",
                      },
                    ],
                  );

                case "criticalAlarms":
                  return AlarmCountWidget(
                    color: Theme.of(context).primaryColor,
                    label: "Critical Alarms",
                    iconData: Icons.notifications_on_sharp,
                    value: "89",
                  );

                case "documents":
                  return const DocumentCountWidget();

                case "schedules":
                  return const CustomTileWithMultipleData(
                    title: "Schedules",
                    items: [
                      {
                        "title": "Upcoming",
                        "icon": Icons.event,
                        "value": "50",
                      },
                      {
                        "title": "Running",
                        "icon": Icons.hourglass_top,
                        "value": "10",
                      },
                    ],
                  );

                case "overdueServices":
                  return const ServicesCountWidget(
                    title: "Overdue \nServices",
                    value: "5",
                  );

                case "upcomingServices":
                  return const ServicesCountWidget(
                    title: "Upcoming \nServices",
                    value: "10",
                  );

                default:
                  return const SizedBox();
              }
            },
          ),
          // children: [
          //   AlarmCountWidget(
          //     grdientColors: [
          //       HexColor("FC3C3C"),
          //       HexColor("FFCC69"),
          //     ],
          //     label: "Fire Alarms",
          //     iconData: Icons.local_fire_department,
          //     value: "3",
          //   ),
          //   AlarmCountWidget(
          //     color: Theme.of(context).primaryColor,
          //     label: "Active Alarms",
          //     iconData: Icons.notifications_on_sharp,
          //     value: "100",
          //   ),
          // const CustomTitleWithMultipleData(
          //   title: "Equipments",
          //   value: "1000",
          //   items: [
          //     {
          //       "title": "Non Communicating",
          //       "icon": Icons.link,
          //       "iconColor": Colors.red,
          //       "value": "50",
          //     },
          //     {
          //       "title": "Under Maintenance",
          //       "icon": Icons.miscellaneous_services_outlined,
          //       // "iconColor": Colors.red,
          //       "value": "10",
          //     },
          //   ],
          // ),
          //   AlarmCountWidget(
          //     color: Theme.of(context).primaryColor,
          //     label: "Critical Alarms",
          //     iconData: Icons.notifications_on_sharp,
          //     value: "89",
          //   ),
          //   const DocumentCountWidget(),
          // const CustomTitleWithMultipleData(
          //   title: "Schedules",
          //   items: [
          //     {
          //       "title": "Upcoming",
          //       "icon": Icons.event,
          //       "value": "50",
          //     },
          //     {
          //       "title": "Running",
          //       "icon": Icons.hourglass_top,
          //       "value": "10",
          //     },
          //   ],
          // ),
          // const EquipmentsCountWidget(),
          // const EquipmentsCountWidget(),
          // ],
        ),
      ),

      // body: RefreshIndicator.adaptive(
      //   onRefresh: () async {},
      //   child: ListView(
      //     shrinkWrap: true,
      //     physics: const AlwaysScrollableScrollPhysics(),
      //     children: [
      //       SizedBox(
      //         height: 10.sp,
      //       ),
      //       Padding(
      //         padding: EdgeInsets.only(left: 10.sp),
      //         child: Text(
      //           "What's New",
      //           style: TextStyle(
      //             fontSize: 15.sp,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10.sp,
      //       ),
      //       ListView.separated(
      //         shrinkWrap: true,
      //         physics: const NeverScrollableScrollPhysics(),
      //         itemCount: 10,
      //         separatorBuilder: (context, index) {
      //           return SizedBox(
      //             height: 10.sp,
      //           );
      //         },
      //         itemBuilder: (context, index) {
      //           return FeedCard();
      //         },
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  // ==============================================
  AppBar buildAppbar(BuildContext context) {
    String? data = SharedPrefrencesServices().getData(
      key: "appTheme",
    );

    bool enableSearch = false;

    if (data != null) {
      Map<String, dynamic> map = jsonDecode(data);

      enableSearch = map['enableGlobalSearch'] ?? false;
    }

    return AppBar(
      title: Builder(builder: (context) {
        if (!enableSearch) {
          return const Text("Nectar Assets");
        }

        return BuildCustomSearchField(
          onTap: () {
            Navigator.of(context).pushNamed(GloabalSearchScreen.id);
          },
        );
      }),
      actions: [
        PermissionChecking(
          featureGroup: "assetManagement",
          feature: "dashboard",
          permission: "view",
          child: Padding(
            padding: EdgeInsets.only(right: 10.sp),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QrCodeBarCodeScannerScreen(),
                ));
              },
              icon: const Icon(
                Icons.qr_code_scanner,
              ),
            ),
          ),
        ),
        // SizedBox(
        //   width: 10.sp,
        // )
      ],
    );
  }
}
