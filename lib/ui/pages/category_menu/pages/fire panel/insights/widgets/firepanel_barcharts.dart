import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/schemas/fire_panels_schemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/panels/panels_instights_charts_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../core/models/charts/fire_panels_bar_chart_model.dart';
import '../../../../../../shared/functions/reorder_map.dart';

class FirePanelBarChart extends StatelessWidget {
  FirePanelBarChart({super.key});

  final List<FirePanelBarchartModel> chartData = [];

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: QueryWidget(
          options: GraphqlServices().getQueryOptions(
              query: FirePanelSchema.getFirePanelsAlarmsAgeing,
              variables: {
                "data": {
                  "ages": PanelsInsightsServices().getFirePanelAgeData(),
                  "filter": {
                    "domain": userData.domain,
                    "status": ["active"],
                    "names": [
                      "Dirty",
                      "Disabled",
                      "Common Fault",
                      "Fire Alarm",
                      "Head Missing"
                    ],
                    "facetPivots": ["name"]
                  }
                }
              }),
          builder: (result, {fetchMore, refetch}) {
            if (result.hasException) {
              return GraphqlServices().handlingGraphqlExceptions(
                result: result,
                context: context,
                refetch: refetch,
              );
            }

            if (!result.isLoading) {
              Map<String, dynamic> data =
                  result.data?['getFirePanelsAlarmsAgeing'] ?? {};

              Map<String, dynamic> reorderData = reorderMap(
                keyOrder: [
                  'Today',
                  'Yesterday',
                  '2-5 Days',
                  '6-10 Days',
                  '11-30 Days',
                  '31+ Days'
                ],
                myMap: data,
              );

              reorderData.forEach((key, value) {
                String title = key;

                int fireAlarm = value['Fire Alarm'] ?? 0;
                int dirty = value['Dirty'] ?? 0;
                int disabled = value['Disabled'] ?? 0;

                chartData.add(
                  FirePanelBarchartModel(
                    title: title,
                    fireAlarm: fireAlarm.toDouble(),
                    dirty: dirty.toDouble(),
                    disabled: disabled.toDouble(),
                  ),
                );
              });
            }

            return Skeletonizer(
              enabled: result.isLoading,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                    labelStyle: TextStyle(
                  fontSize: 7.sp,
                )),
                backgroundColor: ThemeServices().getBgColor(context),
                tooltipBehavior: TooltipBehavior(enable: true),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                legend: Legend(
                  isVisible: true,
                  // overflowMode: LegendItemOverflowMode.wrap,
                  position: LegendPosition.bottom,
                ),
                series: <CartesianSeries>[
                  buildColumnSeries(
                    context,
                    name: "Fire Alarm",
                    color: Colors.red,
                    yValueMapper: (data, p1) => data.fireAlarm,
                  ),
                  buildColumnSeries(
                    context,
                    name: "Dirty",
                    color: Colors.amber,
                    yValueMapper: (data, p1) => data.dirty,
                  ),
                  buildColumnSeries(
                    context,
                    name: "Disabled",
                    color: Colors.grey,
                    yValueMapper: (data, p1) => data.disabled,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // =========================================================================

  ColumnSeries<FirePanelBarchartModel, String> buildColumnSeries(
      BuildContext context,
      {required String name,
      required Color color,
      required num? Function(FirePanelBarchartModel data, int _)
          yValueMapper}) {
    return ColumnSeries<FirePanelBarchartModel, String>(
      onPointDoubleTap: (pointInteractionDetails) {
        PanelsInsightsServices().goToAlarmPage(
          context,
          title: name,
        );
      },
      name: name,
      color: color,
      dataSource: chartData,
      xValueMapper: (FirePanelBarchartModel data, _) => data.title,
      yValueMapper: yValueMapper,
      // (FirePanelBarchartModel data, _) =>
      //     data.fireAlarm,
    );
  }
}
