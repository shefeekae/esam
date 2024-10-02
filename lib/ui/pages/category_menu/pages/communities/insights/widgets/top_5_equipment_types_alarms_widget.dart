import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/schemas/alarms_chart_schemas.dart';
import 'package:nectar_assets/core/services/communities/community_insights_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/widgets/alarms_insights.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/consoldation/equipment_consoldation_screen.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../../core/services/charts/bar_chart_data.dart';
import '../../../../../../shared/widgets/chart/category_axis_bar_chart.dart';
import '../../../../../../shared/widgets/container/background_container.dart';
import 'package:collection/collection.dart';

class Top5EquipmentTypesAlarmsWidget extends StatelessWidget {
  Top5EquipmentTypesAlarmsWidget(
      {required this.startDate,
      required this.endDate,
      required this.entity,
      super.key,
      required this.insights});

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
        query: AlarmChartSchemas.getTypeEventConsolidation,
        variables: {
          "data": {
            "domain": userData.domain,
            "facetField": "sourceType",
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

        List list =
            // ['getTypeEventConsolidation'] ?? [];
            result.data?['getTypeEventConsolidation'] ?? [];

        if (result.isNotLoading && list.isEmpty) {
          return const SizedBox();
        }

        // list.sort(
        //   (a, b) {
        //     int aCount = a['count'] ?? 0;
        //     int bCount = b['count'] ?? 0;

        //     return aCount.compareTo(bCount);
        //   },
        // );

        var dataSource = list.map((e) {
          int count = e['count'] ?? 0;

          String typeName = e['typeName'] ?? "";

          return BarChartData(
            typeName,
            count,
          );
        }).toList();

        dataSource.sort(
          (a, b) => b.y.compareTo(a.y),
        );

        dataSource =
            dataSource.length > 5 ? dataSource.take(5).toList() : dataSource;

        dataSource =
            dataSource.where((element) => element.x.isNotEmpty).toList();

        return Skeletonizer(
          enabled: result.isLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.sp),
            child: BgContainer(
              title: "Top 5 Equipment Types based on All Alarms",
              child: CategoryAxisBarChart(
                title: "",
                dataSource: dataSource,
                onDoubleTap: (barChartData) {
                  String formatedStart = DateFormat("MMM, d - yyyy")
                      .format(DateTime.fromMillisecondsSinceEpoch(startDate));
                  String formatedEnd = DateFormat("MMM, d - yyyy")
                      .format(DateTime.fromMillisecondsSinceEpoch(endDate));

                  var element = list.singleWhereOrNull(
                      (element) => element['typeName'] == barChartData.x);

                  Navigator.of(context)
                      .pushNamed(EquipmentConsoldationScreen.id, arguments: {
                    "filterValues": [
                      {
                        "key": CommunityInsightsServices()
                            .getDrillDownEquipmentConsolidationFilterKey(
                                insights),
                        "filterKey": "entity",
                        "identifier": entity,
                        "values": [
                          {
                            "name": entity['data']?['name'],
                            "data": entity,
                          }
                        ]
                      },
                      {
                        "key": "type",
                        "filterKey": "type",
                        "identifier": element['type'],
                        "values": [
                          {
                            "name": barChartData.x,
                            "data": element['type'],
                          }
                        ]
                      },
                      {
                        "key": "date",
                        "filterKey": "dateRange",
                        "identifier": {
                          "startDate": startDate,
                          "endDate": endDate,
                        },
                        "values": [
                          {
                            "name": "$formatedStart - $formatedEnd"

                            // "data": entity,
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
