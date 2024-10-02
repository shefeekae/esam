import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/custom_row_button_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/connected_equipments/search/connected_equipments_search.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/connected_equipments/widgets/served_by_equipments_builder.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/connected_equipments/widgets/served_to_equipments_builder.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_row_buttons.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import '../../../../../../../../core/enums/equipment_enums.dart';
import 'widgets/serving_spaces_widget.dart';

class ConnectedEquipmentsScreen extends StatelessWidget {
  ConnectedEquipmentsScreen({super.key});

  static const String id = 'equipments/connected';

  final ValueNotifier<ConnectedEquipments> rowButtonsNotifier =
      ValueNotifier<ConnectedEquipments>(ConnectedEquipments.servingSpaces);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Connected Equipments"),
        actions: [
          PermissionChecking(
            featureGroup: "assetManagement",
            feature: "dashboard",
            permission: "connectedAssets",
            child: ValueListenableBuilder(
                valueListenable: rowButtonsNotifier,
                builder: (context, value, _) {
                  if (value == ConnectedEquipments.servingSpaces) {
                    return const SizedBox();
                  }

                  return IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: ConnectedEquipmentsSearchDelegate(
                          connectedEquipmentsType: value,
                          assetEntity: args?['entity'] ?? {},
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                  );
                }),
          )
        ],
      ),
      body: PermissionChecking(
        featureGroup: "assetManagement",
        feature: "dashboard",
        permission: "connectedAssets",
        showNoAccessWidget: true,
        child: Column(
          children: [
            Center(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints.loose(const Size.fromWidth(double.infinity)),
                child: CustomRowButtons(
                  valueListenable: rowButtonsNotifier,
                  onChanged: (itemKey) {
                    rowButtonsNotifier.value = itemKey as ConnectedEquipments;
                  },
                  items: [
                    CustomButtonModel(
                      title: "Serving\nSpaces",
                      itemKey: ConnectedEquipments.servingSpaces,
                    ),
                    CustomButtonModel(
                      title: "Served By\nEquipments",
                      itemKey: ConnectedEquipments.servedByEquipments,
                    ),
                    CustomButtonModel(
                      title: "Served To\nEquipments",
                      itemKey: ConnectedEquipments.servedToEquipments,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: rowButtonsNotifier,
                builder: (context, value, _) {
                  Map<String, dynamic> entity = args?['entity'] ?? {};

                  if (value == ConnectedEquipments.servedByEquipments) {
                    return ServedByEquipmentsPagedGridBuilder(
                      assetEntity: entity,
                    );
                  }

                  if (value == ConnectedEquipments.servingSpaces) {
                    return ServingSpacesBuilder(
                      assetEntity: entity,
                    );
                  }
                  // Served To Equipments
                  return ServedToEquipmentsPagedGridBuilder(
                    assetEntity: entity,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
