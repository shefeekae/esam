import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/models/insights/insights_dropdown_model.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/schemas/communities_schema.dart';
import 'package:nectar_assets/core/services/communities/communites_insights_status_cards_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/functions/converters.dart';
import 'package:nectar_assets/ui/shared/functions/date_helpers.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../core/models/communities/community_insights_status_card_model.dart';
import '../../../../../../../core/services/communities/community_insights_services.dart';
import '../../../../../../shared/widgets/cards/status_cards.dart';
import '../../../alarms/list/alarms_list.dart';
import '../../../dashboards/screens/utilities/utilities_dashboard.dart';

class CommunityInsightsStatusCards extends StatelessWidget {
  CommunityInsightsStatusCards({
    required this.entity,
    required this.currentYear,
    this.communityDomain,
    this.parentEntity,
    this.insights,
    super.key,
    // required this.startDate,
    // required this.endDate,
  });

  final Map<String, dynamic> entity;
  final Insights? insights;
  final String? communityDomain;
  final Map<String, dynamic>? parentEntity;
  // final int startDate;
  // final int endDate;

  final CommunityInsightsStatusServices communityInsightsStatusServices =
      CommunityInsightsStatusServices();

  final int currentYear;

  final DateTime now = DateTime.now();

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> payload = {
      "period": currentYear,
      "comparePeriod": currentYear - 1,
      "month": DateHelpers().getBillGenerateMonth(),
    };

    String? identifier = entity['data']?['identifier'];

    if (insights == Insights.community) {
      payload['community'] = entity['data']?['identifier'];
    } else if (insights == Insights.subCommunity) {
      payload['subCommunity'] = entity;
    } else if (insights == Insights.site) {
      payload["site"] = entity;
    }

