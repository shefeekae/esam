import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/schemas/fire_panels_schemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/insights/widgets/firepanel_insights_pie_chart.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../../core/services/panels/panels_instights_charts_services.dart';
import 'firepanel_status_card.dart';
import 'package:nectar_assets/core/models/charts/pie_chart_model.dart';

class PanelsAlarmsStatusCard extends StatelessWidget {
  PanelsAlarmsStatusCard({
    super.key,
  });

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
          query: FirePanelSchema.getFirePanelsAlarmsGroupedBy,
          variables: {
            "data": {
              "domain": userData.domain,
              "status": ["active"],
              "names": [
                "Dirty",
                "Disabled",
                "Common Fault",
                "Fire Alarm",
                "Head Missing"
              ],
              "facetPivots": ["name", "sourceId"],
            }
          }),
      builder: (result, {fetchMore, refetch}) {
        // if (result.isLoading) {
        //   return const Center(
        //     child: CircularProgressIndicator.adaptive(),
        //   );
        // }

        if (result.hasException) {
          return GraphqlServices().handlingGraphqlExceptions(
            result: result,
            context: context,
            refetch: refetch,
          );
        }

        Map<String, dynamic> data =
            result.data?['getFirePanelsAlarmsGroupedBy']?['data'] ?? {};

        int fireAlarm = data['Fire Alarm'] ?? 0;
        int dirty = data['Dirty'] ?? 0;
        int disabled = data['Disabled'] ?? 0;

        List<ChartData> listChartData = [];

        data.forEach((key, value) {
          double doubleValue = 0;

          if (value != null) {
            try {
              doubleValue = value.toDouble();
            } catch (e) {
              // print("catch $e");
              doubleValue = 0;
            }
          }

          listChartData.add(
            ChartData(
              label: key,
              value: doubleValue,
              color: PanelsInsightsServices().getAlarmTypeColor(key),
            ),
          );
        });

        bool isLoading = result.isLoading;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FirePanelStatusCard(
                  title: "Fire Alarm",
                  bgColor: Colors.red,
                  value: fireAlarm.toString(),
                  isLoading: isLoading,
                ),
                FirePanelStatusCard(
                  title: "Dirty",
                  bgColor: Colors.amber,
                  value: dirty.toString(),
                  isLoading: isLoading,
                ),
                FirePanelStatusCard(
                  title: "Disabled",
                  bgColor: Colors.grey,
                  value: disabled.toString(),
                  isLoading: isLoading,
                ),
              ],
            ),
            SizedBox(
              height: 10.sp,
            ),
            FirePanelInsightsPieChart(
              chartData: result.isLoading
                  ? [
                      ChartData(label: "Loading", value: 1),
                      ChartData(label: "Loading", value: 2),
                      ChartData(label: "Loading", value: 3),
                      ChartData(label: "Loading", value: 4),
                    ]
                  : listChartData,
              isLoading: result.isLoading,
            ),
          ],
        );
      },
    );
  }
}
