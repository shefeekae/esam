import 'package:app_filter_form/app_filter_form.dart';
import 'package:app_filter_form/widgets/buttons/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/services/alarms/alarms_map_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/permissions/user_permission_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/alarms_list.dart';
import 'package:nectar_assets/ui/shared/widgets/container_with_listtile.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/sheets/custom_draggable_sheet.dart';
import 'package:nectar_assets/ui/shared/widgets/map/google_map_widget.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/models/list_alarms_model.dart';
import '../../../../../shared/widgets/map/loading_google_map.dart';

class FireAlarmsDashboardScreen extends StatefulWidget {
  FireAlarmsDashboardScreen({super.key});

  static const String id = '/firealarms/dashboard';

  @override
  State<FireAlarmsDashboardScreen> createState() =>
      _FireAlarmsDashboardScreenState();
}

class _FireAlarmsDashboardScreenState extends State<FireAlarmsDashboardScreen> {
  final UserDataSingleton userData = UserDataSingleton();

  late FilterSelectionBloc filterSelectionBloc;
  late FilterAppliedBloc filterAppliedBloc;

  late Map<String, dynamic> mapPayload;

  List<Map<String, dynamic>> getFireAlarmCategoryArray(
      Map<String, dynamic> inputMap) {
    List<Map<String, dynamic>> result = [];

    inputMap.forEach((key, value) {
      result.add({
        "title": key,
        "count": value,
      });
    });

    for (var element in result) {
      if (element['title'] == "Fire Alarm") {
        result.remove(element);
        result.insert(0, element);
        break;
      }
    }

    return result;
  }

  final bool hasPermission = UserPermissionServices().checkingPermission(
      featureGroup: "fireAlarmManagement",
      feature: "dashboard",
      permission: "view");

  final ValueNotifier<Map<String, dynamic>> payloadNotfier =
      ValueNotifier<Map<String, dynamic>>({});

