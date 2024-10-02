// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/details/widgets/recurring_alarm_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:nectar_assets/core/models/alarms/alarms_details_model.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/services/alarms/alarms_details_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import '../../../../../../core/models/alarms/suspect_points_model.dart';
import '../../../../../shared/widgets/custom_expansion_tile.dart';
import '../../../../../shared/widgets/data_table_widget.dart';
import 'enum/alarm_details_enum.dart';
import 'widgets/alarm_comments_widget.dart';
import 'widgets/alarm_header_with_loading.dart';
import 'widgets/consumption_alarm_widget.dart';
import 'widgets/diagnosis/diagnosis_expansion_tile.dart';
import 'widgets/live/alarm_live_data_table.dart';
import 'widgets/mitigation/build_mitigation_widget.dart';

// ignore: must_be_immutable
class AlarmsDetailsScreen extends StatelessWidget {
  AlarmsDetailsScreen({super.key});

  static const String id = '/alarms/details';

  final SizedBox sizedBox = SizedBox(height: 10.sp);

  final ValueNotifier expansionTileExpandNotifier =
      ValueNotifier(AlarmDetailsExpansioTileCategories.diagnosis);

  String? identifier;

  final SharedPrefrencesServices sharedPrefrencesServices =
      SharedPrefrencesServices();

  final ValueNotifier<String?> alarmNameNotifier =
      ValueNotifier<String?>("Alarm Details");

