// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/models/communities/community_hierarchy_args_model.dart';
import 'package:nectar_assets/core/models/insights/insights_dropdown_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/communites_insights_screen.dart';
import 'package:nectar_assets/ui/shared/functions/converters.dart';
import 'package:nectar_assets/ui/shared/widgets/sheets/custom_modal_bottomsheet.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:nectar_assets/core/schemas/alarms_chart_schemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/widgets/chart/pie_chart_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import '../../../../../../../core/models/charts/pie_chart_model.dart';
import 'package:collection/collection.dart';

import '../../../../../../../core/services/communities/community_insights_services.dart';

class AlarmSpaceDistributionPieChart extends StatelessWidget {
  final int startDate;
  final int endDate;
  final Map<String, dynamic> entity;
  final Insights insights;
  const AlarmSpaceDistributionPieChart({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.entity,
    required this.insights,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "entity": entity,
      "startDate": startDate,
      "endDate": endDate
    };

    if (insights == Insights.community) {
      data["level"] = "SITEGROUP";
    } else if (insights == Insights.subCommunity) {
      data["level"] = "SITE";
    } else if (insights == Insights.site) {
      data['level'] = "SPACES";
    }

    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
        rereadPolicy: true,
        query: AlarmChartSchemas.getLevelBasedEventConsolidation,
        variables: {
          "data": data,
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return GrapghQlClientServices().handlingGraphqlExceptions(
            result: result,
            context: context,
            refetch: refetch,
          );
        }

        List data = result.data?['getLevelBasedEventConsolidation']
                ?['eventCounts'] ??
            [];

        if (data.isEmpty) {
          return const SizedBox();
        }

        // dummyData['getLevelBasedEventConsolidation']?['eventCounts'] ?? [];

        List<ChartData> list = data.map((e) {
          int count = e['count'] ?? 0;

          String displayName = e['entity']?['data']?['displayName'] ?? "";

          String name = e['entity']?['data']?['name'] ?? "";
          String type = e['entity']?['type'] ?? "";
          String identifier = e['entity']?['data']?['identifier'] ?? "";
          String locationName = e['entity']?['data']?['locationName'] ?? "";
          String typeName = e['entity']?['data']?['typeName'] ?? "";

          String domain = e['entity']?['data']?['domain'] ?? "";

          String label = displayName.isEmpty ? name : displayName;

          return ChartData(label: label, value: count.toDouble(), data: {
            "name": label,
            "type": type,
            "identifier": identifier,
            "locationName": locationName,
            "typeName": typeName,
            "domain": domain,
          });
        }).toList();

        list = list.where((element) => element.value != 0).toList();

        if (list.isEmpty) {
          return const SizedBox();
        }

        list.sort((a, b) => b.value.compareTo(a.value));

        // Step 2: Retrieve the top 5 elements
        List<ChartData> chartData =
            list.length > 5 ? list.take(5).toList() : list;

        // Step 3: Compute the sum of the remaining values
        if (list.length > 5) {
          int sumOtherValues =
              list.skip(5).map((e) => e.value.toInt()).reduce((a, b) => a + b);

          if (sumOtherValues != 0) {
            chartData.add(ChartData(
              label: "Others",
              value: sumOtherValues.toDouble(),
            ));
          }
        }

        return Skeletonizer(
          enabled: result.isLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.sp),
            child: BgContainer(
              title: "Alarm Space Distribution",
              titilePadding: EdgeInsets.only(left: 5.sp, top: 5.sp),
              child: PieChartWidget(
                chartData: chartData,
                onDoubleTap: (chartData) {
                  if (chartData.label == "Others") {
                    var othersList = list.skip(5).toList();

                    othersList.sort(
                      (a, b) => b.value.compareTo(a.value),
                    );

                    showCustomModalBottomSheet(
                        context: context,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Others",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            Expanded(
                                child: ListView.builder(
                              itemCount: othersList.length,
                              itemBuilder: (context, index) {
                                var chartData = othersList[index];

                                return ListTile(
                                  onTap: () {
                                    // var selectedElement =
                                    //     data.singleWhereOrNull((element) {
                                    //   String name = element['entity']?['data']
                                    //           ?['displayName'] ??
                                    //       element['entity']?['data']?["name"] ??
                                    //       "";

                                    //   return name.toLowerCase() ==
                                    //       chartData.label.toLowerCase();
                                    // });

                                    Navigator.of(context).pop();

                                    drilldown(chartData.data, context);
                                  },
                                  title: Text(chartData.label),
                                  trailing: Text(Converter()
                                      .formatNumber(chartData.value)),
                                );
                              },
                            ))
                          ],
                        ));

                    return;
                  }

                  // var selectedElement = data.singleWhereOrNull((element) {
                  //   String name = element['entity']?['data']?['displayName'] ??
                  //       element['entity']?['data']?["name"] ??
                  //       "";

                  //   return name.toLowerCase() == chartData.label.toLowerCase();
                  // });

                  drilldown(chartData.data, context);

                  // print("$label - $value");
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void drilldown(Map<String, dynamic>? data, BuildContext context) {
    if (data == null) {
      return;
    }

    String name = data['name'] ?? "";
    String type = data['type'] ?? "";
    String identifier = data['identifier'] ?? "";
    String locationName = data['locationName'] ?? "";
    String typeName = data['typeName'] ?? "";

    String domain = data['domain'] ?? "";

    String? communityIdentfier =
        insights != Insights.community ? null : entity['data']?['identifier'];

    Navigator.of(context).pushNamed(
      CommunityHierarchyScreen.id,
      arguments: CommunityHierarchyArgs(
          initialDateTimeRange: DateTimeRange(
              start: DateTime.fromMillisecondsSinceEpoch(startDate),
              end: DateTime.fromMillisecondsSinceEpoch(endDate)),
          insights: CommunityInsightsServices().getNextInsights(insights),
          communityIdentifier: communityIdentfier,
          dropdownData: CommunityHierarchyDropdownData(
            parentEntity: entity,
            displayName: name,
            locationName: locationName,
            typeName: typeName,
            entity: {
              "type": type,
              "data": {
                "domain": domain,
                "identifier": identifier,
                "name": name,
              }
            },
            identifier: identifier,
          )),
    );
  }
}
