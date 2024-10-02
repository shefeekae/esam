import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/enums/site_row_buttons_enum.dart';
import 'package:nectar_assets/core/models/custom_row_button_model.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/insights/community_hirearchy_insights_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/widgets/active_shutdown_alarms_bar_chart.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/widgets/alarms_space_distribution_pie_chart.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/widgets/energy_consumption_heat_map.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/widgets/space/space_widget.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/widgets/temperature_analysis_and_ranking_list.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/map/map_view_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/pages/summary_equipments.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/site/site_building_profile.dart';
import 'package:nectar_assets/ui/shared/functions/date_helpers.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_row_buttons.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../core/models/insights/insights_dropdown_model.dart';
import '../../../../../shared/widgets/buttons/date_range_button.dart';
import 'widgets/chw_energy_analysis_line_chart.dart';
import 'widgets/community_insights_status_card.dart';
import 'widgets/energy_consumption_space_distribution_chart.dart';
import 'widgets/header_widget.dart';
import 'widgets/site/site_alarms_widgets.dart';
import 'widgets/top_5_equipment_types_alarms_widget.dart';
import 'widgets/top_5_equipments_alarms.dart';
import 'widgets/top_5_subcommunites_prediction_list.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class CommunityHierarchyScreen extends StatefulWidget {
  final Insights insights;
  final CommunityHierarchyDropdownData? dropdownData;
  final String? communityIdentifier;
  final DateTimeRange? initialDateTimeRange;

  const CommunityHierarchyScreen(
      {required this.insights,
      required this.dropdownData,
      this.communityIdentifier,
      this.initialDateTimeRange,
      super.key});

  static const String id = "communities/insights";

  @override
  State<CommunityHierarchyScreen> createState() =>
      _CommunityHierarchyScreenState();
}

class _CommunityHierarchyScreenState extends State<CommunityHierarchyScreen> {
  final UserDataSingleton userData = UserDataSingleton();

  final ValueNotifier<List<CommunityHierarchyDropdownData>>
      dropdownListListNotifier =
      ValueNotifier<List<CommunityHierarchyDropdownData>>([]);

  final ValueNotifier<CommunityHierarchyDropdownData?>
      selectedDropdownValueNotifier =
      ValueNotifier<CommunityHierarchyDropdownData?>(null);

  final ValueNotifier<SiteType> siteTypeNotifier =
      ValueNotifier<SiteType>(SiteType.insights);

  late ValueNotifier<DateTimeRange> dateTimeRangeNotifier;

  final DateTime now = DateTime.now();

  CommunityHierarchyServices communityHierarchyServices =
      CommunityHierarchyServices();

  late Insights insights;