  void updateAppbarName(String? value) {
    Future.delayed(
      const Duration(milliseconds: 10),
      () {
        alarmNameNotifier.value = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    identifier = args?['identifier'];

    String? appThemeDecoded = sharedPrefrencesServices.getData(key: "appTheme");

    bool multipleAssetAlarms = appThemeDecoded == null
        ? false
        : jsonDecode(appThemeDecoded)?['eventLogConfiguration']
                ?['multipleAssetAlarms'] ??
            false;

    return Scaffold(
      appBar: buildAppbar(),
      body: PermissionChecking(
        featureGroup: "alarmManagement",
        feature: "list",
        permission: "view",
        showNoAccessWidget: true,
        child: Padding(
          padding: EdgeInsets.all(7.sp),
          child: QueryWidget(
              options: GraphqlServices().getQueryOptions(
                query: AlarmsSchema.getEventDetails,
                variables: {
                  "identifier": identifier,
                  "multipleAssetAlarms": multipleAssetAlarms,
                },
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return Skeletonizer(
                    child: buildLayout(
                      context: context,
                      isLoading: true,
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

                AlarmDetailsModel alarmDetailsModel =
                    alarmDetailsModelFromJson(result.data ?? {});

                AlarmsDetailsServices().acknowledgeAlarm(
                  context,
                  eventId:
                      alarmDetailsModel.getEventDetails?.event?.eventId ?? "",
                  isAcknowledged:
                      alarmDetailsModel.getEventDetails?.event?.acknowledged,
                );

                Event? event = alarmDetailsModel.getEventDetails?.event;

                updateAppbarName(event?.name);

                String? group = event?.group;
                String? type = event?.type;

                bool isPredectiveOrPreventive =
                    group == "PREDICTIVE" || group == "PREVENTIVE";

                if (isPredectiveOrPreventive && type == "RECCURING_ALARM") {
                  return RecurringAlarmWidget(
                    isLoading: result.isLoading,
                    alarmDetailsModel: alarmDetailsModel,
                  );
                } else if (isPredectiveOrPreventive && type == "Consumption") {
                  return ConsumptionAlarmWidget(event: event);
                }

                return buildLayout(
                  context: context,
                  isLoading: false,
                  alarmDetailsModel: alarmDetailsModel,
                );
              }),
        ),
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      title: ValueListenableBuilder(
          valueListenable: alarmNameNotifier,
          builder: (context, value, _) {
            String alarmName = value ??= "Alarm Details";

            return Text(alarmName);
          }),
    );
  }

  // =================================================================================

  ListView buildLayout(
      {required BuildContext context,
      required bool isLoading,
      AlarmDetailsModel? alarmDetailsModel}) {
    Event? event = alarmDetailsModel?.getEventDetails?.event;
    Latest? latest = alarmDetailsModel?.getEventDetails?.latest;

    List suspectPointsList = jsonDecode(event?.suspectData ?? "[]");

    List<Point> points = latest?.points ?? [];

    // Updating the appbar name state

    String eventId = event?.eventId ?? "";

    var suspectPointsData = AlarmsDetailsServices().getSuspectPointsTableData(
      points: points,
      suspecPoint: suspectPointsList,
    );

    return ListView(
      children: [
        buildHeaderCard(context, isLoading, alarmDetailsModel),
        sizedBox,
        ValueListenableBuilder(
            valueListenable: expansionTileExpandNotifier,
            builder: (context, value, _) {
              return Column(
                children: [
                  buildDiagnosisandReport(
                    sourceId: event?.sourceId ?? "",
                    eventId: eventId,
                    name: event?.name ?? "",
                  ),
                  sizedBox,
                  buildSuspectPoints(
                    context,
                    AlarmDetailsExpansioTileCategories.suspectPoints,
                    suspectPointsData: suspectPointsData,
                  ),
                  sizedBox,
                  buildMitigation(
                    eventId: eventId,
                  ),
                  sizedBox,
                  buildLive(
                    AlarmDetailsExpansioTileCategories.live,
                    sourceId: event?.sourceId ?? "",
                    suspectPoints: jsonDecode(event?.suspectData ?? "[]"),
                  ),
                  sizedBox,
                  PermissionChecking(
                    featureGroup: "alarmManagement",
                    feature: "list",
                    permission: "Comment",
                    child: buildComments(eventId),
                  ),
                ],
              );
            }),
      ],
    );
  }

  Widget buildHeaderCard(BuildContext context, bool isLoading,
      AlarmDetailsModel? alarmDetailsModel) {
    return BuildAlarmHeaderCardWithLoading(
      isLoading: isLoading,
      alarmDetailsModel: alarmDetailsModel,
    );
  }

  // ===========================================================================================

  Widget buildComments(String eventId) {
    return CustomExpansionTile(
      title: "Comments",
      onExpansionChanged: (value) {
        if (value) {
          // expansionTileExpandNotifier.value = category;
        }
      },
      // initiallyExpanded: expansionTileExpandNotifier.value == category,
      children: [
        BuildAlarmDetailsComments(
          eventId: eventId,
        )
      ],
    );
  }

// ==============================================================================

  Widget buildLive(
    AlarmDetailsExpansioTileCategories category, {
    required String sourceId,
    required List suspectPoints,
  }) {
    return CustomExpansionTile(
      title: "Live",
      onExpansionChanged: (value) {
        if (value) {
          // expansionTileExpandNotifier.value = category;
        }
      },
      initiallyExpanded: expansionTileExpandNotifier.value == category,
      children: [
        AlarmLiveDataTable(
          sourceId: sourceId,
          suspectPoints: suspectPoints,
        ),
      ],
    );
  }

  // ===================================================================================================
  // Build Mitigation

  Widget buildMitigation({
    required String eventId,
  }) {
    return CustomExpansionTile(
      title: "Mitigation",
      // initiallyExpanded: expansionTileExpandNotifier.value == category,
      onExpansionChanged: (value) {
        if (value) {
          // expansionTileExpandNotifier.value = category;
        }
      },
      children: [
        BuildMititgationWidget(
          eventId: eventId,
        ),
      ],
    );
  }

  // ==========================================================================================

  Widget buildSuspectPoints(
    BuildContext context,
    AlarmDetailsExpansioTileCategories category, {
    required List<SuspectPointsTableDataModel> suspectPointsData,
  }) {
    return CustomExpansionTile(
      title: "Suspect Points",
      onExpansionChanged: (value) {
        // if (value) {
        //   expansionTileExpandNotifier.value = category;
        // }
      },
      initiallyExpanded: expansionTileExpandNotifier.value == category,
      children: [
        BuildDataTableWidget(
          dataColumnsLabels: const [
            "Point",
            "Alarm Data",
            "Current Data",
            "Status",
          ],
          values: List.generate(suspectPointsData.length, (index) {
            var data = suspectPointsData[index];

            return {
              "Point": data.pointName,
              "Alarm Data": data.alarmData,
              "Current Data": data.currentData,
              "Status": data.status,
            };
          }),
        ),
      ],
    );
  }

  // ===================================================================================================

  Widget buildDiagnosisandReport({
    required String eventId,
    required String sourceId,
    required String name,
    bool initiallyExpanded = false,
  }) {
    return DiagnosisAndReportExpansionTile(
      eventId: eventId,
      initiallyExpanded: initiallyExpanded,
      name: name,
      sourceId: sourceId,
    );
  }
}
