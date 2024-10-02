import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../core/services/site/building_summary_services.dart';
import '../../../../../../shared/widgets/loading_widget.dart';
import '../../site/widgets/builing_equipment_card.dart';

class SummaryEquipmentSearchDelegate extends SearchDelegate {
  final UserDataSingleton userData = UserDataSingleton();
  final String identifier;

  SummaryEquipmentSearchDelegate({
    required this.identifier,
  });

  @override
  ThemeData appBarTheme(BuildContext context) =>
      ThemeServices().getSearchThemeData(
        context,
        // scaffoldBackgroundColor:
        //     Brightness.dark == Theme.of(context).brightness ? null : kWhite,
      );

  @override
  String? get searchFieldLabel => "Search Equipments";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Visibility(
        visible: query.isNotEmpty,
        child: IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear),
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) => buildBuildingEquipments(context);

  @override
  Widget buildSuggestions(BuildContext context) =>
      buildBuildingEquipments(context);

  Widget buildBuildingEquipments(BuildContext context) {
    return FutureBuilder(
        future: SummaryEquipmentServices().getEquipmentDataWithAdditionalList(
            identifier: identifier, searchValue: query),
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
        });
  }
}
