import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/models/communities/community_heirarchy_map_model.dart';
import 'package:nectar_assets/core/models/communities/community_hierarchy_args_model.dart';
import 'package:nectar_assets/core/models/insights/insights_dropdown_model.dart';
import 'package:nectar_assets/core/schemas/site_schema.dart';
import 'package:nectar_assets/core/schemas/sub_communities_schema.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/communites_insights_screen.dart';
import 'package:secure_storage/secure_storage.dart';
import '../../models/site/list_all_site_has_alarms_model.dart';
import '../../models/sub_community/list_all_site_groups_has_alarm_model.dart';
import '../assets/assets_services.dart';

class CommunityHirearchyMapServices {
  final UserDataSingleton userData = UserDataSingleton();

// =============================================================================

  String getQueryMehod(Insights insights) {
    switch (insights) {
      case Insights.community:
        return SubCommunitySchema.listAllSiteGroupsHasAlarm;

      case Insights.subCommunity:
        return SiteSchema.listAllSitesHasAlarm;

      default:
        return "";
    }
  }

// =============================================================================

  Map<String, dynamic> getVariables(
    Insights insights, {
    required Map<String, dynamic> entity,
  }) {
    String identifier = entity['data']?['identifier'];

    switch (insights) {
      case Insights.community:
        return {
          "domain": identifier,
        };

      case Insights.subCommunity:
        return {
          "siteGroup": {
            "domain": userData.domain,
            "type": "Site",
            "subCommunity": entity,
          }
        };
      default:
        return {};
    }
  }

// =============================================================================

  List<CommunityHeirarchyMapDataModel> getMapData(
    Insights insights, {
    required Map<String, dynamic> resultData,
    required Map<String, dynamic> entity,
  }) {
    switch (insights) {
      case Insights.community:
        List<ListAllSiteGroupsHasAlarm> list =
            ListAllSiteGroupsHasAlarmModel.fromJson(resultData)
                    .listAllSiteGroupsHasAlarm ??
                [];

        return list.map((e) {
          String displayName = e.data?.displayName ?? "";

          return CommunityHeirarchyMapDataModel(
            location: e.data?.location,
            communityHierarchyArgs: CommunityHierarchyArgs(
              insights: Insights.subCommunity,
              communityIdentifier: entity['data']?['identifier'],
              dropdownData: CommunityHierarchyDropdownData(
                parentEntity: entity,
                identifier: e.data?.identifier ?? "",
                displayName:
                    displayName.isNotEmpty ? displayName : e.data?.name ?? "",
                locationName: e.data?.locationName,
                typeName: e.data?.typeName,
                entity: {
                  "type": e.type,
                  "data": {
                    "domain": e.data?.domain,
                    "identifier": e.data?.identifier,
                    "name": e.data?.displayName ?? e.data?.name ?? "",
                  }
                },
              ),
            ),
          );
        }).toList();

      case Insights.subCommunity:
        ListAllSitesHasAlarmModel findAllSubCommunitiesModel =
            ListAllSitesHasAlarmModel.fromJson(resultData);

        List<ListAllSitesHasAlarm> allSites =
            findAllSubCommunitiesModel.listAllSitesHasAlarm ?? [];

        return allSites.map((e) {
          String displayName = e.data?.displayName ?? "";

          return CommunityHeirarchyMapDataModel(
              location: e.data?.location,
              communityHierarchyArgs: CommunityHierarchyArgs(
                insights: Insights.site,
                communityIdentifier: entity['data']?['identifier'],
                dropdownData: CommunityHierarchyDropdownData(
                  parentEntity: entity,
                  identifier: e.data?.identifier ?? "",
                  displayName:
                      displayName.isNotEmpty ? displayName : e.data?.name ?? "",
                  locationName: "",
                  typeName: e.data?.typeName,
                  entity: {
                    "type": e.type,
                    "data": {
                      "domain": e.data?.domain,
                      "identifier": e.data?.identifier,
                      "name": e.data?.displayName ?? e.data?.name ?? "",
                    }
                  },
                ),
              ));
        }).toList();

      default:
        return [];
    }
  }

//  ============================================================================

  Set<Marker> convertToMarkerData({
    required BuildContext context,
    required List<CommunityHeirarchyMapDataModel> list,
    required String communityIdentifier,
  }) {
    Set<Marker> customMarkers = {};

    for (var element in list) {
      // Map<String, dynamic> data = element?['data'] ?? {};

      String? location = element.location;

      if (location != null) {
        LatLng? latLng = AssetsServices().parseWktPoint(location);

        if (latLng != null) {
          String displayName =
              element.communityHierarchyArgs.dropdownData?.displayName ?? "";

          String identifier =
              element.communityHierarchyArgs.dropdownData?.identifier ?? "";

          customMarkers.add(
            Marker(
              markerId: MarkerId(identifier),
              position: latLng,
              infoWindow: InfoWindow(
                anchor: const Offset(2, 4),
                title: displayName,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    CommunityHierarchyScreen.id,
                    arguments: element.communityHierarchyArgs,
                  );
                },
              ),
            ),
          );
        }
      }
    }

    return customMarkers;
  }
}
