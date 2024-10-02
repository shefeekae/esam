

import 'package:app_filter_form/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/site/building_summary_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/pages/summary_equipments_search.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/site/widgets/builing_equipment_card.dart';
import 'package:sizer/sizer.dart';

class SummaryEquipmentsScreen extends StatelessWidget {
  const SummaryEquipmentsScreen(
      {required this.name, required this.identifier, super.key});

  final String identifier;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context),
      body: FutureBuilder(
          future: SummaryEquipmentServices().getEquipmentDataWithAdditionalList(
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
      title: Text(
       name.isEmpty ? "Equipments" : "$name - Equipments",
        maxLines: 2,
      ),
      actions: [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: SummaryEquipmentSearchDelegate(
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
