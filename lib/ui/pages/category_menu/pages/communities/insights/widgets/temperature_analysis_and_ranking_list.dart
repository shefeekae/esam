import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/site/get_insight_visulization_model.dart';
import 'package:nectar_assets/core/schemas/site_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../../core/enums/insights_enum.dart';
import '../../../../../../../core/models/communities/community_hierarchy_args_model.dart';
import '../../../../../../../core/models/insights/insights_dropdown_model.dart';
import '../../../../../../../core/schemas/common_schemas.dart';
import '../../../../../../shared/widgets/cards/status_cards.dart';
import '../../../../../../shared/widgets/container_with_text.dart';
import '../communites_insights_screen.dart';

class TemperatureAnalysisStatusCardsAndRankingList extends StatelessWidget {
  TemperatureAnalysisStatusCardsAndRankingList(
      {required this.startDate,
      required this.endDate,
      required this.siteId,
      required this.entity,
      super.key});

  final DateTime startDate;
  final DateTime endDate;
  final String siteId;
  final Map<String, dynamic> entity;
  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    String formatedStartDate = DateFormat("dd MMM yyyy").format(startDate);
    String formatedEndDate = DateFormat("dd MMM yyyy").format(endDate);

    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
            rereadPolicy: true,
            query: SiteSchema.getSiteInsightVisualization,
            variables: {
              "data": {
                "dateRange": {
                  "startTime": startDate.millisecondsSinceEpoch,
                  "endTime": endDate.millisecondsSinceEpoch
                },
                "siteId": siteId,
              }
            }),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              child: BgContainer(
                title:
                    "Temperature Analysis Consolidation from $formatedStartDate to $formatedEndDate",
                child: SizedBox(
                  height: 80.sp,
                  child: BuildShimmerLoadingWidget(
                    scrollDirection: Axis.horizontal,
                    height: 70.sp,
                    width: 120.sp,
                    padding: 10,
                  ),
                ),
              ),
            );
          }

          GetSiteInsightVisualization? getSiteInsightVisualization =
              GetSiteInsightVisualizationModel.fromJson(result.data ?? {})
                  .getSiteInsightVisualization;

          Consolidation? consolidation =
              getSiteInsightVisualization?.consolidation;

          List list = [
            {
              "title": "Average Return Temperature",
              "value": consolidation?.avgTemperature ?? 0,
              "unit": "°C",
            },
            {
              "title": "Average Set Point Temperature",
              "value": consolidation?.avgSetpoint ?? 0,
              "unit": "°C",
            },
            {
              "title": "Average Variance",
              "value": consolidation?.avgVariance ?? 0,
            },
            {
              "title": "COP",
              "value": consolidation?.cop ?? 0,
            },
          ];

          var spaceCoolingRank =
              getSiteInsightVisualization?.spaceCoolingRank ?? [];

          var equipmentMaintenanceRank =
              getSiteInsightVisualization?.equipmentMaintenanceRank ?? [];

          List<SpaceCoolingRank> spaces = spaceCoolingRank.length > 5
              ? spaceCoolingRank.take(5).toList()
              : spaceCoolingRank;

          return Column(
            children: [
              buildStatusCards(formatedStartDate, formatedEndDate, list),
              buildRankList(
                  context, formatedStartDate, formatedEndDate, spaces),
              buildEquipmentRank(
                  formatedStartDate, formatedEndDate, equipmentMaintenanceRank),
            ],
          );
        });
  }

  // ==============================================================================

  Widget buildEquipmentRank(String formatedStartDate, String formatedEndDate,
      List<EquipmentMaintenanceRank> equipmentMaintenanceRank) {
    if (equipmentMaintenanceRank.isEmpty) {
      return const SizedBox();
    }

    List<EquipmentMaintenanceRank> equipments =
        equipmentMaintenanceRank.length > 5
            ? equipmentMaintenanceRank.take(5).toList()
            : equipmentMaintenanceRank;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      child: BgContainer(
        title: "Equipment Rank from $formatedStartDate to $formatedEndDate",
        child: Column(
          children: List.generate(
            equipments.length,
            (index) {
              var equipment = equipments[index];

              return QueryWidget(
                  options: GraphqlServices().getQueryOptions(
                      rereadPolicy: true,
                      query: CommonSchema.getSearchData,
                      variables: {
                        "data": {
                          "type": "Equipment",
                          "keys": ["identifier"],
                          "limit": 20,
                          "page": 1,
                          "value": equipment.id,
                          "domain": userData.domain
                        }
                      }),
                  builder: (result, {fetchMore, refetch}) {
                    return ListTile(
                      onTap: () {},
                      minLeadingWidth: 10,
                      leading: ContainerWithTextWidget(
                        value: "${index + 1}",
                        fontSize: 8.sp,
                      ),
                      title: Builder(builder: (context) {
                        if (result.isLoading) {
                          return const Skeletonizer(
                              enabled: true, child: Text("Loading......."));
                        }

                        return Text(equipment.name ?? "");
                      }),
                      subtitle: Builder(builder: (context) {
                        if (result.isLoading) {
                          return const Skeletonizer(
                              enabled: true, child: Text("Loading......."));
                        }

                        String sourceTagPath = result.data?['getSearchData']?[0]
                                ?['equipment']?['data']?['sourceTagPath'] ??
                            "";

                        String decodedString = sourceTagPath.isEmpty
                            ? ""
                            : Uri.decodeComponent(sourceTagPath);

                        List path = jsonDecode(
                            decodedString.isEmpty ? "[]" : decodedString);

                        return Text(
                          path.map((e) => e['name'] ?? "").toList().join(" - "),
                          style: TextStyle(
                            fontSize: 6.sp,
                          ),
                        );
                      }),
                      trailing: ContainerWithTextWidget(
                        value:
                            "COP  ${equipment.value?.toStringAsFixed(2) ?? 0}",
                        fontSize: 10.sp,
                      ),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }

  // ====================================================================================================

  Widget buildRankList(
    BuildContext context,
    String formatedStartDate,
    String formatedEndDate,
    List<SpaceCoolingRank> spaces,
  ) {
    if (spaces.isEmpty) {
      return SizedBox();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      child: BgContainer(
        title: "Space Rank from $formatedStartDate to $formatedEndDate",
        child: Column(
          children: List.generate(
            spaces.length,
            (index) {
              var space = spaces[index];

              return ListTile(
                // onTap: () {},
                minLeadingWidth: 10,
                leading: ContainerWithTextWidget(
                  value: "${index + 1}",
                  fontSize: 8.sp,
                ),
                title: buildSearchDataQueryWidget(
                  context: context,
                  space: space,
                  type: "Space",
                ),
                trailing: ContainerWithTextWidget(
                  value: "COP  ${space.value?.toStringAsFixed(2) ?? 0}",
                  fontSize: 10.sp,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildStatusCards(
      String formatedStartDate, String formatedEndDate, List<dynamic> list) {
    bool allValuesZero = list.every((element) => element['value'] == 0);

    if (allValuesZero) {
      return SizedBox();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      child: BgContainer(
        title:
            "Temperature Analysis Consolidation from $formatedStartDate to $formatedEndDate",
        child: SizedBox(
          height: 80.sp,
          child: ListView.separated(
            padding: EdgeInsets.all(7.sp),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = list[index];

              String title = data['title'];
              num value = data['value'];
              String unit = data['unit'] ?? "";

              return StatusCard(
                title: title,
                value: "${value.toStringAsFixed(1)} $unit",
                color: Theme.of(context).primaryColor,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 5.sp);
            },
            itemCount: list.length,
          ),
        ),
      ),
    );
  }

  // ===========================================================================

  QueryWidget buildSearchDataQueryWidget({
    required SpaceCoolingRank space,
    required String type,
    required BuildContext context,
  }) {
    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
            rereadPolicy: true,
            query: CommonSchema.getSearchData,
            variables: {
              "data": {
                "type": type,
                "keys": ["identifier"],
                "limit": 20,
                "page": 1,
                "value": space.id,
                "domain": userData.domain,
              }
            }),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Skeletonizer(
              enabled: true,
              child: Text("Loading...."),
            );
          }

          String title;

          Map<String, dynamic> space = {};

          try {
            if (type == "Space") {
              space = result.data?['getSearchData']?[0]?['space'];

              title = result.data?['getSearchData']?[0]?['space']?['data']
                      ?['name'] ??
                  "";
            } else {
              title = result.data?['getSearchData']?[0]?['equipment']?['data']
                      ?['displayName'] ??
                  "";
            }
          } catch (e) {
            title = "";
          }

          return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  CommunityHierarchyScreen.id,
                  arguments: CommunityHierarchyArgs(
                    insights: Insights.space,
                    dropdownData: CommunityHierarchyDropdownData(
                      parentEntity: entity,
                      displayName: space["data"]?["name"] ?? "",
                      typeName: space["data"]?["typeName"] ?? "",
                      entity: {
                        "type": space['type'],
                        "data": {
                          "domain": space["data"]?["domain"],
                          "identifier": space["data"]?["identifier"],
                          "name": space["data"]?["name"],
                        }
                      },
                      identifier: space["data"]?["identifier"] ?? "",
                    ),
                  ),
                );
              },
              child: Text(title));
        });
  }

  // final Map<String, dynamic> dummyData = {
  //   "getSiteInsightVisualization": {
  //     "equipment": null,
  //     "space": null,
  //     "site": {"name": null, "type": "site", "identifier": null},
  //     "consolidation": {
  //       "avgTemperature": 24.59771358111891,
  //       "avgSetpoint": 20.902862106412524,
  //       "avgVariance": 4.00109502342446,
  //       "cop": 0,
  //       "coolingIndex": 0
  //     },
  //     "analysis": null,
  //     "durationDistribution": null,
  //     "varianceDistribution": null
  //   }
  // };
}
