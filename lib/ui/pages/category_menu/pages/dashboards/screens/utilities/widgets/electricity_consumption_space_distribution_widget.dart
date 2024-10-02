import 'package:flutter/material.dart';
import 'package:graphql/src/core/query_result.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/models/charts/pie_chart_model.dart';
import 'package:nectar_assets/core/models/dashboard/utilities_space_distribution_data_model.dart';
import 'package:nectar_assets/core/models/insights/insights_dropdown_model.dart';
import 'package:nectar_assets/core/schemas/dashboard_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/utilities_dashboard.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/widgets/served_to_equipments.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/equipment_details.dart';
import 'package:nectar_assets/ui/shared/functions/converters.dart';
import 'package:nectar_assets/ui/shared/widgets/chart/pie_chart_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:nectar_assets/ui/shared/widgets/container_with_text.dart';
import 'package:nectar_assets/ui/shared/widgets/sheets/custom_modal_bottomsheet.dart';
import 'package:secure_storage/model/user_data_model.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ElectricityConsumptionSpaceDistributionWidget extends StatelessWidget {
  ElectricityConsumptionSpaceDistributionWidget({
    super.key,
    required this.yearValue,
    required this.compareYearValue,
    this.identifier,
    required this.level,
    this.entity,
  });

  final int yearValue;
  final int compareYearValue;
  final String? identifier;
  final Map<String, dynamic>? entity;
  final Level level;

  final UserDataSingleton userData = UserDataSingleton();

  List<ChartData> chartData = [];

  ValueNotifier<bool> isChartNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "currentYear": yearValue.toString(),
      "previousYear": compareYearValue.toString(),
      "forCost": false,
      "meterType": "LVPMeter",
    };

    if (entity != null) {
      String? identifier = entity?['data']?['identifier'];
      if (level == Level.community) {
        data['community'] = identifier;
      }

      if (level == Level.subCommunity) {
        data["subCommunity"] = entity;
        data.remove("domain");
      }

      if (level == Level.site) {
        data["site"] = entity;
        data.remove("domain");
      }

      if (level == Level.equipment) {
        data["equipment"] = entity;
        data.remove("domain");
      }

      if (level == Level.subMeter) {
        data["subMeter"] = entity;
        data.remove("domain");
      }
    } else {
      data['domain'] = userData.domain;
    }

    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
          query: DashboardSchema.getUtilitiesSpaceDistributionData,
          rereadPolicy: true,
          variables: {"data": data}),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return Skeletonizer(
              enabled: true, child: buildLayout(result, context, [], []));
        }

        if (result.hasException) {
          return GraphqlServices().handlingGraphqlExceptions(
            result: result,
            context: context,
            refetch: refetch,
          );
        }

        var data = result.data ?? {};

        List<ChartData> list = [];

        UtilitiesSpaceDistributionDataModel utilitiesSpaceDistributionData =
            UtilitiesSpaceDistributionDataModel.fromJson(data);

        List<GetUtilitiesSpaceDistributionData>?
            utilitiesSpaceDistributionDatalist =
            utilitiesSpaceDistributionData.getUtilitiesSpaceDistributionData;

        if (utilitiesSpaceDistributionDatalist == null) {
          return const SizedBox();
        }

        // int totalCount = getTotalCount(utilitiesSpaceDistributionDatalist);

        list = utilitiesSpaceDistributionDatalist.map((e) {
          String domain = e.data?.data?.domain ?? "";

          String identifier = e.data?.data?.identifier ?? "";
          String type = e.data?.type ?? "";

          double count = e.value?.toDouble() ?? 0;

          String label = e.label ?? "";

          return ChartData(
              label: label,
              value: count.toDouble(),
              utilityEntity: {
                "domain": domain,
                "identifier": identifier,
                "type": type,
                "name": label
              });
        }).toList();

        list.sort((a, b) => b.value.compareTo(a.value));

        // Step 2: Retrieve the top 5 elements
        chartData = list.length > 5 ? list.take(5).toList() : list;

        // Step 3: Compute the sum of the remaining values
        if (list.length > 5) {
          double sumOtherValues =
              list.skip(5).map((e) => e.value).reduce((a, b) => a + b);

          if (sumOtherValues != 0) {
            chartData.add(ChartData(
              label: "Others",
              value: sumOtherValues.toDouble(),
            ));
          }
        }

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.sp),
          child: buildLayout(
              result, context, utilitiesSpaceDistributionDatalist, list),
        );
      },
    );
  }

  Widget buildLayout(
      QueryResult<dynamic> result,
      BuildContext context,
      List<GetUtilitiesSpaceDistributionData> consumptionList,
      List<ChartData> list) {
    String? title;

    if (consumptionList.isNotEmpty) {
      title = consumptionList.first.data?.type;

      if (title == "CommercialTower" || title == "ResidentialTower") {
        title = "Site";
      } else if (title == "LVPMeter") {
        title = "Equipment";
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: 4.sp),
      child: BgContainer(
        title:
            "Electricity Consumption Space Distribution updated on December $yearValue (as per DEWA bills)",
        child: ValueListenableBuilder(
            valueListenable: isChartNotifier,
            builder: (context, isChart, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      isChartNotifier.value = !isChartNotifier.value;
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: Container(
                        padding: EdgeInsets.all(3.sp),
                        height: 35.sp,
                        width: 70.sp,
                        decoration: BoxDecoration(
                            color: ThemeServices().getContainerBgColor(context),
                            // color: Colors.red,
                            borderRadius: BorderRadius.circular(
                              5.sp,
                            )),
                        child: Stack(
                          children: [
                            Positioned(
                              left: isChart ? 0 : 35.sp,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ThemeServices().getBgColor(context),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                height: 30.sp,
                                width: 30.sp,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.sp),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.pie_chart_outline_rounded),
                                  Icon(Icons.list)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  isChart
                      ? PieChartWidget(
                          symbol: "Kwh",
                          chartData: chartData,
                          isLoading: result.isLoading,
                          onDoubleTap: (chartData) {
                            if (chartData.label == "Others") {
                              var othersList = list.skip(5).toList();

                              othersList.sort(
                                (a, b) => b.value.compareTo(a.value),
                              );

                              showCustomModalBottomSheet(
                                  context: context,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          "Others",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: ListView.builder(
                                        itemCount: othersList.length,
                                        itemBuilder: (context, index) {
                                          var chartData = othersList[index];

                                          return ListTile(
                                            onTap: () {
                                              drilldown(chartData, context);
                                            },
                                            title: Text(chartData.label),
                                            trailing: Text(
                                                "${Converter().formatNumber(chartData.value)} Kwh"),
                                          );
                                        },
                                      ))
                                    ],
                                  ));

                              return;
                            }

                            drilldown(chartData, context);
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.sp),
                          child: SizedBox(
                            height: 200.sp,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      title ?? "",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Consumption ($compareYearValue)",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        var consumptionData =
                                            consumptionList[index];

                                        String title =
                                            consumptionData.label ?? "";
                                        String value = Converter().formatNumber(
                                            consumptionData.value?.toDouble() ??
                                                0);

                                        String identifier = consumptionData
                                                .data?.data?.identifier ??
                                            "";
                                        String domain = consumptionData
                                                .data?.data?.domain ??
                                            "";

                                        String type =
                                            consumptionData.data?.type ?? "";

                                        dynamic premiseNumber =
                                            consumptionData.premiseNumber;

                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4.sp),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: ThemeServices()
                                                  .getContainerBgColor(context),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: ListTile(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(title),
                                                  Visibility(
                                                      visible:
                                                          level == Level.site,
                                                      child: ContainerWithTextWidget(
                                                          value:
                                                              "Premise No. $premiseNumber")),
                                                ],
                                              ),
                                              trailing: SizedBox(
                                                width: 100.sp,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "$value Kwh",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible:
                                                          level == Level.site,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            height: 20.sp,
                                                            width: 20.sp,
                                                            decoration: BoxDecoration(
                                                                color: ThemeServices()
                                                                    .getBgColor(
                                                                        context),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.sp)),
                                                            child: IconButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(
                                                                        MaterialPageRoute(
                                                                  builder: (context) => ServedToEquipmentsScreen(
                                                                      name:
                                                                          title,
                                                                      identifier:
                                                                          identifier),
                                                                ));
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .cable_rounded,
                                                                size: 8.sp,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5.sp,
                                                          ),
                                                          Container(
                                                            height: 20.sp,
                                                            width: 20.sp,
                                                            decoration: BoxDecoration(
                                                                color: ThemeServices()
                                                                    .getBgColor(
                                                                        context),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.sp)),
                                                            child: IconButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pushNamed(
                                                                        EquipmentDetailsScreen
                                                                            .id,
                                                                        arguments: {
                                                                      "type":
                                                                          type,
                                                                      "identifier":
                                                                          identifier,
                                                                      "displayName":
                                                                          title,
                                                                      "domain":
                                                                          domain,
                                                                    });
                                                              },
                                                              icon: Icon(
                                                                Icons.speed,
                                                                size: 8.sp,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                Level? dropdownLevel =
                                                    getDropdownType(level);

                                                if (dropdownLevel != null) {
                                                  // String displayName = chartData.entity.data.name;

                                                  Map<String, dynamic>
                                                      hierarchyEntity = {
                                                    "data": {
                                                      "domain": domain,
                                                      "identifier": identifier,
                                                      "name": title,
                                                    },
                                                    "type": type
                                                  };

                                                  CommunityHierarchyDropdownData
                                                      dropdownData =
                                                      CommunityHierarchyDropdownData(
                                                    parentEntity: entity,
                                                    displayName: "",
                                                    entity: hierarchyEntity,
                                                    identifier: identifier,
                                                  );

                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        UtilitiesDashboard(
                                                      communityDomain:
                                                          entity?["data"]
                                                              ?["identifier"],
                                                      level: dropdownLevel,
                                                      dropDownData:
                                                          dropdownData,
                                                      parentEntity: entity,
                                                    ),
                                                  ));
                                                }
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          Divider(
                                            height: 3.sp,
                                          ),
                                      itemCount: consumptionList.length),
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              );
            }),
      ),
    );
  }

  void drilldown(ChartData chartData, BuildContext context) {
    Level? type = getDropdownType(level);

    if (type != null) {
      // String displayName = chartData.entity.data.name;

      Map<String, dynamic> hierarchyEntity = {
        "data": {
          "domain": chartData.utilityEntity?["domain"],
          "identifier": chartData.utilityEntity?["identifier"],
          "name": chartData.utilityEntity?["name"]
        },
        "type": chartData.utilityEntity?["type"]
      };

      CommunityHierarchyDropdownData dropdownData =
          CommunityHierarchyDropdownData(
        parentEntity: null,
        displayName: "",
        entity: hierarchyEntity,
        identifier: chartData.utilityEntity?["identifier"],
      );

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => UtilitiesDashboard(
          communityDomain: entity?["data"]?["identifier"],
          level: type,
          dropDownData: dropdownData,
          parentEntity: entity,
        ),
      ));
    }
  }

  Level? getDropdownType(Level level) {
    if (entity == null) {
      return Level.community;
    }

    switch (level) {
      case Level.community:
        return Level.subCommunity;

      case Level.subCommunity:
        return Level.site;

      case Level.site:
        return Level.equipment;

      case Level.equipment:
        return Level.subMeter;

      default:
        return null;
    }
  }

  int getTotalCount(List<GetUtilitiesSpaceDistributionData> list) {
    int totalCount = 0;

    totalCount = list.fold(0, (previousValue, element) {
      previousValue = totalCount += element.value?.toInt() ?? 0;

      return previousValue;
    });

    return totalCount;
  }

  double calculatePercentage(double value, double total) {
    // Ensure the total value is not zero to avoid division by zero
    if (total == 0) {
      throw ArgumentError('Total value should not be zero');
    }

    // Calculate the percentage of the value with respect to the total
    double result = (value / total) * 100;
    return result;
  }
}
