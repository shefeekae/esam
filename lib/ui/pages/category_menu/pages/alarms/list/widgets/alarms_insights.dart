import 'package:app_filter_form/app_filter_form.dart';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/services/alarms/alarms_insights_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/widgets/chart/category_axis_bar_chart.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../core/services/charts/bar_chart_data.dart';

class AlarmInsights extends StatelessWidget {
  AlarmInsights({
    super.key,
  });

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> payload = {
      "domain": userData.domain,
    };

    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: BlocBuilder<PayloadManagementBloc, PayloadManagementState>(
        builder: (context, state) {
          payload.addAll(state.payload);

          return StatefulBuilder(builder: (context, setState) {
            return FutureBuilder(
              future: GrapghQlClientServices().performQuery(
                query: AlarmsSchema.getInsightsData,
                variables: {
                  "filter": payload,
                },
              ),
              builder: (context, snapshot) {
                bool isLoading =
                    snapshot.connectionState == ConnectionState.waiting;

                if (isLoading) {
                  return Skeletonizer.bones(
                    // enabled: true,
                    child: buildCharts(
                      context,
                      totalActiveAlarms: {},
                      attentionReqAlarms: {},
                      currentDayActiveAlarms: {},
                    ),
                  );
                }

                var result = snapshot.data!;

                if (result.hasException) {
                  return GraphqlServices().handlingGraphqlExceptions(
                    result: result,
                    context: context,
                    setState: setState,
                  );
                }

                Map<String, dynamic>? data = result.data?['getInsightsData'];

                Map<String, dynamic> totalActiveAlarms =
                    data?['totalActiveAlarms'] ?? {};
                Map<String, dynamic> attentionReqAlarms =
                    data?['attentionReqAlarms'] ?? {};
                Map<String, dynamic> currentDayActiveAlarms =
                    data?['currentDayActiveAlarms'] ?? {};

                return RefreshIndicator.adaptive(
                  onRefresh: () async {
                    setState(
                      () {},
                    );
                  },
                  child: buildCharts(
                    context,
                    totalActiveAlarms: totalActiveAlarms,
                    attentionReqAlarms: attentionReqAlarms,
                    currentDayActiveAlarms: currentDayActiveAlarms,
                  ),
                );
              },
            );
          });
        },
      ),
    );
  }

  ListView buildCharts(
    BuildContext context, {
    required Map<String, dynamic> totalActiveAlarms,
    required Map<String, dynamic> attentionReqAlarms,
    required Map<String, dynamic> currentDayActiveAlarms,
  }) {
    return ListView(
      children: [
        buildTitleWithBarChart(
          context,
          title: "Total active alarms",
          data: totalActiveAlarms,
        ),
        SizedBox(
          height: 15.sp,
        ),
        buildTitleWithBarChart(
          context,
          title: "Attention required alarms",
          data: attentionReqAlarms,
        ),
        SizedBox(
          height: 15.sp,
        ),
        buildTitleWithBarChart(
          context,
          title: "Current days active alarms",
          data: currentDayActiveAlarms,
        ),
      ],
    );
  }

  // ====================================================================================

  Widget buildTitleWithBarChart(
    BuildContext context, {
    required String title,
    required Map<String, dynamic> data,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buidTitle(title),
        SizedBox(
          height: 10.sp,
        ),
        buildBarChart(
          context,
          data: data,
          chartName: title,
        ),
      ],
    );
  }

  String startCase(String input) {
    List<String> words = input.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }

    return words.join(' ');
  }

  Widget buildBarChart(
    BuildContext context, {
    required Map<String, dynamic> data,
    required String chartName,
  }) {
    List<Map<String, dynamic>> list = [];

    data.forEach((key, value) {
      list.add(
        {"label": startCase(key), "value": value},
      );
    });

    return CategoryAxisBarChart(
      dataSource:
          list.map((e) => BarChartData(e['label'], e['value'])).toList(),
      title: chartName,
      onDoubleTap: (barChartData) {
        String label = barChartData.x;

        AlarmsInsightsServices().barChartNavigationHandling(
          context,
          label: label,
          chartName: chartName,
        );
      },
    );
  }

  // ========================================================================================

  Text buidTitle(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