  @override
  void initState() {
    PayloadManagementBloc payloadManagementBloc =
        BlocProvider.of<PayloadManagementBloc>(context);

    filterSelectionBloc = BlocProvider.of<FilterSelectionBloc>(context);
    filterAppliedBloc = BlocProvider.of<FilterAppliedBloc>(context);

    payloadManagementBloc.state.payload = {};

    mapPayload = {
      "domain": userData.domain,
      "offset": 1,
      "pageSize": 10,
      "status": ["active"],
      "workOrderStatus": "ALL",
      "groups": ["LIFEANDSAFETY", "FIREALARM"],
    };

    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    filterSelectionBloc.state.filterLabelsMap[FilterType.fireDasboardFilter] =
        [];

    filterAppliedBloc.state.filterAppliedCount = 0;

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: PermissionChecking(
        featureGroup: "fireAlarmManagement",
        feature: "dashboard",
        permission: "view",
        showNoAccessWidget: true,
        child: Stack(
          children: [
            buildAlarmsMap(),
            draggableSheet(),
          ],
        ),
      ),
    );
  }

  // ============================================================================

  Widget buildAlarmsMap() {
    return ValueListenableBuilder(
      valueListenable: payloadNotfier,
      builder: (context, value, _) {
        var statePayload = value;

        if (statePayload.containsKey("searchTagIds")) {
          dynamic searchTagIds = statePayload['searchTagIds'];

          if (searchTagIds.runtimeType == List) {
            List list = searchTagIds.map((e) {
              return e['data']?['identifier'];
            }).toList();
            mapPayload['searchTagIds'] = list;
          } else {
            mapPayload['searchTagIds'] = [searchTagIds['data']?['identifier']];
          }
        }

        statePayload.forEach((key, value) {
          if (key != "searchTagIds") {
            mapPayload[key] = value;
          }
        });

        return StatefulBuilder(builder: (context, setState) {
          return FutureBuilder(
            future: GraphqlServices().performQuery(
              query: AlarmsSchema.listAlarmsQuery,
              variables: {
                "filter": mapPayload,
              },
            ),
            builder: (context, snapshot) {
              bool isLoading =
                  snapshot.connectionState == ConnectionState.waiting;

              if (isLoading) {
                return const GoogleMapLoadingWidget();
              }

              var result = snapshot.data!;

              if (result.hasException) {
                return GraphqlServices().handlingGraphqlExceptions(
                  result: result,
                  context: context,
                  setState: setState,
                );
              }

              var model = ListAlarmsModel.fromJson(result.data ?? {});

              List<EventLogs> eventLogs = model.listAlarms?.eventLogs ?? [];

              return GoogleMapWidget(
                  markers: AlarmsMapServices().convertToMarkerData(
                context: context,
                alarms: eventLogs,
              ));
            },
          );
        });
      },
    );
  }

  // ================================================================================
  CustomDraggableScroallableSheet draggableSheet() {
    Map<String, dynamic> payload = {
      "domain": userData.domain,
      "status": ["active"],
      "facetField": "name",
      "groups": [
        "LIFEANDSAFETY",
      ]
    };

    return CustomDraggableScroallableSheet(
      builder: (context, controller) {
        return ValueListenableBuilder(
            valueListenable: payloadNotfier,
            builder: (context, value, child) {
              Map<String, dynamic> statePayload = value;

              if (statePayload.containsKey("searchTagIds")) {
                dynamic searchTagIds = statePayload['searchTagIds'];

                if (searchTagIds.runtimeType == List) {
                  payload['accessFilter']?['entities'] = searchTagIds;
                  payload.remove("entity");
                } else {
                  payload['entity'] = searchTagIds;
                  payload.remove("accessFilter");
                }
              }

              statePayload.forEach((key, value) {
                if (key != "searchTagIds") {
                  payload[key] = value;
                }
              });

              print("payload: $payload");

              return StatefulBuilder(builder: (context, setState) {
                return FutureBuilder(
                  future: GraphqlServices().performQuery(
                    query: AlarmsSchema.getTotalEventConsolidation,
                    variables: {
                      "data": payload,
                    },
                  ),
                  builder: (context, snapshot) {
                    bool isLoading =
                        snapshot.connectionState == ConnectionState.waiting;

                    if (isLoading) {
                      return BuildShimmerLoadingWidget(
                        height: 40.sp,
                      );
                    }

                    var result = snapshot.data!;

                    if (result.hasException) {
                      return GrapghQlClientServices().handlingGraphqlExceptions(
                        result: result,
                        context: context,
                        setState: setState,
                        // refetch: refetch,
                      );
                    }

                    Map<String, dynamic> resultMap =
                        result.data?['getTotalEventConsolidation']
                                ?['responseMap'] ??
                            {};

                    List<Map> alarmTypes = getFireAlarmCategoryArray(resultMap);

                    if (alarmTypes.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 15.sp),
                        child: const Text("No data to show"),
                      );
                    }

                    return ListView.separated(
                      controller: controller,
                      itemCount: alarmTypes.length,
                      padding: EdgeInsets.all(8.sp),
                      itemBuilder: (context, index) {
                        var map = alarmTypes[index];

                        String title = map['title'];

                        bool isFireAlarm = title == "Fire Alarm";

                        Color? txtColor = isFireAlarm ? kWhite : null;

                        return ContainerWithListTile(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AlarmsListScreen.id, arguments: {
                              "filterValues": [
                                isFireAlarm
                                    ? {
                                        "key": "category",
                                        "filterKey": "groups",
                                        "identifier": ["FIREALARM"],
                                        "values": [
                                          {
                                            "name": title,
                                            "data": "FIREALARM",
                                          },
                                        ],
                                      }
                                    : {
                                        "key": "category",
                                        "filterKey": "groups",
                                        "identifier": [
                                          "FIREALARM",
                                          "LIFEANDSAFETY"
                                        ],
                                        "values": [
                                          {
                                            "name": "Fire Alarm",
                                            "data": "FIREALARM",
                                          },
                                          {
                                            "name": "Life And Safety",
                                            "data": "LIFEANDSAFETY",
                                          },
                                        ],
                                      }
                              ],
                              "categories": isFireAlarm
                                  ? ["FIREALARM"]
                                  : [
                                      "FIREALARM",
                                      "LIFEANDSAFETY",
                                    ],
                              "searchValue": isFireAlarm ? "" : title,
                            });
                          },
                          bgColor: isFireAlarm
                              ? Colors.red
                              : ThemeServices().getContainerBgColor(context),
                          title: title,
                          titleTextStyle: TextStyle(
                            color: txtColor,
                            fontWeight: FontWeight.bold,
                          ),
                          trailing: Text(
                            map['count'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: txtColor,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10.sp,
                        );
                      },
                    );
                  },
                );
              });
            });
      },
    );
  }

  // ============================================================================
  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text("Fire Alarm Dashboard"),
      actions: [
        Visibility(
          visible: hasPermission,
          child: FilterButtonWidget(
            onPressed: () async {
              await FilterWidgetHelpers().filterBottomSheet(
                isMobile: true,
                context: context,
                filterType: FilterType.fireDasboardFilter,
                initialValues: [],
                saveButtonTap: (value) {
                  payloadNotfier.value = value;
                },
              );
            },
            // icon: const Icon(Icons.filter_alt),
          ),
        ),
      ],
    );
  }
}
