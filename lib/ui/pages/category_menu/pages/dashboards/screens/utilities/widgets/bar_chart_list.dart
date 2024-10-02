import 'package:flutter/material.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/models/dashboard/utitlities_data_model.dart';
import 'package:nectar_assets/core/schemas/dashboard_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/model/bar_chart_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/widgets/consumption_bar_chart.dart';
import 'package:secure_storage/model/user_data_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BarChartList extends StatelessWidget {
  BarChartList(
      {super.key,
      required this.yearValue,
      required this.compareYearValue,
      this.entity,
      required this.level});

  final int yearValue;
  final int compareYearValue;
  final Map<String, dynamic>? entity;
  final Level level;

  UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "currentYear": yearValue.toString(),
      "previousYear": compareYearValue.toString(),
    };

    if (entity != null) {
      String? identifier = entity?['data']?['identifier'];
      if (level == Level.community) {
        data['community'] = identifier;
      } else if (level == Level.subCommunity) {
        data['subCommunity'] = entity;
      } else if (level == Level.site) {
        data["site"] = entity;
      } else if (level == Level.site) {
        data["site"] = entity;
      } else if (level == Level.equipment) {
        data["equipment"] = entity;
      } else if (level == Level.subMeter) {
        data["subMeter"] = entity;
      }
    } else {
      data['domain'] = userData.domain;
    }

    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
        rereadPolicy: true,
        query: DashboardSchema.getUtilitiesData,
        variables: {"data": data},
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return Skeletonizer(
            enabled: true,
            child: buildConsumptionBarCharts(
              yearValue,
              [],
              compareYearValue,
              [],
              [],
              [],
            ),
          );
        }

        var data = result.data ?? {};

        UtilitiesDataModel dataModel = UtilitiesDataModel.fromJson(data);

        List<Values>? list = dataModel.getUtilitiesData?.values ?? [];

        if (list.isEmpty) {
          return const SizedBox();
        }

        List<UtilitiesBarChartData> electricityChartList = list.map((e) {
          String? label = e.name;

          dynamic yearValue = level == Level.subMeter
              ? e.lVPSubMeterCurrent?.toDouble()
              : e.lVPMeterCurrent?.toDouble();

          dynamic compareYearValue = level == Level.subMeter
              ? e.lVPSubMeterPrevious?.toDouble()
              : e.lVPMeterPrevious?.toDouble();

          return UtilitiesBarChartData(
              label: label,
              yearValue: yearValue,
              compareYearValue: compareYearValue);
        }).toList();

        List<UtilitiesBarChartData> waterChartList = list.map(
          (e) {
            String? label = e.name;

            dynamic yearValue = e.waterMeterCurrent?.toDouble();

            dynamic compareYearValue = e.waterMeterPrevious?.toDouble();

            return UtilitiesBarChartData(
                label: label,
                yearValue: yearValue,
                compareYearValue: compareYearValue);
          },
        ).toList();

        List<UtilitiesBarChartData> chilledWaterChartList = list.map((e) {
          String? label = e.name;

          dynamic yearValue = e.dCPBTUMeterCurrent?.toDouble();

          dynamic compareYearValue = e.dCPBTUMeterPrevious?.toDouble();

          return UtilitiesBarChartData(
              label: label,
              yearValue: yearValue,
              compareYearValue: compareYearValue);
        }).toList();

        List<UtilitiesBarChartData> treatedEffluentChartList = list.map((e) {
          String? label = e.name;

          dynamic yearValue = e.tSEMeterCurrent?.toDouble();

          dynamic compareYearValue = e.tSEMeterPrevious?.toDouble();

          return UtilitiesBarChartData(
              label: label,
              yearValue: yearValue,
              compareYearValue: compareYearValue);
        }).toList();

        return buildConsumptionBarCharts(
          yearValue,
          electricityChartList,
          compareYearValue,
          waterChartList,
          chilledWaterChartList,
          treatedEffluentChartList,
        );
      },
    );
  }

  Widget buildConsumptionBarCharts(
    int yearValue,
    List<UtilitiesBarChartData> electricityChartList,
    int compareYearValue,
    List<UtilitiesBarChartData> waterChartList,
    List<UtilitiesBarChartData> chilledWaterChartList,
    List<UtilitiesBarChartData> treatedEffluentChartList,
  ) {
    return Column(
      children: [
        ConsumptionBarChartWidget(
            title: "Electricity Consumption - $yearValue (as per DEWA bills)",
            yearValue: yearValue,
            chartList: electricityChartList,
            compareYearValue: compareYearValue),
        ConsumptionBarChartWidget(
            title: "Water Consumption - $yearValue (as per DEWA bills)",
            yearValue: yearValue,
            chartList: waterChartList,
            compareYearValue: compareYearValue),
        ConsumptionBarChartWidget(
            title: "Chilled Water Consumption - $yearValue (as per DEWA bills)",
            yearValue: yearValue,
            chartList: chilledWaterChartList,
            compareYearValue: compareYearValue),
        ConsumptionBarChartWidget(
            title:
                "Treated Effluent Consumption - $yearValue (as per DEWA bills)",
            yearValue: yearValue,
            chartList: treatedEffluentChartList,
            compareYearValue: compareYearValue),
      ],
    );
  }
}
