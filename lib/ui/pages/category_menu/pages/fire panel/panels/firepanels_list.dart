import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/widgets/panels_list_builder.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';

class FirePanelListScreen extends StatelessWidget {
  const FirePanelListScreen({super.key});

  static const String id = '/firepanel/list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const PermissionChecking(
          featureGroup: "firePanelManagement",
          feature: "dashboard",
          permission: "view",
          showNoAccessWidget: true,
          child: PanelsPaginationBuilder()),
    );
  }

  // ============================

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text("All Panels"),
      // actions: [
      // IconButton(
      //   onPressed: () {
      //     // showSearch(
      //     //   context: context,
      //     //   delegate: FirePanelsSearchDelegate(),
      //     // );
      //   },
      //   icon: const Icon(
      //     Icons.search,
      //   ),
      // ),
      // ],
    );
  }
}
