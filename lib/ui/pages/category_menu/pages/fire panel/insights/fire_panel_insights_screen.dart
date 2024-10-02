// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/insights/widgets/firepanel_barcharts.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:sizer/sizer.dart';
import 'widgets/fire_panel_status_card.dart';

class FirePanelInsightsScreen extends StatelessWidget {
  const FirePanelInsightsScreen({super.key});

  static const String id = '/firepanel/insights';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fire Panel Insights"),
      ),
      body: PermissionChecking(
        featureGroup: "firePanelManagement",
        feature: "dashboard",
        permission: "view",
        showNoAccessWidget: true,
        child: ListView(
          children: [
            statusCards(),
            SizedBox(
              height: 10.sp,
            ),
            FirePanelBarChart(),
          ],
        ),
      ),
    );
  }

  // ======================================================================================

  Widget statusCards() {
    return PanelsAlarmsStatusCard();
  }
}
