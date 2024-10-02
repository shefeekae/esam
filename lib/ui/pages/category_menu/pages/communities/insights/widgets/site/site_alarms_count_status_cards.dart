import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/alarms_list.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../core/models/alarms/get_alarm_count_model.dart';
import '../../../../../../../shared/widgets/cards/status_cards.dart';

class SiteAlarmsCountStatusCard extends StatelessWidget {
  SiteAlarmsCountStatusCard({
    required this.identifier,
    required this.entity,
    super.key,
  });

  final String identifier;
  final Map<String, dynamic> entity;

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.sp,
      child: QueryWidget(
          options: GraphqlServices().getQueryOptions(
              rereadPolicy: true,
              query: AlarmsSchema.getAlarmCount,
              variables: {
                "filter": {
                  "searchTagIds": [identifier],
                  "status": ["active"],
                  "domain": userData.domain,
                }
              }),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return SizedBox(
                height: 80.sp,
                child: BuildShimmerLoadingWidget(
                  scrollDirection: Axis.horizontal,
                  height: 70.sp,
                  width: 120.sp,
                  padding: 0,
                  borderRadius: 7,
                ),
              );
            }

            if (result.hasException) {
              return GraphqlServices().handlingGraphqlExceptions(
                result: result,
                context: context,
                refetch: refetch,
              );
            }

            GetAlarmCountModel getAlarmCountModel =
                GetAlarmCountModel.fromJson(result.data ?? {});

            GetAlarmCount? getAlarmCount = getAlarmCountModel.getAlarmCount;

            List<Map> list = [
              {
                "title": "Total Alarms",
                "key": "total",
                "value": getAlarmCount?.total,
                "unacknowledged": getAlarmCount?.totalUnacknowledged,
              },
              {
                "title": "Shutdown Alarms",
                "key": "shutdown",
                "value": getAlarmCount?.shutdown,
                "unacknowledged": getAlarmCount?.shutdownUnacknowledged,
              },
              {
                "title": "Critical Alarms",
                "key": "critical",
                "value": getAlarmCount?.critical,
                "unacknowledged": getAlarmCount?.criticalUnacknowledged,
              },
              {
                "title": "High Alarms",
                "key": "high",
                "value": getAlarmCount?.high,
                "unacknowledged": getAlarmCount?.highUnacknowledged,
              },
              {
                "title": "Medium Alarms",
                "key": "medium",
                "value": getAlarmCount?.medium,
                "unacknowledged": getAlarmCount?.mediumUnacknowledged,
              },
              {
                "title": "Low Alarms",
                "key": "low",
                "value": getAlarmCount?.low,
                "unacknowledged": getAlarmCount?.lowUnacknowledged,
              },
              {
                "title": "Warning Alarms",
                "key": "warning",
                "value": getAlarmCount?.warning,
                "unacknowledged": getAlarmCount?.warningUnacknowledged,
              },
              {
                "title": "Actioned Alarms",
                "key": "actioned",
                "value": getAlarmCount?.actioned,
                // "unacknowledged": getAlarmCount?.,
              },
            ];

            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var map = list[index];

                String title = map['title'];
                int value = map['value'] ?? 0;
                int unacknowledged = map['unacknowledged'] ?? 0;

                String key = map['key'];

                return Bounce(
                  duration: const Duration(milliseconds: 100),
                  onPressed: () {
                    var buildingFilterValue = {
                      "key": "site",
                      "filterKey": "searchTagIds",
                      "identifier": [identifier],
                      "values": [
                        {
                          "name": entity['data']?['name'],
                          "data": entity,
                        }
                      ]
                    };

                    if (key == "total") {
                      Navigator.of(context).pushNamed(
                        AlarmsListScreen.id,
                        arguments: {
                          "filterValues": [
                            buildingFilterValue,
                          ],
                        },
                      );
                    } else {
                      Navigator.of(context).pushNamed(
                        AlarmsListScreen.id,
                        arguments: {
                          "filterValues": [
                            buildingFilterValue,
                            getFilterValue(key),
                          ],
                        },
                      );
                    }
                  },
                  child: StatusCard(
                    title: title,
                    value: value.toString(),
                    color: Theme.of(context).primaryColor,
                    child: unacknowledged == 0 && value == 0
                        ? null
                        : Text(
                            "$unacknowledged Unacknowledged",
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                              color: ThemeServices().getPrimaryFgColor(context),
                            ),
                          ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 5.sp,
                );
              },
              itemCount: list.length,
            );
          }),
    );
  }

  Map<String, dynamic> getFilterValue(String key) {
    switch (key) {
      // case "total":
      //   return {
      //     "key": "site",
      //     "filterKey": "searchTagIds",
      //     "identifier": [identifier],
      //     "values": [
      //       {
      //         "name": entity['data']?['name'],
      //         "data": entity,
      //       }
      //     ]
      //   };

      case "shutdown":
        return {
          "key": "category",
          "filterKey": "groups",
          "identifier": ["SHUTDOWN"],
          "values": [
            {
              "name": "Shutdown",
              "data": "SHUTDOWN",
            }
          ]
        };

      case "actioned":
        return {
          "key": "status",
          "filterKey": "status",
          "identifier": ["active", "actioned"],
          "values": [
            {
              "name": "Actioned",
              "data": "actioned",
              "aliasName": "other_status",
            }
          ]
        };

      case "critical":
      case "high":
      case "medium":
      case "low":
      case "warning":
        String name = getCriticalityValueAndLabel(key)['name'];
        String data = getCriticalityValueAndLabel(key)['data'];

        return {
          "key": "criticality",
          "filterKey": "criticalities",
          "identifier": [data],
          "values": [
            {
              "name": name,
              "data": data,
            }
          ]
        };
    }

    return {};
  }

  Map<String, dynamic> getCriticalityValueAndLabel(String key) {
    switch (key) {
      case "critical":
        return {
          "name": "Critical",
          "data": "CRITICAL",
        };

      case "high":
        return {
          "name": "High",
          "data": "HIGH",
        };
      case "medium":
        return {
          "name": "Medium",
          "data": "MEDIUM",
        };

      case "low":
        return {
          "name": "Low",
          "data": "LOW",
        };

      case "warning":
        return {
          "name": "Warning",
          "data": "WARNING",
        };

      default:
        return {};
    }
  }
}
