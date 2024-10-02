import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/models/asset/assets_list_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/list/widgets/equipment_card.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../utils/constants/colors.dart';

class AssetSearchDelegate extends SearchDelegate {
  final UserDataSingleton userData = UserDataSingleton();
  final Map<String, dynamic> extraPayload;

  AssetSearchDelegate({this.extraPayload = const {}});

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
            ...extraPayload,
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
