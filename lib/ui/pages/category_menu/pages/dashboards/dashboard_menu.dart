import 'package:flutter/material.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/alarm_dashboard.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/utilities_dashboard.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/widgets/dashboard_list_tile.dart';
import 'package:sizer/sizer.dart';

class DashboardMenuScreen extends StatelessWidget {
  const DashboardMenuScreen({super.key});

  static const String id = "/dashboard/menu";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(padding: EdgeInsets.all(5.sp), children: [
        DashboardListTile(
            featureGroup: "dashboard",
            feature: "alarm",
            permission: "view",
            title: "Alarms",
            leadingIcon: Icons.alarm,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AlarmDashboard(
                  dropdownType: Level.community,
                ),
              ));
            }),
        DashboardListTile(
            featureGroup: "dashboard",
            feature: "utilities",
            permission: "view",
            title: "Utilities",
            leadingIcon: Icons.construction,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const UtilitiesDashboard(
                  level: Level.community,
                ),
              ));
            }),
      ]),
    );
  }
}
