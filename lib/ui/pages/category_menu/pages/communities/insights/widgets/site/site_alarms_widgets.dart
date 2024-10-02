import 'package:app_filter_form/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/models/communities/community_hierarchy_args_model.dart';
import 'package:nectar_assets/core/models/custom_row_button_model.dart';
import 'package:nectar_assets/core/models/insights/insights_dropdown_model.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/schemas/site_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/communites_insights_screen.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../../core/models/alarms/get_alarm_count_model.dart';
import '../../../../../../../../core/models/site/find_all_space_of_site_model.dart';
import '../../../../../../../shared/widgets/buttons/custom_row_buttons.dart';
import 'site_alarms_count_status_cards.dart';

enum SiteAlarmsArea {
  floors,
  commonArea,
  rooms,
}

class SiteAlarmsWidgets extends StatelessWidget {
  SiteAlarmsWidgets({
    super.key,
    required this.identifier,
    required this.entity,
  });

  final String identifier;
  final Map<String, dynamic> entity;

  final ValueNotifier<SiteAlarmsArea> rowButtonsNotifier =
      ValueNotifier<SiteAlarmsArea>(SiteAlarmsArea.floors);

  final List buttonsList = [
    {
      "title": "Floors",
      "key": SiteAlarmsArea.floors,
    },
    {
      "title": "Common Area",
      "key": SiteAlarmsArea.commonArea,
    },
    {
      "title": "Rooms",
      "key": SiteAlarmsArea.rooms,
    }
  ];

  String getSpaceType(SiteAlarmsArea siteAlarmsArea) {
    switch (siteAlarmsArea) {
      case SiteAlarmsArea.floors:
        return "Floor";

      case SiteAlarmsArea.commonArea:
        return "CommonArea";
      case SiteAlarmsArea.rooms:
        return "Room";
    }
  }

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      // shrinkWrap: true,
      children: [
        SiteAlarmsCountStatusCard(
          identifier: identifier,
          entity: entity,
        ),
        SizedBox(
          height: 5.sp,
        ),
        Align(
          alignment: Alignment.center,
          child: CustomRowButtons(
            valueListenable: rowButtonsNotifier,
            onChanged: (itemKey) {
              rowButtonsNotifier.value = itemKey as SiteAlarmsArea;
            },
            items: buttonsList
                .map(
                  (e) => CustomButtonModel(
                    title: e['title'],
                    itemKey: e['key'],
                  ),
                )
                .toList(),
          ),
        ),
        ValueListenableBuilder(
            valueListenable: rowButtonsNotifier,
            builder: (context, value, _) {
              return QueryWidget(
                  options: GraphqlServices().getQueryOptions(
                    rereadPolicy: true,
                    query: SiteSchema.findAllSpacesOfSite,
                    variables: {
                      "site": entity,
                      "spaceType": getSpaceType(value),
                    },
                  ),
                  builder: (result, {fetchMore, refetch}) {
                    if (result.isLoading) {
                      return BuildShimmerLoadingWidget(
                        shrinkWrap: true,
                        height: 40.sp,
                      );
                    }
    
                    FindAllSpacesOfSiteModel findAllSpacesOfSiteModel =
                        FindAllSpacesOfSiteModel.fromJson(result.data ?? {});
    
                    List<FindAllSpacesOfSite> spaces =
                        findAllSpacesOfSiteModel.findAllSpacesOfSite ?? [];
    
                    String searchValue = "";
    
                    return StatefulBuilder(builder: (context, setState) {
                      var filteredValues = spaces.where((element) {
                        String name = element.data?.name ?? "";
    
                        return name
                            .toLowerCase()
                            .contains(searchValue.toLowerCase());
                      }).toList();
    
                      return Column(
                        children: [
                          SizedBox(
                            height: 30.sp,
                            child: TextField(
                              onChanged: (value) {
                                setState(
                                  () {
                                    searchValue = value;
                                  },
                                );
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 4.sp, horizontal: 6.sp),
                                  hintText: "Search",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(7))),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                            child: Builder(builder: (context) {
                              if (spaces.isEmpty) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 30.sp),
                                  child: const Center(
                                    child: Text("Data not found"),
                                  ),
                                );
                              }
    
                              return ListView.separated(
                                // shrinkWrap: true,
                                padding: EdgeInsets.only(top: 10.sp),
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var space = filteredValues[index];
    
                                  return Bounce(
                                    duration:
                                        const Duration(milliseconds: 100),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        CommunityHierarchyScreen.id,
                                        arguments: CommunityHierarchyArgs(
                                          insights: Insights.space,
                                          dropdownData:
                                              CommunityHierarchyDropdownData(
                                                parentEntity: entity,
                                            displayName:
                                                space.data?.name ?? "",
                                            typeName: space.data?.typeName,
                                            entity: {
                                              "type": space.type,
                                              "data": {
                                                "domain": space.data?.domain,
                                                "identifier":
                                                    space.data?.identifier,
                                                "name": space.data?.name,
                                              }
                                            },
                                            identifier:
                                                space.data?.identifier ?? "",
                                          ),
                                        ),
                                      );
                                    },
                                    child: BgContainer(
                                      padding: EdgeInsets.all(7.sp),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(space.data?.name ?? ""),
                                          SizedBox(
                                            height: 5.sp,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.notifications_none,
                                                size: 8.sp,
                                              ),
                                              SizedBox(
                                                width: 3.sp,
                                              ),
                                              Text(
                                                "Alarms",
                                                style: TextStyle(
                                                  fontSize: 8.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.sp,
                                          ),
                                          buildAlarmCountQueryWidget(space)
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 7.sp,
                                  );
                                },
                                itemCount: filteredValues.length,
                              );
                            }),
                          ),
                        ],
                      );
                    });
                  });
            })
      ],
    );
  }

  // ==================================================================================

  QueryWidget buildAlarmCountQueryWidget(FindAllSpacesOfSite space) {
    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
          rereadPolicy: true,
          query: AlarmsSchema.getAlarmCount,
          variables: {
            "filter": {
              "status": ["active"],
              "domain": userData.domain,
              "searchTagIds": [
                space.data?.identifier,
              ]
            }
          },
        ),
        builder: (result, {fetchMore, refetch}) {
          GetAlarmCountModel getAlarmCountModel = GetAlarmCountModel.fromJson(
            result.data ?? {},
          );

          GetAlarmCount? getAlarmCount = getAlarmCountModel.getAlarmCount;

          int critical = getAlarmCount?.critical ?? 0;

          int medium = getAlarmCount?.medium ?? 0;
          int low = getAlarmCount?.low ?? 0;

          return Skeletonizer(
            enabled: result.isLoading,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildAlarmCountWithTitle(
                  count: critical.toString(),
                  title: "Critical",
                  color: Colors.red.shade700,
                ),
                buildAlarmCountWithTitle(
                  count: medium.toString(),
                  title: "Medium",
                  color: Colors.amber,
                ),
                buildAlarmCountWithTitle(
                  count: low.toString(),
                  title: "Low",
                  color: Colors.amber.shade700,
                ),
              ],
            ),
          );
        });
  }

  Widget buildAlarmCountWithTitle({
    required String count,
    required String title,
    required Color color,
  }) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color,
          maxRadius: 10.sp,
          child: Text(count),
        ),
        SizedBox(
          width: 5.sp,
        ),
        Text(title)
      ],
    );
  }
}
