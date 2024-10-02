import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/widgets/data_trends_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../core/models/alarms/alarm_ asset_history_model.dart';
import '../../../../../../core/schemas/alarms_schema.dart';
import '../../../../../../core/services/graphql_services.dart';

class EquipmentDataTrendsChart extends StatelessWidget {
  EquipmentDataTrendsChart({
    super.key,
    required this.sourceId,
    required this.pointNames,
    required this.sourceType,
    required this.sourceDomain,
    this.startDate,
    this.endDate,
  });

  final String sourceId;
  final List<dynamic> pointNames;
  final String sourceType;
  final String sourceDomain;
  final int? startDate;
  final int? endDate;

  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // Get yesterday's start (midnight)
    int yesterDayStart = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 1))
        .millisecondsSinceEpoch;

    // Get today's end (midnight)
    int todayEnd = DateTime(now.year, now.month, now.day)
        .add(const Duration(hours: 23, minutes: 59, seconds: 59))
        .millisecondsSinceEpoch;

    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
          rereadPolicy: true,
          query: AlarmsSchema.getAssetHistory,
          variables: {
            "data": {
              "sources": [
                {
                  "asset": {
                    "type": sourceType,
                    "data": {
                      "domain": sourceDomain,
                      "identifier": sourceId,
                    }
                  },
                  "pointNames": pointNames,
                }
              ],
              "startDate": startDate ?? yesterDayStart,
              "endDate": endDate ?? todayEnd,
            }
          }),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return SfCartesianChart();
        }

        if (result.hasException) {
          return const SizedBox();
        }

        AssetHistory assetHistory = AssetHistory.fromJson(result.data ?? {});

        var assetHistoryList = assetHistory.getAssetHistory ?? [];

        List<PointData> pointDataList = assetHistoryList.isNotEmpty
            ? assetHistoryList.first.pointData ?? []
            : [];

        return DataTrendsChart(
          list: pointDataList,
          startDate: yesterDayStart,
          endDate: todayEnd,
        );
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final DateTime? x;
  final double y;
}
