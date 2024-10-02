import 'package:nectar_assets/core/models/asset/equipment_consoldation_model.dart';
import 'package:secure_storage/secure_storage.dart';

import '../../schemas/assets_schema.dart';
import '../graphql_services.dart';

class EquipmentConsoldationServices {
  final UserDataSingleton userData = UserDataSingleton();

  // ==========================================================================

  Future<Map<String, dynamic>> getData({
    required Map<String, dynamic> payload,
  }) async {
    Map<String, dynamic> map = {
      // "entity": {
      //   "type": "DefaultTenant",
      //   "data": {"domain": "nectarit", "identifier": "nectarfm"}
      // },
      "domain": userData.domain,
      // "criticalities": ["HIGH"],
      // "startDate": 1701455400000,
      // "endDate": 1708021799999,
      "facetField": "sourceName",
      // "status": ["resolved"]
    };

    map.addAll(payload);

    Map<String, dynamic> resolvedMapData =
        await getTotalEventConsolidationData(map: map, isActive: false);
    Map<String, dynamic> activeMapData =
        await getTotalEventConsolidationData(map: map, isActive: true);

    // print("Active data length: ${activeData.length}");

    // print("resolved data length: ${resolvedData.length}");

    // List allData = [...activeData, ...resolvedData];

    List<EquipmentConsoldationModel> equipmentConsoldationList = [];

    activeMapData.forEach((key, value) {
      if (resolvedMapData.containsKey(key)) {
        equipmentConsoldationList.add(
          EquipmentConsoldationModel(
            assetName: key,
            activeCount: value,
            resolvedCount: resolvedMapData[key],
          ),
        );
      } else {
        equipmentConsoldationList.add(
          EquipmentConsoldationModel(
            assetName: key,
            activeCount: value,
            resolvedCount: 0,
          ),
        );
      }
    });

    // Iterate over resolvedMapData to find keys not present in ac
    resolvedMapData.forEach((key, value) {
      if (!activeMapData.containsKey(key)) {
        equipmentConsoldationList.add(EquipmentConsoldationModel(
          assetName: key,
          activeCount: 0,
          resolvedCount: value,
        ));
      }
    });

    return {
      "list": equipmentConsoldationList,
      "activeTotalCount": calculateSum(activeMapData),
    };
  }

  // ===========================================================================
  //

  int calculateSum(Map<String, dynamic> data) {
    int sum = 0;
    for (var value in data.values) {
      if (value is int) {
        sum += value;
      }
    }
    return sum;
  }

  // ===========================================================================
  // This

  Future<Map<String, dynamic>> getTotalEventConsolidationData({
    required Map<String, dynamic> map,
    required bool isActive,
  }) async {
    if (isActive) {
      map['status'] = ["active"];
    } else {
      map['status'] = ["resolved"];
    }

    var result = await GraphqlServices().performQuery(
      query: AssetSchema.getTotalEventConsolidation,
      variables: {"data": map},
    );

    Map<String, dynamic> responseMap =
        result.data?['getTotalEventConsolidation']?['responseMap'] ?? {};

    return responseMap;
  }
}
