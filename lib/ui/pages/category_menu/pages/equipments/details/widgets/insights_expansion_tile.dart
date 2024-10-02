import 'package:app_filter_form/core/schemas/fiter_and_form_schema.dart';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/alarms/get_alarm_count_model.dart';
import 'package:nectar_assets/core/models/asset/asset_info_model.dart';
import 'package:nectar_assets/core/models/asset/assets_alarm_statistics_model.dart';
import 'package:nectar_assets/core/models/asset/assets_parts_model.dart'
    as asset_part;
import 'package:nectar_assets/core/models/service_logs_model.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/schemas/services_shemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:app_filter_form/core/services/filter_helpers.dart';
import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../shared/widgets/custom_expansion_tile.dart';
import 'container_with_icon_and_text.dart';
import 'status_container.dart';

class InsightsExpansionTile extends StatelessWidget {
  InsightsExpansionTile({
    super.key,
    required this.asset,
    required this.type,
  });

  final AssetData asset;
  final String? type;

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> assetEntity = {
      "type": type,
      "data": asset.toJson(),
    };

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: CustomExpansionTile(
        title: "Insights",
        children: [
          QueryWidget(
              options: GraphqlServices().getQueryOptions(
                query: FilterFormTemplateSchema.getFormTemplate,
                variables: {
                  'domain': userData.domain,
                  "name": "ASSET_DASHBOARD_ASSET_ALARM_STATISTICS",
                },
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.hasException) {
                  return GraphqlServices().handlingGraphqlExceptions(
                    result: result,
                    context: context,
                    refetch: refetch,
                  );
                }

                if (result.isLoading) {
                  return buildLoadingWidget(context);
                }

                var data = result.data ?? {};

                GetAssetAlarmsStatisticsData getAssetAlarmsStatisticsData =
                    GetAssetAlarmsStatisticsData.fromJson(
                        data['getFormTemplate'] ?? {});

                List<AlarmData> assetAlarmTemplateList =
                    getAssetAlarmsStatisticsData.data;

                return QueryWidget(
                  options: GraphqlServices().getQueryOptions(
                      query: AlarmsSchema.getAlarmCount,
                      variables: {
                        "filter": {
                          "status": ["active"],
                          "assets": [
                            assetEntity,
                          ],
                          "tags": true
                        }
                      }),
                  builder: (result, {fetchMore, refetch}) {
                    if (result.isLoading) {
                      return buildLoadingWidget(context);
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

                    GetAlarmCount? getAlarmCount =
                        getAlarmCountModel.getAlarmCount;

                    return SizedBox(
                      height: 70.sp,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          AlarmData alarmData = assetAlarmTemplateList[index];

                          String title =
                              FilterHelpers().getLabel(alarmData.i18NLabel);

                          String key = alarmData.key;

                          int? count = getAlarmCount?.toJson()[key];

                          String value = count == null ? "0" : count.toString();

                          return StatusCountContainer(
                            value: value,
                            title: title,
                            assets: asset,
                            type: type,
                            alarmKey: key,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 7.sp,
                          );
                        },
                        itemCount: assetAlarmTemplateList.length,
                      ),
                    );
                  },
                );
              }),
          //======================================================================
          //Pending and Upcoming Services
          PermissionChecking(
            featureGroup: "serviceManagement",
            feature: "serviceLogs",
            permission: "view",
            child: buildUpcomingServices(
              context,
              assetEntity: assetEntity,
            ),
          ),

