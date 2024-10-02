import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/enums/equipment_enums.dart';
import 'package:nectar_assets/core/models/asset/assets_list_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/list/widgets/equipment_card.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../../../../core/models/asset/list_served_by_equipments_model.dart';
import '../../../../../../../../../core/models/asset/list_served_to_equipments_model.dart';
import '../../../../../../../../../utils/constants/colors.dart';

class ConnectedEquipmentsSearchDelegate extends SearchDelegate {
  final UserDataSingleton userData = UserDataSingleton();
  final ConnectedEquipments connectedEquipmentsType;
  final Map<String, dynamic> assetEntity;

  ConnectedEquipmentsSearchDelegate({
    required this.connectedEquipmentsType,
    required this.assetEntity,
  });

  @override
  ThemeData appBarTheme(BuildContext context) =>
      ThemeServices().getSearchThemeData(
        context,
        scaffoldBackgroundColor:
            Brightness.dark == Theme.of(context).brightness ? null : kWhite,
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
  Widget buildResults(BuildContext context) => buildQueryWidget(context);

  @override
  Widget buildSuggestions(BuildContext context) => buildQueryWidget(context);

  Widget buildQueryWidget(BuildContext context) {
    String queryMethod =
        connectedEquipmentsType == ConnectedEquipments.servedByEquipments
            ? AssetSchema.listServedByAssetsWithLatestData
            : AssetSchema.listServingToAssetsWithLatestData;

    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
        query: queryMethod,
        variables: {
          "data": {
            "entity": assetEntity,
            "page": 1,
            "limit": 10,
            "searchKey": "displayName",
            "searchValue": query,
          }
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return Skeletonizer(
            child: buildResultsWidget([]),
          );
        }

        if (result.hasException) {
          return GraphqlServices().handlingGraphqlExceptions(
            result: result,
            context: context,
            refetch: refetch,
          );
        }

        List<Assets> assetList = [];

        if (connectedEquipmentsType == ConnectedEquipments.servedByEquipments) {
          var model =
              ListServedByAssetsWithLatestDataModel.fromJson(result.data ?? {});

          assetList = model.listServedByAssetsWithLatestData?.assets?.map((e) {
                return Assets.fromJson(e.toJson());
              }).toList() ??
              [];
        } else if (connectedEquipmentsType ==
            ConnectedEquipments.servedToEquipments) {
          var model = ListServingToAssetsWithLatestDataModel.fromJson(
              result.data ?? {});

          assetList = model.listServingToAssetsWithLatestData?.assets?.map((e) {
                return Assets.fromJson(e.toJson());
              }).toList() ??
              [];
        }

        // int? totalCount = model.getSchedulerListPaged?.totalItems;

        return buildResultsWidget(assetList);
      },
    );
  }

  Padding buildResultsWidget(List<Assets> assetList) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: GridView.builder(
        itemCount: assetList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.sp,
          crossAxisSpacing: 10.sp,
          childAspectRatio: 2 / 2.3,
        ),
        itemBuilder: (context, index) {
          Assets asset = assetList[index];

          return EquipmentCard(
            asset: asset,
          );
        },
      ),
    );
  }
}
