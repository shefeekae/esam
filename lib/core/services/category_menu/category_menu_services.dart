import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/dashboard_menu.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/communites_insights_screen.dart';
import '../../../ui/pages/category_menu/pages/alarms/list/alarms_list.dart';
import '../../../ui/pages/category_menu/pages/documents/list/documents_list_screen.dart';
import '../../../ui/pages/category_menu/pages/equipments/list/equipments_list.dart';
import '../../../ui/pages/category_menu/pages/fire alarms/dashboard/fire_alarms_dashboard.dart';
import '../../../ui/pages/category_menu/pages/fire panel/dashboard/fire_panel_dashboard_screen.dart';
import '../../../ui/pages/category_menu/pages/scheduler/scheduler_screen.dart';
import '../../models/category_menu/category_item_model.dart';

class CategoryMenuServices {
  final List<CategoryItem> categoriesList = [
    CategoryItem(
        name: "Alarms",
        iconData: Icons.alarm_outlined,
        screenId: AlarmsListScreen.id,
        featureGroup: "alarmManagement"),
    CategoryItem(
      name: "Equipment",
      iconData: Icons.construction_outlined,
      screenId: EquipmentsListScreen.id,
      featureGroup: "assetManagement",
    ),
    CategoryItem(
      name: "Scheduler",
      iconData: Icons.schedule_rounded,
      screenId: SchedulerScreen.id,
      featureGroup: "scheduler",
    ),
    CategoryItem(
      name: "Documents",
      iconData: Icons.folder_outlined,
      screenId: DocumentsListScreen.id,
      featureGroup: "documentManagement",
    ),
    CategoryItem(
      name: "Fire Panels",
      iconData: Icons.fire_extinguisher,
      screenId: FirePanelDashboardScreen.id,
      featureGroup: "firePanelManagement",
    ),
    CategoryItem(
      name: "Fire Alarms",
      iconData: Icons.local_fire_department_rounded,
      screenId: FireAlarmsDashboardScreen.id,
      featureGroup: "fireAlarmManagement",
    ),
    CategoryItem(
      name: "Communities",
      iconData: Icons.domain_outlined,
      screenId: CommunityHierarchyScreen.id,
      featureGroup: "clientManagement",
      feature: "clients",
      permission: "view",
    ),
    CategoryItem(
      name: "Dashboards",
      iconData: Icons.dashboard,
      screenId: DashboardMenuScreen.id,
      featureGroup: "dashboard",
    ),
    // CategoryItem(
    //   name: "Services",
    //   iconData: Icons.miscellaneous_services_outlined,
    //   screenId: ServicesListScreen.id,
    //   featureGroup: "",
    // ),
    // CategoryItem(
    //   name: "IRM",
    //   iconData: Icons.cottage_outlined,
    //   screenId: "",
    // ),

    // CategoryItem(
    //   name: "Sub Communities",
    //   iconData: Icons.home_work_outlined,
    //   screenId: "",
    // ),
    // CategoryItem(
    //   name: "Buildings",
    //   iconData: Icons.location_city_outlined,
    //   screenId: "",
    // ),
    // CategoryItem(
    //   name: "BTU meters",
    //   iconData: Icons.speed_outlined,
    //   screenId: "",
    // ),
    // CategoryItem(
    //   name: "Service Requests",
    //   iconData: Icons.support_agent_outlined,
    //   screenId: "",
    // ),
    // CategoryItem(
    //   name: "Jobs",
    //   iconData: Icons.list_alt_outlined,
    //   screenId: "",
    // ),
    // CategoryItem(
    //   name: "Berths",
    //   iconData: Icons.directions_boat_filled_outlined,
    //   screenId: "",
    // ),

    // CategoryItem(
    //   name: "Waste Management",
    //   iconData: Icons.recycling_outlined,
    //   screenId: "",
    // ),
    // CategoryItem(
    //   name: "Chillers",
    //   iconData: Icons.kitchen_outlined,
    //   screenId: "",
    // ),
    // CategoryItem(
    //   name: "DCP",
    //   iconData: Icons.device_thermostat_outlined,
    //   screenId: "",
    // ),
  ];
}
