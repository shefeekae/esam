// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/models/communities/list_all_communities_model.dart';
import 'package:nectar_assets/core/models/dashboard/submeter_model.dart';
import 'package:nectar_assets/core/models/dashboard/utilities_space_distribution_data_model.dart';
import 'package:nectar_assets/core/models/site/find_all_buildings_model.dart';
import 'package:nectar_assets/core/models/space/list_all_space_model.dart';
import 'package:nectar_assets/core/models/sub_community/find_all_sub_communities_modle.dart';
import 'package:nectar_assets/core/schemas/dashboard_schema.dart';
import 'package:nectar_assets/core/schemas/site_schema.dart';
import 'package:nectar_assets/core/schemas/space_schema.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:nectar_assets/core/schemas/communities_schema.dart';
import 'package:nectar_assets/core/schemas/sub_communities_schema.dart';
import '../../models/insights/insights_dropdown_model.dart';

class DropdownHierarchyServices {
  final UserDataSingleton userData = UserDataSingleton();

  // =========================================================================
  // Query Method

  String getDropdownQueryMethod(Level dropdownType) {
    switch (dropdownType) {
      case Level.community:
        return CommunitySchemas.listAllCommunities;

      case Level.subCommunity:
        return SubCommunitySchema.findAllSubCommunities;

      case Level.site:
        return SiteSchema.findAllBuildings;

      case Level.space:
        return SpaceSchema.listAllSpacesPagination;

      case Level.equipment:
        return DashboardSchema.getSubMetersList;

      case Level.subMeter:
        return DashboardSchema.getUtilitiesSpaceDistributionData;

      default:
        return "";
    }
  }

// ===========================================================================
// Payload

  Map<String, dynamic> getDropdownQueryPayload(
    Level dropdownType, {
    String? communityDomain,
    Map<String, dynamic>? parentEntity,
      String? currentYear,
    String? previousYear,
    
  }) {
    // print("Site entity $entity");

    switch (dropdownType) {
      case Level.community:
        return {
          "domain": userData.domain,
        };

      case Level.subCommunity:
        return {
          "domain": communityDomain,
        };

      case Level.site:
        return {
          "domain": userData.domain,
          "subCommunities": [parentEntity]
        };

      case Level.space:
        return {
          "data": {
            "domain": userData.domain,
            "type": "",
            "site": [
              parentEntity,
            ]
          }
        };

      case Level.equipment:
        return {
          "site": parentEntity,
        };

      case Level.subMeter:
        return {
           "data": {
            "equipment": parentEntity,
            "currentYear": currentYear,
            "previousYear": previousYear,
            "meterType": "LVPMeter",
          }
        };

      default:
        return {};
    }
  }
// =============================================================================

