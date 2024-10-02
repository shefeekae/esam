import 'package:flutter/material.dart';
import 'package:graphql/src/core/query_result.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/models/charts/pie_chart_model.dart';
import 'package:nectar_assets/core/models/dashboard/all_alarm_space_distribution_data_model.dart';
import 'package:nectar_assets/core/models/insights/insights_dropdown_model.dart';
import 'package:nectar_assets/core/schemas/dashboard_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/alarm_dashboard.dart';
import 'package:nectar_assets/ui/shared/functions/converters.dart';
import 'package:nectar_assets/ui/shared/widgets/chart/pie_chart_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../../core/services/communities/community_insights_services.dart';
import '../../../../../../../shared/widgets/sheets/custom_modal_bottomsheet.dart';
import '../../../../equipments/consoldation/consoldation_alarms_list_screen.dart';

class AllAlarmsSpaceDistributionChart extends StatelessWidget {
  AllAlarmsSpaceDistributionChart({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.dropdownType,
    required this.entity,
  });

  final int startDate;
  final int endDate;
  final Level dropdownType;
  final Map<String, dynamic>? entity;

  final UserDataSingleton userData = UserDataSingleton();

  final CommunityInsightsServices communityInsightsServices =
      CommunityInsightsServices();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "entity": {
        "type": userData.tenant["type"],
        "data": {
          "domain": userData.tenant["domain"],
          "identifier": userData.tenant["identifier"],
        }
      },
      "startDate": startDate,
      "endDate": endDate
    };

    if (entity != null) {
      if (dropdownType == Level.community) {
        data["entity"] = entity;
        data["level"] = "SITEGROUP";
      }
      if (dropdownType == Level.subCommunity) {
        data["entity"] = entity;
        data["level"] = "SITE";
      }
      if (dropdownType == Level.site) {
        data["entity"] = entity;
        data["level"] = "SPACES";
      }
      if (dropdownType == Level.space) {
        data["entity"] = entity;
        data["level"] = "EQUIPMENT";
      }
    }

    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
          query: DashboardSchema.getLevelBasedEventConsolidation,
          rereadPolicy: true,
          variables: {"data": data},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Skeletonizer(
                enabled: true,
                child: buildLayout(
                    context: context, chartDataList: [], othersList: []));
          }

          if (result.hasException) {
            return GraphqlServices().handlingGraphqlExceptions(
              result: result,
              context: context,
              refetch: refetch,
            );
          }

          List<ChartData> chartData = [];

          var data = result.data ?? {};

          if (data.isEmpty) {
            return const Center(
              child: Text("No Data"),
            );
          }

          LevelBasedEventConsolidation levelBasedEventConsolidation =
              LevelBasedEventConsolidation.fromJson(data);

          List<EventCount> eventCountList = levelBasedEventConsolidation
                  .getLevelBasedEventConsolidation?.eventCounts ??
              [];

          if (eventCountList.isEmpty) {
            return const SizedBox();
          }

          List<ChartData> list = [];

          if (dropdownType == Level.space) {
            list = eventCountList.first.equipmentConsolidation?.map((e) {
                  int count = e.count ?? 0;
                  String label = e.field ?? "";

                  return ChartData(
                    label: label,
                    value: count.toDouble(),
                    entity: null,
                  );
                }).toList() ??
                [];
          } else {
            list = eventCountList.map((e) {
              int count = e.count ?? 20;
              String label = e.entity?.data?.name ??
                  e.entity?.data?.displayName ??
                  e.entity?.data?.clientName ??
                  "";

              Entity? entity = e.entity;

              return ChartData(
                label: label,
                value: count.toDouble(),
                entity: entity,
              );
            }).toList();
          }

          list.sort((a, b) => b.value.compareTo(a.value));

          var othersList = list.skip(5).toList();

          othersList.sort(
            (a, b) => b.value.compareTo(a.value),
          );

          // Step 2: Retrieve the top 5 elements
          chartData = list.length > 5 ? list.take(5).toList() : list;

          // Step 3: Compute the sum of the remaining values
          if (list.length > 5) {
            int sumOtherValues = list
                .skip(5)
                .map((e) => e.value.toInt())
                .reduce((a, b) => a + b);

            if (sumOtherValues != 0) {
              chartData.add(ChartData(
                label: "Others",
                value: sumOtherValues.toDouble(),
              ));
            }
          }

          // chartData = eventCountList.map((e) {
          //   String label = e.entity?.data?.clientName ?? "";

          //   int value = e.count ?? 0;

          //   return ChartData(
          //     label: label,
          //     value: value.toDouble(),
          //   );
          // }).toList();

          return buildLayout(
              context: context,
              chartDataList: chartData,
              othersList: othersList);
        });
  }

  Padding buildLayout({
    required BuildContext context,
    required List<ChartData> chartDataList,
    required List<ChartData> othersList,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: BgContainer(
        title: "All Alarms - Space Distribution",
        titilePadding: EdgeInsets.all(8.sp),
        child: PieChartWidget(
          chartData: chartDataList,
          onDoubleTap: (chartData) {
            if (chartData.label == "Others") {
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
                          var chartValue = othersList[index];

                          return ListTile(
                            onTap: () {
                              Navigator.of(context).pop();

                              drilldown(chartValue, context);
                            },
                            title: Text(chartValue.label),
                            trailing: Text(
                                Converter().formatNumber(chartValue.value)),
                          );
                        },
                      ))
                    ],
                  ));

              return;
            }

            drilldown(chartData, context);
          },
        ),
      ),
    );
  }

  void drilldown(ChartData chartData, BuildContext context) {
    Level? type = getDropdownType(dropdownType);

    if (type != null) {
      if (dropdownType != Level.space) {
        Map<String, dynamic> hierarchyEntity = {
          "data": {
            "domain": chartData.entity?.data?.domain,
            "identifier": chartData.entity?.data?.identifier,
          },
          "type": chartData.entity?.type
        };

        CommunityHierarchyDropdownData dropdownData =
            CommunityHierarchyDropdownData(
                parentEntity: null,
                displayName: "",
                entity: hierarchyEntity,
                identifier: chartData.entity?.data?.identifier ?? "");

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AlarmDashboard(
            communityDomain: entity?["data"]?["identifier"],
            dropdownType: type,
            dropDownData: dropdownData,
            initialDateTimeRange: DateTimeRange(
                start: DateTime.fromMillisecondsSinceEpoch(startDate),
                end: DateTime.fromMillisecondsSinceEpoch(endDate)),
            parentEntity: entity,
          ),
        ));
      } else {
        String formatedStart = DateFormat("MMM, d - yyyy")
            .format(DateTime.fromMillisecondsSinceEpoch(startDate));
        String formatedEnd = DateFormat("MMM, d - yyyy")
            .format(DateTime.fromMillisecondsSinceEpoch(endDate));

        Navigator.of(context)
            .pushNamed(ConslodationAlarmsListScreen.id, arguments: {
          "filterValues": [
            {
              "key": "assets",
              "filterKey": "searchTagNames",
              "identifier": [chartData.label],
              "values": [
                {
                  "name": chartData.label,
                  "data": chartData.label,
                }
              ]
            },
            {
              "key": "dateRange",
              "filterKey": "dateRange",
              "identifier": {
                "startDate": startDate,
                "endDate": endDate,
              },
              "values": [
                {"name": "$formatedStart - $formatedEnd"}
              ]
            },
          ],
        });
      }
    }
  }

  Level? getDropdownType(Level dropdownType) {
    if (entity == null) {
      return Level.community;
    }

    switch (dropdownType) {
      case Level.community:
        return Level.subCommunity;

      case Level.subCommunity:
        return Level.site;

      case Level.site:
        return Level.space;

      case Level.space:
        return Level.equipment;

      default:
        return null;
    }
  }
}
