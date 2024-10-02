import 'package:flutter/material.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/services/communities/community_insights_services.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../../core/schemas/alarms_schema.dart';
import '../../../../../../../core/services/charts/bar_chart_data.dart';
import '../../../../../../../core/services/graphql_services.dart';
import '../../../../../../shared/widgets/chart/category_axis_bar_chart.dart';
import '../../../../../../shared/widgets/container/background_container.dart';
import '../../../equipments/consoldation/consoldation_alarms_list_screen.dart';

// ignore: must_be_immutable
class Top5EquipmentsAlarmsWidget extends StatelessWidget {
  Top5EquipmentsAlarmsWidget(
      {required this.startDate,
      required this.endDate,
      required this.entity,
      required this.insights,
      super.key});

  final int startDate;
  final int endDate;
  final Map<String, dynamic> entity;
  final Insights insights;
  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
        rereadPolicy: true,
        query: AlarmsSchema.getTotalEventConsolidation,
        variables: {
          "data": {
            "domain": userData.domain,
            "facetField": "sourceName",
            "startDate": startDate,
            "endDate": endDate,
            "entity": entity,
          }
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        // if (result.hasException) {
        //   return GraphqlServices().handlingGraphqlExceptions(
        //     result: result,
        //     context: context,
        //     refetch: refetch,
        //   );
        // }

        Map<String, dynamic> responseMap =
            result.data?['getTotalEventConsolidation']?['responseMap'] ?? {};

        List<BarChartData> dataSource = [];

        responseMap.forEach((key, value) {
          int count = value ?? 0;

          dataSource.add(BarChartData(
            key,
            count,
          ));
        });

        if (result.isNotLoading && dataSource.isEmpty) {
          return const SizedBox();
        }

        dataSource.sort(
          (a, b) => b.y.compareTo(a.y),
        );

        dataSource =
            dataSource.length > 5 ? dataSource.take(5).toList() : dataSource;

        return Skeletonizer(
          enabled: result.isLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.sp),
            child: BgContainer(
              title: "Top 5 Equipments based on All Alarms",
              child: CategoryAxisBarChart(
                title: "",
                dataSource: dataSource,
                onDoubleTap: (barChartData) {
                  String formatedStart = DateFormat("MMM, d - yyyy")
                      .format(DateTime.fromMillisecondsSinceEpoch(startDate));
                  String formatedEnd = DateFormat("MMM, d - yyyy")
                      .format(DateTime.fromMillisecondsSinceEpoch(endDate));

                  String name = barChartData.x;

                  String drilldownFilterKey = CommunityInsightsServices()
                      .getDrillDownFilterKey(insights);

                  String? identifier = entity['data']?['identifier'];

                  Navigator.of(context)
                      .pushNamed(ConslodationAlarmsListScreen.id, arguments: {
                    "filterValues": [
                      {
                        "key": drilldownFilterKey,
                        "filterKey": "searchTagIds",
                        "identifier": drilldownFilterKey == "community"
                            ? identifier
                            : entity,
                        "values": [
                          {
                            "name": entity['data']?['name'],
                            "data": entity,
                          }
                        ]
                      },
                      {
                        "key": "assets",
                        "filterKey": "searchTagNames",
                        "identifier": [name],
                        "values": [
                          {
                            "name": name,
                            "data": name,
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
                          {
                            "name": "$formatedStart - $formatedEnd"
                          }
                        ]
                      },
                    ],
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
