import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/dashboard/alarm_lifetime_distribution_model.dart';
import 'package:nectar_assets/core/schemas/dashboard_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/functions/chart_functions.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/model/alarm_lifetime_distirbution_chart_model.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../core/enums/dashboards_enum.dart';

class AlarmLifetimeDistributionWidget extends StatelessWidget {
  AlarmLifetimeDistributionWidget({
    super.key,
    required this.dropdownType,
    required this.identifier,
    required this.entity,
  });

  final Level dropdownType;
  final String? identifier;
  final Map<String, dynamic>? entity;

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "domain": userData.domain,
    };

    if (identifier != null) {
      if (dropdownType == Level.community) {
        data["community"] = identifier;
      }
    }

    if (entity != null) {
      if (dropdownType == Level.subCommunity) {
        data["subCommunity"] = entity;
      }
    }
    if (entity != null) {
      if (dropdownType == Level.site) {
        data["site"] = entity;
      }
    }

    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
          rereadPolicy: true,
          query: DashboardSchema.getAlarmLifeTimeDistributionData,
          variables: {
            "data": data,
          },
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Skeletonizer(
              enabled: true,
              child: buildLayout([]),
            );
          }
          if (result.hasException) {
            return GraphqlServices().handlingGraphqlExceptions(
              result: result,
              context: context,
              refetch: refetch,
            );
          }
          List<StackedAreaDataModel> chartData = [];

          Map<String, dynamic>? data = result.data;

          AlarmLifetimeDistributionData alarmData =
              AlarmLifetimeDistributionData.fromJson(data ?? {});

          List<Alarm> alarmDataList =
              alarmData.getAlarmLifeTimeDistributionData?.alarms ?? [];

          if (alarmDataList.isEmpty) {
            return const SizedBox();
          }

          chartData = List.generate(alarmDataList.length, (index) {
            Alarm alarmData = alarmDataList[index];

            return StackedAreaDataModel(
              date: DateTime.fromMillisecondsSinceEpoch(
                  alarmData.date ?? DateTime.now().millisecondsSinceEpoch),
              total: alarmData.total?.toDouble() ?? 0,
              active: alarmData.active?.toDouble() ?? 0,
            );
          });

          return buildLayout(chartData);
        });
  }

  Padding buildLayout(List<StackedAreaDataModel> chartData) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: BgContainer(
        title: "Alarm Lifetime Distribution",
        titilePadding: EdgeInsets.all(8.sp),
        child: SfCartesianChart(
          tooltipBehavior: TooltipBehavior(
            enable: true,
            canShowMarker: true,
            activationMode: ActivationMode.singleTap,
            shouldAlwaysShow: true,
            shared: true,
          ),
          plotAreaBorderWidth: 0,
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enablePanning: true,
          ),
          // title: ChartTitle(text: 'Sales comparision of fruits in a shop'),
          legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
            position: LegendPosition.bottom,
          ),
          primaryXAxis: DateTimeAxis(
              majorGridLines: const MajorGridLines(width: 0),
              intervalType: DateTimeIntervalType.months,
              // dateFormat: DateFormat.y(),
              desiredIntervals: 6),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compact(),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
          ),
          series: ChartServices()
              .getAlarmLifetimeDistributionSeries(chartData: chartData),
        ),
      ),
    );
  }
}
