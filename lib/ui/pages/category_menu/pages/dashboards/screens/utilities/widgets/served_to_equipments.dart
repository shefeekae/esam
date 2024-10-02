import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/dashboards/served_equipment_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/widgets/served_to_equipment_card.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/widgets/served_to_equipment_search_delegate.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:sizer/sizer.dart';

class ServedToEquipmentsScreen extends StatelessWidget {
  const ServedToEquipmentsScreen(
      {required this.name, required this.identifier, super.key});

  final String identifier;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context),
      body: FutureBuilder(
          future: ServedEquipmentServices().getEquipmentDataWithAdditionalList(
            identifier: identifier,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return BuildShimmerLoadingWidget();
            }

            List<BuildingEquipmentsData> assetsDataList = snapshot.data ?? [];

            return ListView.separated(
              padding: EdgeInsets.all(7.sp),
              itemCount: assetsDataList.length,
              itemBuilder: (context, index) {
                BuildingEquipmentsData asset = assetsDataList[index];

                return BuildingEquipmentCard(
                  asset: asset,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10.sp,
                );
              },
            );
          }),
    );
  }

  // ============================================================================
  // Build Appbar

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Served to Equipments",
        maxLines: 2,
      ),
      actions: [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: ServedToEquipmentSearchDelegate(
                    identifier: identifier,
                  ));
            },
            icon: const Icon(
              Icons.search,
            ))
      ],
    );
  }
}
