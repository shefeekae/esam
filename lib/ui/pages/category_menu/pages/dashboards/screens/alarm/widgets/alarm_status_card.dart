import 'package:app_filter_form/app_filter_form.dart';
import 'package:app_filter_form/shared/functions/update_map_keys.dart';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/services/alarms/alarm_status_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/alarms_list.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AlarmStatusCard extends StatelessWidget {
  AlarmStatusCard({
    super.key,
    this.entity,
    required this.startDate,
    required this.endDate,
  });
  final Map<String, dynamic>? entity;
  final int startDate;
  final int endDate;
  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("MMM, d - yyyy");

    String formatedStart =
        dateFormat.format(DateTime.fromMillisecondsSinceEpoch(startDate));

    String formatedEnd =
        dateFormat.format(DateTime.fromMillisecondsSinceEpoch(endDate));

    Map<String, dynamic> dateRangeMap = {
      "key": "dateRange",
      "filterKey": "date",
      "identifier": {
        "startDate": startDate,
        "endDate": endDate,
      },
      "values": [
        {
          "name": "$formatedStart - $formatedEnd",
        }
      ]
    };

    return SizedBox(
      height: 60.sp,
      child: BlocBuilder<PayloadManagementBloc, PayloadManagementState>(
        builder: (context, state) {
          Map<String, dynamic> payload = {
            "domain": userData.domain,
            "status": ["active"],
          };

          if (entity != null) {
            payload["searchTagIds"] = entity?["data"]?["identifier"];
          }

          return QueryWidget(
              options: GraphqlServices().getQueryOptions(
                query: AlarmsSchema.getAlarmCount,
                rereadPolicy: true,
                variables: {
                  "filter": payload,
                },
              ),
              builder: (result, {fetchMore, refetch}) {
               

                if (result.isLoading) {
                  return ListView.separated(
                    padding: EdgeInsets.only(
                      left: 5.sp,
                      right: 5.sp,
                      bottom: 5.sp,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ShimmerLoadingContainerWidget(
                        width: 80.sp,
                        borderRadius: 5,
                        // height: 60.sp,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 5.sp,
                      );
                    },
                    itemCount: 4,
                  );
                }
                
                 if (result.hasException) {
                  return GraphqlServices().handlingGraphqlExceptions(
                    result: result,
                    context: context,
                    refetch: refetch,
                  );
                }

                Map<String, dynamic>? data = result.data?['getAlarmCount'];

                Color primaryFgColor =
                    ThemeServices().getPrimaryFgColor(context);

                List<Map<String, dynamic>> statusListData =
                    AlarmStatusServices()
                        .getStatusListData(context, data: data);

                return ListView.separated(
                  padding: EdgeInsets.only(
                    left: 5.sp,
                    right: 5.sp,
                    bottom: 5.sp,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Map<String, dynamic>? map = statusListData[index];

                    String title = map['title'] ?? "";
                    int count = map['count'] ?? 0;

                    List<Color> colors = map['colors'];

                    Color? textColor = map['textColor'];

                    return GestureDetector(
                      onTap: () {
                        if (title == "Active Alarms") {
                          Navigator.of(context).pushNamed(AlarmsListScreen.id);
                        } else if (title == "Shutdown") {
                          Navigator.of(context)
                              .pushNamed(AlarmsListScreen.id, arguments: {
                            "filterValues": [
                              {
                                "key": "category",
                                "filterKey": "groups",
                                "identifier": ["SHUTDOWN"],
                                "values": [
                                  {
                                    "name": "Shutdown",
                                    "data": "SHUTDOWN",
                                  }
                                ]
                              },
                            ]
                          });
                        } else if (title == "Critical") {
                          Navigator.of(context)
                              .pushNamed(AlarmsListScreen.id, arguments: {
                            "filterValues": [
                              {
                                "key": "criticality",
                                "filterKey": "criticalities",
                                "identifier": ["CRITICAL"],
                                "values": [
                                  {
                                    "name": "Critical",
                                    "data": "CRITICAL",
                                  }
                                ]
                              },
                            ]
                          });
                        } else if (title == "High") {
                          Navigator.of(context)
                              .pushNamed(AlarmsListScreen.id, arguments: {
                            "filterValues": [
                              {
                                "key": "criticality",
                                "filterKey": "criticalities",
                                "identifier": ["HIGH"],
                                "values": [
                                  {
                                    "name": "High",
                                    "data": "HIGH",
                                  }
                                ]
                              },
                            ]
                          });
                        } else if (title == "Medium") {
                          Navigator.of(context)
                              .pushNamed(AlarmsListScreen.id, arguments: {
                            "filterValues": [
                              {
                                "key": "criticality",
                                "filterKey": "criticalities",
                                "identifier": ["MEDIUM"],
                                "values": [
                                  {
                                    "name": "Medium",
                                    "data": ["MEDIUM"],
                                  }
                                ]
                              },
                            ]
                          });
                        } else if (title == "Low") {
                          Navigator.of(context)
                              .pushNamed(AlarmsListScreen.id, arguments: {
                            "filterValues": [
                              {
                                "key": "criticality",
                                "filterKey": "criticalities",
                                "identifier": ["LOW"],
                                "values": [
                                  {
                                    "name": "Low",
                                    "data": ["LOW"],
                                  }
                                ]
                              },
                            ]
                          });
                        } else if (title == "Warning") {
                          Navigator.of(context)
                              .pushNamed(AlarmsListScreen.id, arguments: {
                            "filterValues": [
                              {
                                "key": "criticality",
                                "filterKey": "criticalities",
                                "identifier": ["WARNING"],
                                "values": [
                                  {
                                    "name": "Warning",
                                    "data": ["WARNING"],
                                  }
                                ]
                              },
                            ]
                          });
                        } else if (title == "Unacknowledged") {
                          Navigator.of(context)
                              .pushNamed(AlarmsListScreen.id, arguments: {
                            "filterValues": [
                              {
                                "key": "status",
                                "filterKey": "status",
                                "identifier": ["active", "unacknowledged"],
                                "values": [
                                  {
                                    "name": "Active",
                                    "aliasName": "active_resolved",
                                    "data": "active",
                                  },
                                  {
                                    "name": "Unacknowledged",
                                    "aliasName": "ack_unacknowledged",
                                    "data": "unacknowledged",
                                  },
                                ]
                              },
                            ]
                          });
                        }
                      },
                      child: Container(
                        width: 80.sp,
                        decoration: BoxDecoration(
                          color: colors.first,
                          borderRadius: BorderRadius.circular(5),
                          gradient: colors.length == 1
                              ? null
                              : LinearGradient(
                                  colors: colors,
                                  // begin: Alignment.centerLeft,
                                  // end: Alignment.center,
                                ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: textColor ?? primaryFgColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                AlarmStatusServices().convertToK(count),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: textColor ?? primaryFgColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
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
                  itemCount: statusListData.length,
                );
              });
        },
      ),
    );
  }
}