  List<CommunityHierarchyDropdownData> getDrodpdownValues({
    required Map<String, dynamic> resultData,
    required Level dropdownType,
  }) {
    switch (dropdownType) {
      case Level.community:
        ListAllCommunitiesModel listAllCommunitiesModel =
            ListAllCommunitiesModel.fromJson(resultData);

        List<Community> community =
            listAllCommunitiesModel.listAllCommunities ?? [];

        return community.map((e) {
          return CommunityHierarchyDropdownData(
              parentEntity: null,
              displayName: e.data?.clientName ?? "",
              typeName: e.data?.typeName,
              locationName: e.data?.locationName,
              defaultValue: e.data?.defaultValue,
              identifier: e.data?.identifier ?? "",
              entity: {
                "type": e.type,
                "data": {
                  "domain": e.data?.domain,
                  "identifier": e.data?.identifier,
                  "name": e.data?.clientName
                }
              });
        }).toList();

      case Level.subCommunity:
        FindAllSubCommunitiesModel findAllSubCommunitiesModel =
            FindAllSubCommunitiesModel.fromJson(resultData);

        List<FindAllSubCommunities> subCommunity =
            findAllSubCommunitiesModel.findAllSubCommunities ?? [];

        return subCommunity.map((e) {
          String displayName = e.data?.displayName ?? "";

          String name = e.data?.name ?? "";

          return CommunityHierarchyDropdownData(
              parentEntity: null,
              displayName: displayName.isEmpty ? name : displayName,
              typeName: e.data?.typeName,
              locationName: e.data?.locationName,
              identifier: e.data?.identifier ?? "",
              entity: {
                "type": e.type,
                "data": {
                  "domain": e.data?.domain,
                  "identifier": e.data?.identifier,
                  "name": displayName.isEmpty ? name : displayName,
                }
              });
        }).toList();

      case Level.site:
        SitesModel sitesModel = SitesModel.fromJson(resultData);

        List<FindAllBuildings> sites = sitesModel.findAllBuildings ?? [];

        return sites.map((e) {
          String displayName = e.data?.displayName ?? "";

          String name = e.data?.name ?? "";

          return CommunityHierarchyDropdownData(
              parentEntity: null,
              displayName: displayName.isEmpty ? name : displayName,
              locationName: e.data?.location ?? "",
              typeName: e.data?.typeName,
              entity: {
                "type": e.type,
                "data": {
                  "domain": e.data?.domain,
                  "identifier": e.data?.identifier,
                  "name": displayName.isEmpty ? name : displayName,
                }
              },
              identifier: e.data?.identifier ?? "");
        }).toList();

      case Level.space:
        SpaceModel spaceModel = SpaceModel.fromJson(resultData);

        List<ListAllSpacesPagination> spaces =
            spaceModel.listAllSpacesPagination ?? [];

        return spaces.map((e) {
          String displayName = e.space?.data?.name ?? "";

          return CommunityHierarchyDropdownData(
              parentEntity: null,
              displayName: displayName,
              typeName: e.space?.data?.typeName,
              entity: {
                "type": e.space?.type,
                "data": {
                  "domain": e.space?.data?.domain,
                  "identifier": e.space?.data?.identifier,
                  "name": displayName,
                }
              },
              identifier: e.space?.data?.identifier ?? "");
        }).toList();

      case Level.equipment:
        SubMeterModel subMeterModel = SubMeterModel.fromJson(resultData);

        List<GetSubMetersList> subMeterList =
            subMeterModel.getSubMetersList ?? [];

        return subMeterList.map((e) {
          String displayName = e.child?.data?.displayName ?? "";

          String name = e.child?.data?.name ?? "";

          return CommunityHierarchyDropdownData(
              parentEntity: null,
              displayName: displayName.isEmpty ? name : displayName,
              typeName: e.child?.data?.typeName,
              entity: {
                "type": e.child?.type,
                "data": {
                  "domain": e.child?.domain,
                  "identifier": e.child?.identifier,
                  "name": displayName.isEmpty ? name : displayName,
                }
              },
              identifier: e.child?.identifier ?? "");
        }).toList();

      case Level.subMeter:
        UtilitiesSpaceDistributionDataModel utilitiesSpaceDistributionData =
            UtilitiesSpaceDistributionDataModel.fromJson(resultData);

        List<GetUtilitiesSpaceDistributionData>
            utilitiesSpaceDistributionDatalist =
            utilitiesSpaceDistributionData.getUtilitiesSpaceDistributionData ??
                [];

        return utilitiesSpaceDistributionDatalist.map((e) {
          return CommunityHierarchyDropdownData(
              displayName: e.label ?? "",
              entity: {
                "type": e.data?.type,
                "data": {
                  "domain": e.data?.data?.domain ?? "",
                  "identifier": e.data?.data?.identifier ?? "",
                  "name": e.label ?? "",
                }
              },
              typeName: e.data?.data?.typeName,
              identifier: e.data?.data?.identifier ?? "",
              parentEntity: null);
        }).toList();

      default:
        return [];
    }
  }

// =============================================================================
// Get App Bar Title

  // String getAppBarTitle(Level insights) {
  //   switch (insights) {
  //     case Level.community:
  //       return "Community Insights";

  //     case Level.subCommunity:
  //       return "SubCommunity Insights";
  //     default:
  //       return "Insights";
  //   }
  // }
}
