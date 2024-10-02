// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:nectar_assets/core/models/asset/assets_list_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/widgets/equipment_card.dart';

class PanelEquipmentSearchDelegate extends SearchDelegate {
  final UserDataSingleton userData = UserDataSingleton();

  final Map<String, dynamic> entity;
  PanelEquipmentSearchDelegate({
    required this.entity,
  });

  @override
  ThemeData appBarTheme(BuildContext context) =>
      ThemeServices().getSearchThemeData(context);

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
    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
        query: AssetSchema.getAssetList,
        variables: {
          "filter": {
            "searchLabel": query,
            "offset": 1,
            "pageSize": 10,
            "clients": userData.domain,
            "entities": [
              entity,
            ]
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

        var assetListModel = AssetsListModel.fromJson(result.data ?? {});

        List<Assets> assetList = assetListModel.getAssetList?.assets ?? [];

        // int? totalCount = model.getSchedulerListPaged?.totalItems;

        return buildResultsWidget(assetList);
      },
    );
  }

  Padding buildResultsWidget(List<Assets> assetList) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 5.sp,
        ),
        itemCount: assetList.length,
        itemBuilder: (context, index) {
          Assets asset = assetList[index];

          return PanelEquipmentCard(
            asset: asset,
          );
        },
      ),
    );
  }
}
