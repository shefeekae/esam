import 'package:app_filter_form/app_filter_form.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/core/models/asset/assets_list_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:secure_storage/secure_storage.dart';
import '../../enums/equipment_enums.dart';
import '../../models/asset/list_served_by_equipments_model.dart';
import '../../models/asset/list_served_to_equipments_model.dart';

class AssetsPaginationServices {
  UserDataSingleton userData = UserDataSingleton();

  getPaginatedAssetsList({
    required int pageKey,
    required PayloadManagementBloc payloadManagementBloc,
    required PagingController pagingController,
    Map<String, dynamic> additionalPayload = const {},
  }) async {
    Map<String, dynamic> filter = {
      "offset": pageKey,
      "pageSize": 10,
      // "order": "asc",
      "searchLabel": "",
      "domain": userData.domain,
    };

    if (additionalPayload.isNotEmpty) {
      filter.addAll(additionalPayload);
    }

    var filterAppliedPayload = payloadManagementBloc.state.payload;

    filter.addAll(filterAppliedPayload);

    var result = await GraphqlServices().performQuery(
      query: AssetSchema.getAssetList,
      variables: {
        "filter": filter,
      },
    );

    if (result.hasException) {
      pagingController.error = result.exception;

      if (kDebugMode) {
        print("exception: ${result.exception}");
      }
      return;
    }

    var listAssets = AssetsListModel.fromJson(result.data ?? {});
    // var listAssets = AssetsListModel.fromJson(assetData);

    int? totalCount = listAssets.getAssetList?.totalAssetsCount;

    var assetList = listAssets.getAssetList?.assets ?? [];

    if (totalCount == null) {
      pagingController.appendLastPage(assetList);

      return;
    }

    var totalItems = pagingController.itemList ?? [];

    int totalValuesCount = totalItems.length + assetList.length;

    if (totalValuesCount == totalCount) {
      pagingController.appendLastPage(assetList);
    } else if (assetList.isEmpty) {
      pagingController.appendLastPage([]);
    } else {
      pagingController.appendPage(
        assetList,
        pageKey + 1,
      );
    }
  }

// ==================================================================================================

  getPaginatedServedByORServedToAssetsList({
    required int pageKey,
    required PagingController pagingController,
    required ConnectedEquipments connectedEquipment,
    Map<String, dynamic> assetEntity = const {},
  }) async {
    Map<String, dynamic> filter = {
      "entity": assetEntity,
      "page": pageKey,
      "limit": 10,
      "searchKey": "displayName",
      "searchValue": "",
    };

    var result = await GraphqlServices().performQuery(
      query: connectedEquipment == ConnectedEquipments.servedByEquipments
          ? AssetSchema.listServedByAssetsWithLatestData
          : AssetSchema.listServingToAssetsWithLatestData,
      variables: {
        "data": filter,
      },
    );

    if (result.hasException) {
      pagingController.error = result.exception;

      if (kDebugMode) {
        print("exception: ${result.exception}");
      }
      return;
    }

    int? totalCount;
    List<Assets> assetList = [];

    if (connectedEquipment == ConnectedEquipments.servedByEquipments) {
      var model =
          ListServedByAssetsWithLatestDataModel.fromJson(result.data ?? {});

      totalCount = model.listServedByAssetsWithLatestData?.totalAssetsCount;

      assetList = model.listServedByAssetsWithLatestData?.assets?.map((e) {
            return Assets.fromJson(e.toJson());
          }).toList() ??
          [];
    } else if (connectedEquipment == ConnectedEquipments.servedToEquipments) {
      var model =
          ListServingToAssetsWithLatestDataModel.fromJson(result.data ?? {});

      totalCount = model.listServingToAssetsWithLatestData?.totalAssetsCount;

      assetList = model.listServingToAssetsWithLatestData?.assets?.map((e) {
            return Assets.fromJson(e.toJson());
          }).toList() ??
          [];
    }

    if (totalCount == null) {
      pagingController.appendLastPage(assetList);

      return;
    }

    var totalItems = pagingController.itemList ?? [];

    int totalValuesCount = totalItems.length + assetList.length;

    if (totalValuesCount == totalCount) {
      pagingController.appendLastPage(assetList);
    } else if (assetList.isEmpty) {
      pagingController.appendLastPage([]);
    } else {
      pagingController.appendPage(
        assetList,
        pageKey + 1,
      );
    }
  }
}
