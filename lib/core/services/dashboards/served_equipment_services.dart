// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nectar_assets/core/models/dashboard/serving_to_equipments_model.dart';
import 'package:nectar_assets/core/schemas/dashboard_schema.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:collection/collection.dart';
import 'package:nectar_assets/core/models/asset/get_asset_additional_data_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';

class ServedEquipmentServices {
  final UserDataSingleton userData = UserDataSingleton();

  // ============================================================================
  // The first Api calling for getting the asset basic details like name, type and location etc.
  // The second Api calling for the getting the asset additional details like alarms count and critical points etc

  Future<List<BuildingEquipmentsData>> getEquipmentDataWithAdditionalList({
    required String identifier,
    String searchValue = "",
  }) async {
    var assetsResult = await GraphqlServices().performQuery(
      query: DashboardSchema.listServingToAssetsWithLatestData,
      variables: {
        "data": {
          "entity": {
            "type": "LVPMeter",
            "data": {
              "domain": userData.domain,
              "identifier": identifier,
            }
          },
          "limit": 10,
          "page": 1,
          "searchKey": "displayName",
          "searchValue": searchValue,
        }
      },
    );

    ServingToEquipmentModel servingToEquipmentModel =
        ServingToEquipmentModel.fromJson(assetsResult.data ?? {});

    List<Assets> assets =
        servingToEquipmentModel.listServingToAssetsWithLatestData?.assets ?? [];

    var additionalDataResult = await GraphqlServices().performQuery(
      query: AssetSchema.getAssetAdditionalData,
      variables: {
        "assets": assets.map((e) {
          return {
            "type": e.type,
            "data": {
              "identifier": e.identifier,
              "domain": e.domain,
            }
          };
        }).toList(),
      },
    );

    List<BuildingEquipmentsData> list = [];

    List<GetAssetAdditionalData> additionalDataList =
        GetAssetAdditionalDataModel.fromJson(additionalDataResult.data ?? {})
                .getAssetAdditionalData ??
            [];

    for (var element in assets) {
      var additionalData = additionalDataList
          .singleWhereOrNull((e) => e.asset?.identifier == element.identifier);

      List<Points> points = element.points?.where((element) {
            var criticalPoints = additionalData?.criticalPoints ?? [];

            return criticalPoints.any((item) {
              return item.data?.pointName == element.pointName;
            });
          }).toList() ??
          [];

      if (additionalData != null) {
        list.add(
          BuildingEquipmentsData(
            displayName: element.displayName ?? "",
            locationName:
                element.path?.map((e) => e.name ?? "").toList().join(" - ") ??
                    "",
            type: element.type ?? "",
            eventCount: additionalData.eventCount,
            points: points,
            operationStatus: element.operationStatus ?? "",
            domain: element.domain ?? "",
            typeName: element.type ?? "",
            identifier: element.identifier ?? "",
          ),
        );
      } else {
        list.add(
          BuildingEquipmentsData(
            displayName: element.displayName ?? "",
            locationName:
                element.path?.map((e) => e.name ?? "").toList().join(" - ") ??
                    "",
            type: element.type ?? "",
            eventCount: null,
            points: points,
            operationStatus: element.operationStatus ?? "",
            domain: element.domain ?? "",
            typeName: element.type ?? "",
            identifier: element.identifier ?? "",
          ),
        );
      }
    }

    return list;
  }
}

class BuildingEquipmentsData {
  final String displayName;
  final String locationName;
  final String typeName;
  final String type;
  final String domain;
  final EventCount? eventCount;
  final List<Points> points;
  final String operationStatus;
  final String identifier;

  BuildingEquipmentsData({
    required this.displayName,
    required this.locationName,
    required this.typeName,
    required this.eventCount,
    required this.points,
    required this.operationStatus,
    required this.domain,
    required this.type,
    required this.identifier,
  });
}
