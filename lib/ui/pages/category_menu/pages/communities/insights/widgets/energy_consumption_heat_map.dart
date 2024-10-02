// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/ui/shared/functions/converters.dart';
import 'package:sizer/sizer.dart';
import 'package:nectar_assets/core/schemas/communities_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import '../../../../../../../core/enums/insights_enum.dart';
import '../../../../../../shared/widgets/container/background_container.dart';

class EnergyConsumptionHeatMap extends StatelessWidget {
  final int startDate;
  final int endDate;
  final Map<String, dynamic> entity;
  final Insights? insights;
  EnergyConsumptionHeatMap({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.entity,
    this.insights,
  }) : super(key: key);

  final Map<DateTime, int> datasets = {};
  final List<Map> items = [];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> consumptionData = {
      "startDate": startDate,
      "endDate": endDate,
      "period": "HOURLY",
      "utilityName": "LVPMeter",
      "level": "COMMUNITY"
    };

    if (insights == Insights.community) {
      String? identifier = entity['data']?['identifier'];

      consumptionData["communities"] = [identifier];
    } else if (insights == Insights.subCommunity) {
      consumptionData['level'] = "SITEGROUP";

      consumptionData["siteGroups"] = [entity];
    } else if (insights == Insights.site) {
      consumptionData['level'] = "SITE";
      consumptionData['sites'] = [entity];
    }

    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
          rereadPolicy: true,
          query: CommunitySchemas.getEnergyConsumptionNew,
          variables: {
            "consumptionData": consumptionData,
          }),
      builder: (result, {fetchMore, refetch}) {
        List list = [];
        try {
          if (insights == Insights.community) {
            list = result.data?['getEnergyConsumptionNew']?['communities']?[0]
                    ?['consumption'] ??
                [];
          } else if (insights == Insights.subCommunity) {
            list = result.data?['getEnergyConsumptionNew']?['communities']?[0]
                    ?['siteGroups']?[0]?['consumption'] ??
                [];
          } else if (insights == Insights.site) {
            list = result.data?['getEnergyConsumptionNew']?['communities']?[0]
                    ?['siteGroups']?[0]?["sites"]?[0]?['consumption'] ??
                [];
          }
        } catch (_) {
          list = [];
        }

        for (var element in list) {
          DateTime dateTime =
              // DateTime.fromMillisecondsSinceEpoch(element['dateTime']);
              DateTime(element['year'] ?? 0, element['month'] ?? 0,
                  element['dayOfMonth'] ?? 0);

          num value = element['consumption'] ?? 0;

          datasets.addAll({
            dateTime: value.toInt(),
          });

          items.add({
            "date": dateTime,
            "value": value,
          });
        }

        if (!result.isLoading && datasets.isEmpty) {
          return const SizedBox();
        }

        return BgContainer(
          title: "Energy Consumption Distribution",
          // padding: EdgeInsets.only(top: 5.sp, left: 5.sp),
          child: Builder(builder: (context) {
            if (result.isLoading) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }

            String selectedDate = "";
            String value = "";

            return SizedBox(
              width: double.infinity,
              child: StatefulBuilder(builder: (context, setState) {
                return Column(
                  children: [
                    selectedValueWidget(selectedDate, value),
                    SizedBox(
                      height: 5.sp,
                    ),
                    buildHeatMap(
                      onClick: (dateTime) {
                        DateTime start = dateTime;
                        DateTime end = dateTime.add(const Duration(
                            hours: 23, minutes: 59, seconds: 59));

                        var filteredList = items.where((element) {
                          DateTime date = element['date'];
                          return date == start ||
                              date.isAfter(start) && date.isBefore(end);
                        }).toList();

                        num sum = 0;

                        for (var item in filteredList) {
                          sum += item["value"] ?? 0;
                        }

                        setState(
                          () {
                            value =
                                "${Converter().formatNumber(sum.toDouble())} Kwh";
                            selectedDate =
                                DateFormat("MMM, dd yyy").format(dateTime);
                          },
                        );
                      },
                    ),
                  ],
                );
              }),
            );
          }),
        );
      },
    );
  }

  // =====================================================================================

  HeatMap buildHeatMap({
    required dynamic Function(DateTime)? onClick,
  }) {
    return HeatMap(
      showColorTip: true,
      size: 20,
      datasets: datasets,
      colorMode: ColorMode.color,
      scrollable: true,
      startDate: DateTime.fromMillisecondsSinceEpoch(startDate),
      endDate: DateTime.fromMillisecondsSinceEpoch(endDate),
      showText: true,
      // colorTipCount: 10,
      onClick: onClick,
      colorsets: {
        1: Colors.red.shade800,
        2: Colors.red.shade700,
        3: Colors.red.shade600,
        4: Colors.green.shade700,
        5: Colors.green.shade500,
        6: Colors.green.shade300,

        // 2: Colors.yellow,
        // 3: Colors.orange,
        // 4: Colors.red,
      },
    );
  }

  Widget selectedValueWidget(String selectedDate, String value) {
    return Visibility(
      visible: selectedDate.isNotEmpty && value.isNotEmpty,
      child: Column(
        children: [
          SizedBox(
            height: 4.sp,
          ),
          Text(selectedDate),
          SizedBox(
            height: 4.sp,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4.sp,
          ),
        ],
      ),
    );
  }
}
