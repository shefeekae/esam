import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/pages/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/category_menu_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/details/alarms_details.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/alarms_list.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/dashboard_menu.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/documents/categories/documents_categories_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/documents/details/document_details.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/documents/list/documents_list_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/consoldation/consoldation_alarms_list_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/consoldation/equipment_consoldation_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/equipment_details.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/connected_equipments/connected_equipments_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/equipment_maintenance_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/equpment_live_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/profile_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/work_orders_list_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/list/equipments_list.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20alarms/dashboard/fire_alarms_dashboard.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/dashboard/fire_panel_dashboard_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/insights/fire_panel_insights_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/panel_details_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/firepanels_list.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/scheduler/details/scheduler_details.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/scheduler/scheduler_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/services/details/service_detalis_scree.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/services/list/services_list_screen.dart';
import 'package:nectar_assets/ui/pages/forgot%20password/forgot_password_screen.dart';
import 'package:nectar_assets/ui/pages/home/home_screen.dart';
import 'package:nectar_assets/ui/pages/home/search/global_search_screen.dart';
import 'package:nectar_assets/ui/pages/login/login_screen.dart';
import 'package:nectar_assets/ui/pages/notifications/notifications_screen.dart';
import 'package:nectar_assets/ui/pages/profile/pages/change_password_screen.dart';
import 'package:nectar_assets/ui/pages/profile/pages/profile_update_screen.dart';
import 'package:nectar_assets/ui/pages/profile/profile_screen.dart';
import 'package:nectar_assets/ui/pages/scanner/scanner_screen.dart';
import 'package:nectar_assets/ui/pages/splash/splash_screen.dart';

Map<String, WidgetBuilder> namedRoutes = {
  SplashScreen.id: (context) => const SplashScreen(),
  LoginScreen.id: (context) => LoginScreen(),
  ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
  BottomNavBarScreen.id: (context) => BottomNavBarScreen(),
  HomeScreen.id: (context) => const HomeScreen(),
  QrCodeBarCodeScannerScreen.id: (context) =>
      const QrCodeBarCodeScannerScreen(),
  GloabalSearchScreen.id: (context) => GloabalSearchScreen(),
  NotificationsScreen.id: (context) => NotificationsScreen(),
  ProfileScreen.id: (context) => const ProfileScreen(),
  ProfileUpdateScreen.id: (context) => const ProfileUpdateScreen(),
  ChangePasswordScreen.id: (context) => const ChangePasswordScreen(),
  CategoryMenuScreen.id: (context) => CategoryMenuScreen(),
  AlarmsListScreen.id: (context) => const AlarmsListScreen(),
  AlarmsDetailsScreen.id: (context) => AlarmsDetailsScreen(),
  EquipmentsListScreen.id: (context) => const EquipmentsListScreen(),
  EquipmentDetailsScreen.id: (context) => EquipmentDetailsScreen(),
  EquipmentProfileScreen.id: (context) => EquipmentProfileScreen(),
  EquipmentLiveScreen.id: (context) => EquipmentLiveScreen(),
  EquipmentConsoldationScreen.id: (context) =>
      const EquipmentConsoldationScreen(),
  ConslodationAlarmsListScreen.id: (context) =>
      const ConslodationAlarmsListScreen(),
  DocumentCategoriesScreen.id: (context) => DocumentCategoriesScreen(),
  DocumentsListScreen.id: (context) => DocumentsListScreen(),
  DocumentDetailsScreen.id: (context) => const DocumentDetailsScreen(),
  SchedulerScreen.id: (context) => SchedulerScreen(),
  SchedulerDetailsScreen.id: (context) => SchedulerDetailsScreen(),
  FirePanelDashboardScreen.id: (context) => const FirePanelDashboardScreen(),
  FirePanelInsightsScreen.id: (context) => const FirePanelInsightsScreen(),
  FirePanelListScreen.id: (context) => const FirePanelListScreen(),
  FireAlarmsDashboardScreen.id: (context) => FireAlarmsDashboardScreen(),
  ServicesListScreen.id: (context) => ServicesListScreen(),
  ServiceDetailsScreen.id: (context) => ServiceDetailsScreen(),
  PanelDetailsScreen.id: (context) => const PanelDetailsScreen(),
  DashboardMenuScreen.id: (context) => const DashboardMenuScreen(),
  WorkOrdersListScreen.id: (context) => WorkOrdersListScreen(),
  EquipmentMaintenanceScreen.id: (context) =>
      const EquipmentMaintenanceScreen(),
  ConnectedEquipmentsScreen.id: (context) => ConnectedEquipmentsScreen(),
};