  @override
  void initState() {
    dateTimeRangeNotifier = ValueNotifier<DateTimeRange>(
      widget.initialDateTimeRange ??
          DateHelpers().getPreviousMonthAndCurrentDateTime(),
    );

    insights = widget.insights;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: PermissionChecking(
        featureGroup: "clientManagement",
        feature: "clients",
        permission: "view",
        showNoAccessWidget: true,
        child: Builder(builder: (context) {
          if (insights == Insights.site || insights == Insights.space) {
            Map<String, dynamic> entity = widget.dropdownData?.entity ?? {};

            return buildLayout(
              entity: entity,
            );
          }

          return QueryWidget(
            options: GraphqlServices().getQueryOptions(
                query:
                    communityHierarchyServices.getDropdownQueryMethod(insights),
                variables: communityHierarchyServices.getDropdownQueryPayload(
                  insights,
                  communityDomain: widget.communityIdentifier,
                )),
            // GraphqlServices().getQueryOptions(
            //   query: CommunitySchemas.listAllCommunities,
            //   variables: {
            //     "domain": userData.domain,
            //   },
            // ),
            builder: (result, {fetchMore, refetch}) {
              if (result.isLoading) {
                return buildLoadingWidget();
              }

              if (result.hasException) {
                return GraphqlServices().handlingGraphqlExceptions(
                  result: result,
                  context: context,
                  refetch: refetch,
                );
              }

              // List<Community> communityList =
              //     ListAllCommunitiesModel.fromJson(result.data ?? {})
              //             .listAllCommunities ??
              //         [];

              List<CommunityHierarchyDropdownData> dropdownValues =
                  communityHierarchyServices.getDrodpdownValues(
                entity: widget.dropdownData?.parentEntity ?? {},
                resultData: result.data ?? {},
                insights: insights,
              );

              if (dropdownValues.isEmpty) {
                return const SizedBox();
              }

              Future.delayed(
                const Duration(
                  milliseconds: 100,
                ),
                () {
                  dropdownListListNotifier.value = dropdownValues;
                },
              );

              if (insights == Insights.community) {
                Future.delayed(
                  const Duration(
                    milliseconds: 100,
                  ),
                  () {
                    CommunityHierarchyDropdownData? defaultCommunity =
                        dropdownValues.singleWhereOrNull(
                            (element) => element.defaultValue == "true");

                    if (defaultCommunity == null) {
                      selectedDropdownValueNotifier.value =
                          dropdownValues.first;
                    } else {
                      selectedDropdownValueNotifier.value = defaultCommunity;
                    }
                  },
                );
              } else {
                selectedDropdownValueNotifier.value = widget.dropdownData;
              }

              return ValueListenableBuilder<CommunityHierarchyDropdownData?>(
                valueListenable: selectedDropdownValueNotifier,
                builder: (context, value, child) {
                  if (value == null) {
                    // First time the community value is null because the ui render after the community value will be set.
                    return buildLoadingWidget();
                  }

                  Map<String, dynamic> entity = value.entity;

                  return buildLayout(
                    entity: entity,
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }

  // ====================================================================
  // Build layout

  ValueListenableBuilder<DateTimeRange> buildLayout({
    required Map<String, dynamic> entity,
  }) {
    String identifier = entity['data']?['identifier'] ?? "";

    return ValueListenableBuilder<DateTimeRange>(
        valueListenable: dateTimeRangeNotifier,
        builder: (context, dateTimeRange, _) {
          int startDate = dateTimeRange.start.millisecondsSinceEpoch;
          int endDate = dateTimeRange.end.millisecondsSinceEpoch;

          return Padding(
            padding: EdgeInsets.all(7.sp),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: DateRangePickerButton(
                    initialDateTimeRange: dateTimeRangeNotifier.value,
                    onChanged: (dateTimeRange) {
                      dateTimeRangeNotifier.value = dateTimeRange;
                    },
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: 10.sp,
                      ),
                      buildHeader(),
                      SizedBox(
                        height: 10.sp,
                      ),
                      bulidCustomRowButtons(),
                      ValueListenableBuilder(
                          valueListenable: siteTypeNotifier,
                          builder: (context, type, _) {
                            if (insights == Insights.site &&
                                type == SiteType.alarms) {
                              return SiteAlarmsWidgets(
                                identifier: identifier,
                                entity: entity,
                              );
                            }

                            if (insights == Insights.space) {
                              return SpaceInsightsWidgets(
                                startDate: dateTimeRange.start,
                                endDate: dateTimeRange.end,
                                spaceId: identifier,
                              );
                            }

                            return Column(
                              children: [
                                Visibility(
                                  visible: Insights.space != insights,
                                  child: CommunityInsightsStatusCards(
                                    entity: entity,
                                    currentYear: now.year,
                                    insights: insights,
                                    communityDomain: widget.communityIdentifier,
                                    parentEntity:
                                        widget.dropdownData?.parentEntity,
                                    // startDate: startDate,
                                    // endDate: endDate,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                // TODO: This widget is only showing in Site Insights and Sapce Insights
                                Visibility(
                                  visible: insights == Insights.site ||
                                      insights == Insights.space,
                                  child:
                                      TemperatureAnalysisStatusCardsAndRankingList(
                                    startDate: dateTimeRange.start,
                                    endDate: dateTimeRange.end,
                                    siteId: identifier,
                                    entity: entity,
                                  ),
                                ),
                                EnergyConsumptionSpaceDistributionChart(
                                  entity: entity,
                                  startDate: startDate,
                                  endDate: endDate,
                                  insights: insights,
                                  communityId: selectedDropdownValueNotifier
                                      .value?.identifier,
                                ),
                                ChwEnergyAnalysisLineChart(
                                  startDate: startDate,
                                  id: identifier,
                                  insights: insights,
                                ),
                                //TODO; This widget is not showing in Site Insights
                                Visibility(
                                  visible: insights != Insights.site &&
                                      insights != Insights.space,
                                  child:
                                      Top5SubCommunitiesHeirarchyPredictionList(
                                    startDate: startDate,
                                    endDate: endDate,
                                    identifier: identifier,
                                    insights: insights,
                                    entity: entity,
                                  ),
                                ),
                                AlarmSpaceDistributionPieChart(
                                  startDate: startDate,
                                  endDate: endDate,
                                  entity: entity,
                                  insights: insights,
                                ),
                                Visibility(
                                  visible: Insights.space != insights,
                                  child: EnergyConsumptionHeatMap(
                                    startDate: dateTimeRange
                                        .start.millisecondsSinceEpoch,
                                    endDate: dateTimeRange
                                        .end.millisecondsSinceEpoch,
                                    insights: insights,
                                    entity: entity,
                                  ),
                                ),
                                ActiveAndShutdownCriticalAlarmsBarChart(
                                  identifier: identifier,
                                  entity: entity,
                                  insights: insights,
                                ),
                                Top5EquipmentTypesAlarmsWidget(
                                  startDate: startDate,
                                  endDate: endDate,
                                  entity: entity,
                                  insights: insights,
                                ),
                                Top5EquipmentsAlarmsWidget(
                                  startDate: startDate,
                                  endDate: endDate,
                                  entity: entity,
                                  insights: insights,
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  // =================================================================
  // This widget only showing the insights screen is site insights.

  Widget bulidCustomRowButtons() {
    return Visibility(
      visible: insights == Insights.site,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.sp),
          child: CustomRowButtons(
            valueListenable: siteTypeNotifier,
            onChanged: (itemKey) {
              siteTypeNotifier.value = itemKey as SiteType;
            },
            items: [
              CustomButtonModel(
                title: "Insights",
                itemKey: SiteType.insights,
              ),
              CustomButtonModel(
                title: "Alarms",
                itemKey: SiteType.alarms,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================

  BuildShimmerLoadingWidget buildLoadingWidget() {
    return BuildShimmerLoadingWidget(
      height: 50.sp,
    );
  }

  // ===========================================================================
  AppBar buildAppbar() {
    return AppBar(
      title: Builder(builder: (context) {
        if (insights == Insights.site || insights == Insights.space) {
          return Text(widget.dropdownData?.displayName ?? "");
        }

        return ValueListenableBuilder<List<CommunityHierarchyDropdownData>>(
          valueListenable: dropdownListListNotifier,
          builder: (context, value, child) {
            if (value.isEmpty) {
              return Text(
                communityHierarchyServices.getAppBarTitle(insights),
              );
            }

            return ValueListenableBuilder<CommunityHierarchyDropdownData?>(
                valueListenable: selectedDropdownValueNotifier,
                builder: (context, selectedValue, _) {
                  String? identifier = selectedValue?.identifier;

                  return DropdownButton(
                    isExpanded: true,
                    underline: const SizedBox(),
                    value: identifier,
                    items: List.generate(
                      value.length,
                      (index) {
                        String? identifier = value[index].identifier;

                        return DropdownMenuItem(
                          value: identifier,
                          child: Text(
                            value[index].displayName,
                          ),
                          onTap: () {
                            selectedDropdownValueNotifier.value = value[index];
                          },
                        );
                      },
                    ),
                    onChanged: (value) {},
                  );
                });
          },
        );
      }),
      actions: [
        //  Enabling the floor summary button in Space Insights
        Visibility(
          visible: insights == Insights.space,
          child: IconButton(
            onPressed: () {
              String identifier = widget.dropdownData?.identifier ?? "";

              String name = widget.dropdownData?.displayName ?? "";

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return SummaryEquipmentsScreen(
                    name: name,
                    identifier: identifier,
                  );
                },
              ));
            },
            icon: const Icon(
              Icons.summarize_outlined,
            ),
          ),
        ),

        // Enabling the site profile button in Site Insights
        Visibility(
          visible: insights == Insights.site,
          child: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(BuildingProfileScreen.id, arguments: {
                "siteEntity": widget.dropdownData?.entity,
              });
            },
            icon: const Icon(
              Icons.person,
            ),
          ),
        ),

        // Disabling the map view screen in site insights and space insights
        Visibility(
          visible: insights != Insights.site && insights != Insights.space,
          child: IconButton(
            onPressed: () {
              if (selectedDropdownValueNotifier.value != null) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MapViewScreen(
                    communityHierarchyDropdownData:
                        selectedDropdownValueNotifier.value!,
                    insights: insights,
                  ),
                ));
              }
            },
            icon: const Icon(
              Icons.map_outlined,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================================
  Widget buildHeader() {
    CommunityHierarchyDropdownData? insightsDropdownData =
        selectedDropdownValueNotifier.value ?? widget.dropdownData;

    return CommunityHierarchyHeaderWidget(
      typeName: insightsDropdownData?.typeName,
      displayName: insightsDropdownData?.displayName,
      locationName: insightsDropdownData?.locationName,
    );
  }
}
