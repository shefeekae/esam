// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/schemas/common_schemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/shared/functions/converters.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';
import '../../../../../../../core/enums/insights_enum.dart';
import '../../../../../../../core/models/communities/community_hierarchy_args_model.dart';
import '../../../../../../../core/models/insights/insights_dropdown_model.dart';
import '../../../equipments/details/equipment_details.dart';
import '../communites_insights_screen.dart';
import 'package:collection/collection.dart';

class EnergyConsumptionSpaceDistributionChart extends StatelessWidget {
  const EnergyConsumptionSpaceDistributionChart({
    required this.startDate,
    required this.endDate,
    required this.entity,
    this.insights,
    this.communityId,
    Key? key,
  }) : super(key: key);

  final int startDate;
  final int endDate;
  final Map<String, dynamic> entity;
  final Insights? insights;
  final String? communityId;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "forCost": false,
      "meterType": "LVPMeter",
      "startDate": startDate,
      "endDate": endDate,
    };

    if (insights == Insights.community) {
      data['community'] = entity['data']?['identifier'];
    } else if (insights == Insights.subCommunity) {
      data['subCommunity'] = entity;
    } else if (insights == Insights.site) {
      data['site'] = entity;
    }

    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
          query: CommonSchema.getUtilitiesSpaceDistributionData,
          variables: {
            "data": data,
          },
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return BgContainer(
              title: "Energy Consumption Space Distribution",
              child: Padding(
                padding: EdgeInsets.all(5.sp),
                child: ShimmerLoadingContainerWidget(
                  height: 30.sp,
                ),
              ),
            );
          }

          List dataList =
              result.data?['getUtilitiesSpaceDistributionData'] ?? [];

          if (dataList.isEmpty) {
            return const SizedBox();
          }

          dataList.removeWhere((element) => element?['value'] == 0);

          List<TreeMapData> list = dataList.map((e) {
            num count = e?['value'] ?? 0;
            String name = e?['label'] ?? "";

            return TreeMapData(
              name: name,
              value: count.toDouble(),
            );
          }).toList();

          // list.sort(
          //   (a, b) => b.value.compareTo(a.value),
          // );

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.sp),
            child: BgContainer(
              title: "Energy Consumption Space Distribution",
              child: Padding(
                padding: EdgeInsets.all(6.sp),
                child: SfTreemap(
                    legend: const TreemapLegend(
                      position: TreemapLegendPosition.bottom,
                      overflowMode: TreemapLegendOverflowMode.scroll,
                    ),
                    tooltipSettings: const TreemapTooltipSettings(),
                    weightValueMapper: (index) {
                      return list[index].value;
                    },
                    dataCount: list.length,
                    levels: [
                      TreemapLevel(
                        groupMapper: (index) {
                          return list[index].name;
                        },
                        labelBuilder: (BuildContext context, TreemapTile tile) {
                          return Padding(
                            padding: EdgeInsets.all(2.sp),
                            child: Text(
                              tile.group,
                              style: TextStyle(
                                color: ThemeServices().isLightColor(tile.color)
                                    ? kBlack
                                    : kWhite,
                              ),
                            ),
                          );
                        },
                        itemBuilder: (context, tile) {
                          return GestureDetector(
                            onDoubleTap: () {
                              if (insights == null) {
                                return;
                              }

                              if (insights == Insights.community ||
                                  insights == Insights.subCommunity) {
                                Map<String, dynamic> data =
                                    dataList.singleWhereOrNull((element) =>
                                        element?['data']?['data']
                                            ?['displayName'] ==
                                        tile.group);

                                String id =
                                    data['data']?['data']?['identifier'] ?? "";
                                String displayName =
                                    data['data']?['data']?['displayName'] ?? "";
                                String locationName = data['data']?['data']
                                        ?['locationName'] ??
                                    "";
                                String typeName =
                                    data['data']?['data']?['typeName'] ?? "";
                                String? type = data['data']?['type'] ?? "";
                                String? domain =
                                    data['data']?['data']?['domain'];

                                Navigator.of(context).pushNamed(
                                  CommunityHierarchyScreen.id,
                                  arguments: CommunityHierarchyArgs(
                                    insights: getInsights(insights!),
                                    communityIdentifier: communityId,
                                    initialDateTimeRange: DateTimeRange(
                                        start:
                                            DateTime.fromMillisecondsSinceEpoch(
                                                startDate),
                                        end:
                                            DateTime.fromMillisecondsSinceEpoch(
                                                endDate)),
                                    dropdownData:
                                        CommunityHierarchyDropdownData(
                                          parentEntity: entity,
                                      identifier: id,
                                      displayName: displayName,
                                      locationName: locationName,
                                      typeName: typeName,
                                      entity: {
                                        "type": type,
                                        "data": {
                                          "domain": domain,
                                          "identifier": id,
                                          "name": displayName,
                                        }
                                      },
                                    ),
                                  ),
                                );
                              } else if (insights == Insights.site) {
                                Map<String, dynamic> data =
                                    dataList.singleWhereOrNull((element) =>
                                        element?['data']?['data']
                                            ?['displayName'] ==
                                        tile.group);

                                String identifier =
                                    data['data']?['data']?['identifier'] ?? "";
                                String displayName =
                                    data['data']?['data']?['displayName'] ?? "";

                                String? type = data['data']?['type'] ?? "";
                                String? domain =
                                    data['data']?['data']?['domain'];

                                Navigator.of(context).pushNamed(
                                    EquipmentDetailsScreen.id,
                                    arguments: {
                                      "type": type,
                                      "displayName": displayName,
                                      "domain": domain,
                                      "identifier": identifier,
                                    });
                              }
                            },
                          );
                        },
                        tooltipBuilder: (context, tile) {
                          String formatedText =
                              Converter().formatNumber(tile.weight);

                          return Padding(
                            padding: EdgeInsets.all(3.sp),
                            child: Text(
                              "$formatedText Kwh",
                              style: TextStyle(
                                color: Brightness.dark ==
                                        Theme.of(context).brightness
                                    ? kBlack
                                    : kWhite,
                              ),
                            ),
                          );
                        },
                      ),
                    ]),
              ),
            ),
          );
        });
  }

  Insights getInsights(Insights insights) {
    switch (insights) {
      case Insights.community:
        return Insights.subCommunity;
      case Insights.subCommunity:
        return Insights.site;

      case Insights.site:
      case Insights.space:
        return insights;
    }
  }
}

class TreeMapData {
  String name;
  double value;
  TreeMapData({
    required this.name,
    required this.value,
  });
}