          //======================================================================
          //Expiring parts
          PermissionChecking(
            featureGroup: "serviceManagement",
            feature: "servicePart",
            permission: "view",
            child: buildExpiringParts(),
          ),
        ],
      ),
    );
  }

  Skeletonizer buildLoadingWidget(BuildContext context) {
    return Skeletonizer(
        child: buildAssetAlarmLayout(
      context,
      criticalAlarmCount: "",
      lowAlarmCount: "",
      shutdownAlarmCount: "",
      totalAlarmCount: "",
    ));
  }

  Widget buildExpiringParts() {
    return Column(
      children: [
        SizedBox(
          height: 5.sp,
        ),
        const ContainerWithIconAndText(
          iconData: Icons.settings,
          value: "Expiring Parts",
        ),
        QueryWidget(
            options: GraphqlServices().getQueryOptions(
                query: AssetSchema.assetsPartsLiveQuery,
                variables: {
                  "body": {
                    "identifier": asset.identifier,
                  },
                  "queryParam": {
                    "page": 0,
                    "size": 5,
                  }
                }),
            builder: (result, {fetchMore, refetch}) {
              if (result.isLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              // if (result.hasException) {
              //   return GraphqlServices().handlingGraphqlExceptions(
              //     result: result,
              //     context: context,
              //     refetch: refetch,
              //   );
              // }

              var data = result.data;

              if (data == null) {
                return const Center(
                  child: Text("No data to show"),
                );
              }

              asset_part.AssetPartsModel assetPartsModel =
                  asset_part.assetPartsModelFromJson(data);

              List<asset_part.Item> assetParts =
                  assetPartsModel.assetPartsLive?.items ?? [];

              if (assetParts.isEmpty) {
                return const Center(
                  child: Text("No data to show"),
                );
              }

              return Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      asset_part.Item assetPart = assetParts[index];

                      return buildListTileWithDivider(
                          title: assetPart.name ?? "",
                          isLast: index ==
                              (assetParts.length > 3
                                  ? 2
                                  : assetParts.length - 1));
                    },
                    itemCount: assetParts.length > 3 ? 3 : assetParts.length,
                  ),
                  Visibility(
                    visible: assetParts.length > 3,
                    child: TextButton(
                        onPressed: () {}, child: const Text("View more")),
                  ),
                ],
              );
            }),
      ],
    );
  }

  Column buildUpcomingServices(
    BuildContext context, {
    required Map<String, dynamic> assetEntity,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 5.sp,
        ),
        const ContainerWithIconAndText(
          iconData: Icons.build,
          value: "Pending and Upcoming Services",
        ),
        QueryWidget(
            options: GraphqlServices().getQueryOptions(
                query: ServiceSchema.listPendingServiceLogs,
                variables: {
                  "data": {
                    "domain": userData.domain,
                    "states": [
                      "OVERDUE",
                      "DUE",
                      "REGISTERED",
                    ],
                    "assets": [
                      assetEntity,
                    ],
                    "filterType": "RUNHOURS",
                  },
                  "queryParam": {
                    "page": 0,
                    "size": 5,
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

              if (result.isLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              var data = result.data;

              LogsServiceModel logsServiceModel = logsServiceModelFromJson(
                data ?? {},
              );

              List<Item> items =
                  logsServiceModel.listPendingServiceLogs?.items ?? [];

              if (items.isEmpty) {
                return const Center(
                  child: Text("No data to show"),
                );
              }

              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Item item = items[index];

                      String dueDate = DateFormat("d MMM yyyy").add_jm().format(
                          DateTime.fromMillisecondsSinceEpoch(
                              item.service?.dueDate ?? 0));

                      return buildListTileWithDivider(
                        title: item.service?.name ?? "",
                        isLast:
                            index == (items.length > 3 ? 2 : items.length - 1),
                        trailingValue: dueDate,
                      );
                    },
                    itemCount: items.length > 3 ? 3 : items.length,
                  ),
                  Visibility(
                    visible: items.length > 3,
                    child: TextButton(
                        onPressed: () {}, child: const Text("View more")),
                  ),
                ],
              );
            }),
      ],
    );
  }

  Row buildAssetAlarmLayout(
    BuildContext context, {
    required String totalAlarmCount,
    required String criticalAlarmCount,
    required String shutdownAlarmCount,
    required String lowAlarmCount,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatusCountContainer(
          value: totalAlarmCount,
          title: "Total Alarms",
          assets: asset,
          type: type,
          alarmKey: "total",
        ),
        StatusCountContainer(
          title: "Critical Alarms",
          value: criticalAlarmCount,
          assets: asset,
          type: type,
          alarmKey: "critical",
        ),
        StatusCountContainer(
          title: "Shutdown Alarms",
          value: shutdownAlarmCount,
          assets: asset,
          type: type,
          alarmKey: "shutdown",
        ),
        StatusCountContainer(
          title: "Low Priority Alarms",
          value: lowAlarmCount,
          assets: asset,
          type: type,
          alarmKey: "lowPriority",
        ),
      ],
    );
  }

  getAssetAlarmCount(List<AlarmData> alarmData, String key) {
    for (int i = 0; i < alarmData.length; i++) {
      if (alarmData[i].key == key) {
        return alarmData[i].count.toString();
      }
    }
  }

  // =================================================================================

  Column buildListTileWithDivider({
    required String title,
    required bool isLast,
    String? trailingValue,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: trailingValue == null
              ? null
              : Text(
                  trailingValue,
                  style: TextStyle(
                    color: kGrey,
                  ),
                ),
        ),
        Visibility(
          visible: !isLast,
          child: Divider(
            height: 0,
            color: kGrey,
          ),
        ),
      ],
    );
  }
}