    return Column(
      children: [
        SizedBox(
          height: 70.sp,
          child: QueryWidget(
              options: GraphqlServices().getQueryOptions(
                rereadPolicy: true,
                query: CommunitySchemas.getEnergyIntensityConsolidation,
                variables: {
                  "data": payload,
                },
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return BuildShimmerLoadingWidget(
                    scrollDirection: Axis.horizontal,
                    height: 70.sp,
                    width: 120.sp,
                    padding: 0,
                  );
                }

                // if (result.hasException) {
                //   return GraphqlServices().handlingGraphqlExceptions(
                //     result: result,
                //     context: context,
                //     refetch: refetch,
                //   );
                // }

                List<CommunityInsightsStatusCardModel> list =
                    communityInsightsStatusServices
                        .getStatusCardList(result.data ?? {});

                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    CommunityInsightsStatusCardModel data = list[index];

                    Color? bgColor = data.color ??
                        communityInsightsStatusServices
                            .getIncreaseDecreaseColor(
                                increased: data.increased)['bgColor'];
                    Color? iconColor = communityInsightsStatusServices
                        .getIncreaseDecreaseColor(
                            increased: data.increased)['iconColor'];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UtilitiesDashboard(
                            level:
                                CommunityInsightsServices().getLevel(insights),
                            communityDomain: communityDomain,
                            parentEntity: parentEntity,
                            dropDownData: CommunityHierarchyDropdownData(
                              parentEntity: parentEntity,
                              displayName: entity['data']?['name'] ?? "",
                              entity: entity,
                              identifier: identifier ?? "",
                            ),
                          ),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: bgColor,
                        ),
                        width: 120.sp,
                        padding: EdgeInsets.all(5.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildHeader(data.name),
                            SizedBox(
                              height: 5.sp,
                            ),
                            buildCenter(
                              value: data.value,
                              iconColor: iconColor,
                              increased: data.increased,
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            buildFooter(
                              compareYearValue: data.compareYearValue,
                              year: data.compareYear,
                              percentage: data.percentage,
                              percentageColor: iconColor,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 5.sp);
                  },
                  itemCount: list.length,
                );
              }),
        ),
        SizedBox(
          height: 10.sp,
        ),
        SizedBox(
          height: 70.sp,
          child: QueryWidget(
              options: GraphqlServices().getQueryOptions(
                rereadPolicy: true,
                query: AlarmsSchema.getAlarmCount,
                variables: {
                  "filter": {
                    "searchTagIds": [
                      identifier,
                    ],
                    "status": ["active"],
                    "domain": userData.domain,
                  }
                },
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return BuildShimmerLoadingWidget(
                    scrollDirection: Axis.horizontal,
                    height: 70.sp,
                    width: 120.sp,
                    padding: 0,
                  );
                }

                // if (result.hasException) {
                //   return GraphqlServices().handlingGraphqlExceptions(
                //     result: result,
                //     context: context,
                //     refetch: refetch,
                //   );
                // }

                Map<String, dynamic> alarmCountMap =
                    result.data?['getAlarmCount'] ?? {};

                int criticalValue = alarmCountMap['critical'] ?? 0;
                int shutdownValue = alarmCountMap['shutdown'] ?? 0;

                List list = [
                  {
                    "title": "Active Critical Alarms",
                    "key": "critical",
                    "value": criticalValue,
                  },
                  {
                    "title": "Active Shutdown Alarms",
                    "key": "shutdown",
                    "value": shutdownValue,
                  },
                ];

                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = list[index];

                    String title = data['title'];
                    int value = data['value'];

                    return GestureDetector(
                      onTap: () {
                        String key = data['key'];

                        // DateFormat dateFormat = DateFormat("MMM, d - yyyy");

                        // String formatedStart = dateFormat.format(
                        //     DateTime.fromMillisecondsSinceEpoch(startDate));

                        // String formatedEnd = dateFormat.format(
                        //     DateTime.fromMillisecondsSinceEpoch(endDate));

                        // // Map<String, dynamic> dateRangeMap = {
                        // //   "key": "dateRange",
                        // //   "filterKey": "date",
                        // //   "identifier": {
                        // //     "startDate": startDate,
                        // //     "endDate": endDate,
                        // //   },
                        // //   "values": [
                        // //     {
                        // //       "name": "$formatedStart - $formatedEnd",
                        // //     }
                        // //   ]
                        // // };

                        Map<String, dynamic> map = {
                          "key": CommunityInsightsServices()
                              .getDrillDownFilterKey(insights),
                          "filterKey": "searchTagIds",
                          "identifier": [identifier],
                          "values": [
                            {
                              "name": entity['data']?['name'],
                              "data": entity,
                            }
                          ]
                        };

                        if (key == "critical") {
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
                              map,
                            ]
                          });
                        } else if (key == "shutdown") {
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
                              map,
                            ]
                          });
                        }
                      },
                      child: StatusCard(
                        title: title,
                        value: Converter().formatNumber(value.toDouble()),
                        color: Colors.red.shade800,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 5.sp);
                  },
                  itemCount: list.length,
                );
              }),
        ),
      ],
    );
  }

  // ==============

  Row buildFooter({
    required String year,
    required String compareYearValue,
    required String percentage,
    required Color? percentageColor,
  }) {
    TextStyle style = TextStyle(
      color: kWhite,
      fontSize: 8.sp,
      fontWeight: FontWeight.bold,
    );

    return Row(
      children: [
        Text(
          "$year $compareYearValue",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: style,
        ),
        Expanded(
          child: Text(
            " $percentage",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.copyWith(
              color: percentageColor,
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================

  Widget buildCenter({
    required String value,
    required Color? iconColor,
    required bool? increased,
  }) {
    if (increased == null) {
      return Text(
        value,
        maxLines: 1,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: kWhite,
        ),
      );
    }

    return Row(
      children: [
        Icon(
          increased ? Icons.arrow_downward : Icons.arrow_upward,
          color: iconColor,
          size: 20.sp,
        ),
        SizedBox(
          width: 3.sp,
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
        )
      ],
    );
  }

  // ==========================================

  Text buildHeader(String name) => Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 10.sp,
          color: kWhite,
          fontWeight: FontWeight.w600,
        ),
      );
}
