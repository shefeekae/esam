

import 'package:flutter/foundation.dart';
import 'package:secure_storage/secure_storage.dart';

import '../../models/asset/assets_list_model.dart';
import '../../schemas/assets_schema.dart';
import '../graphql_services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AffectedEquipmentServices {



   UserDataSingleton userData = UserDataSingleton();

  getPaginatedAssetsList({
    required int pageKey,
    required PagingController pagingController,
    required Map<String,dynamic> extraPayload,
  }) async {
    Map<String, dynamic> filter = {
      "offset": 1,
      "pageSize": 10,
      "order": "asc",
      "searchLabel": "",
      "domain": userData.domain,
    };

    // var filterAppliedPayload = payloadManagementBloc.state.payload;

    filter.addAll(extraPayload);

    // payload['filter']['offset'] = pageKey;

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
  
}