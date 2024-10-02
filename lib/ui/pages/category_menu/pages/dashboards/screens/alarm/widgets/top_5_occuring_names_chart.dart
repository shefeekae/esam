import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/models/charts/pie_chart_model.dart';
import 'package:nectar_assets/core/schemas/dashboard_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/alarm_dashboard.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/functions/chart_functions.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/consoldation/equipment_consoldation_screen.dart';
import 'package:nectar_assets/ui/shared/functions/converters.dart';
import 'package:nectar_assets/ui/shared/widgets/chart/pie_chart_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:nectar_assets/ui/shared/widgets/sheets/custom_modal_bottomsheet.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Top5OccuringNamesChart extends StatelessWidget {
  Top5OccuringNamesChart({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.entity,
    required this.dropdownType,
  });

  final int startDate;
  final int endDate;
  final Map<String, dynamic>? entity;
  final Level dropdownType;

  UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    DateTime start = DateTime.fromMillisecondsSinceEpoch(startDate);
    DateTime end = DateTime.fromMillisecondsSinceEpoch(endDate);

    Map<String, dynamic> data = {
      "domain": userData.domain,
      "facetField": "name",
      "startDate": startDate,
      "endDate": endDate,
      "entity": {
        "type": userData.tenant["type"],
        "data": {
          "domain": userData.tenant["domain"],
          "identifier": userData.tenant["identifier"],
        }
      }
    };

    if (entity != null) {
      data["entity"] = entity;
    }

    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
          query: DashboardSchema.getTotalEventConsolidation,
          rereadPolicy: true,
          variables: {"data": data},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Skeletonizer(
              enabled: true,
              child: buildLayout([], [], start, end, context),
            );
          }

          if (result.hasException) {
            return GraphqlServices().handlingGraphqlExceptions(
              result: result,
              context: context,
              refetch: refetch,
            );
          }

          List<ChartData> chartData = [];

          List<ChartData> list = [];
          var data = result.data ?? {};

          Map<String, dynamic> responseMap =
              data["getTotalEventConsolidation"]?["responseMap"] ?? {};

          if (responseMap.isEmpty) {
            return const SizedBox();
          }

          responseMap.forEach(
            (key, value) {
              String label = key;
              int count = value;

              list.add(
                ChartData(label: label, value: count.toDouble()),
              );
            },
          );

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

          return buildLayout(chartData, othersList, start, end, context);
        });
  }

  Padding buildLayout(List<ChartData> chartData, List<ChartData> othersList,
      DateTime start, DateTime end, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: BgContainer(
        title: "Top 5 Occuring Names based on All Alarms",
        titilePadding: EdgeInsets.all(8.sp),
        child: PieChartWidget(
          chartData: chartData,
          onDoubleTap: (chartData) {
            // String data = chartData.identifier?["data"];

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

                              navigateToEquipmentConsolidation(
                                  chartValue, start, end, context);
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

            navigateToEquipmentConsolidation(chartData, start, end, context);
          },
        ),
      ),
    );
  }

  void navigateToEquipmentConsolidation(
      ChartData chartData, DateTime start, DateTime end, BuildContext context) {
    String name = chartData.label;

    List<Map<String, dynamic>> filterValues = [
      {
        "key": "names",
        "filterKey": "names",
        "identifier": [name],
        "values": [
          {
            "name": name,
            "data": [name],
          }
        ]
      },
      {
        "key": "date",
        "filterKey": "date",
        "identifier": {"startDate": startDate, "endDate": endDate},
        "values": [
          {
            "name":
                "${DateFormat("dd MMM yyy").format(start)} - ${DateFormat("dd MMM yyy").format(end)}",
          }
        ]
      },
    ];

    if (entity != null) {
      filterValues.add({
        "key": ChartServices().getTemplateKey(dropdownType),
        "filterKey": "searchTagIds",
        "identifier": entity?["data"]?["identifier"],
        "values": [
          {
            "name": entity?["data"]?["name"] ?? "",
            "data": entity?["data"]?["identifier"],
          }
        ]
      });
    }

    Navigator.of(context).pushNamed(EquipmentConsoldationScreen.id,
        arguments: {"filterValues": filterValues});
  }
}
