// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nectar_assets/core/models/communities/list_all_communities_model.dart';
import 'package:nectar_assets/core/models/sub_community/find_all_sub_communities_modle.dart';
import 'package:secure_storage/secure_storage.dart';

import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/schemas/communities_schema.dart';
import 'package:nectar_assets/core/schemas/sub_communities_schema.dart';

import '../../models/insights/insights_dropdown_model.dart';

class CommunityHierarchyServices {
  final UserDataSingleton userData = UserDataSingleton();

  // =========================================================================
  // Query Method

  String getDropdownQueryMethod(Insights insights) {
    switch (insights) {
      case Insights.community:
        return CommunitySchemas.listAllCommunities;

      case Insights.subCommunity:
        return SubCommunitySchema.findAllSubCommunities;

      default:
        return "";
    }
  }

// ===========================================================================
// Payload

  Map<String, dynamic> getDropdownQueryPayload(
    Insights insights, {
    String? communityDomain,
  }) {
    switch (insights) {
      case Insights.community:
        return {
          "domain": userData.domain,
        };

      case Insights.subCommunity:
        return {
          "domain": communityDomain,
        };

      default:
        return {};
    }
  }
// =============================================================================

  List<CommunityHierarchyDropdownData> getDrodpdownValues({
    required Map<String, dynamic> resultData,
    required Map<String, dynamic> entity,
    required Insights insights,
  }) {
    switch (insights) {
      case Insights.community:
        ListAllCommunitiesModel listAllCommunitiesModel =
            ListAllCommunitiesModel.fromJson(resultData);

        List<Community> community =
            listAllCommunitiesModel.listAllCommunities ?? [];

        return community.map((e) {
          return CommunityHierarchyDropdownData(
              parentEntity: entity,
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

      case Insights.subCommunity:
        FindAllSubCommunitiesModel findAllSubCommunitiesModel =
            FindAllSubCommunitiesModel.fromJson(resultData);

        List<FindAllSubCommunities> subCommunity =
            findAllSubCommunitiesModel.findAllSubCommunities ?? [];

        return subCommunity.map((e) {
          String displayName = e.data?.displayName ?? "";

          return CommunityHierarchyDropdownData(
              parentEntity: entity,
              displayName:
                  displayName.isNotEmpty ? displayName : e.data?.name ?? "",
              typeName: e.data?.typeName,
              locationName: e.data?.locationName,
              identifier: e.data?.identifier ?? "",
              entity: {
                "type": e.type,
                "data": {
                  "domain": e.data?.domain,
                  "identifier": e.data?.identifier,
                  "name": e.data?.displayName ?? e.data?.name ?? "",
                }
              });
        }).toList();

      default:
        return [];
    }
  }

// =============================================================================
// Get App Bar Title

  String getAppBarTitle(Insights insights) {
    switch (insights) {
      case Insights.community:
        return "Community Insights";

      case Insights.subCommunity:
        return "SubCommunity Insights";
      default:
        return "Insights";
    }
  }
}
