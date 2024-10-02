import 'package:app_filter_form/app_filter_form.dart';
import 'package:app_filter_form/shared/functions/update_map_keys.dart';
import 'package:app_filter_form/widgets/buttons/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/core/services/panels/panels_map_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/insights/fire_panel_insights_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/firepanels_list.dart';
import 'package:nectar_assets/ui/shared/widgets/map/loading_google_map.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/sheets/custom_draggable_sheet.dart';
import 'package:nectar_assets/ui/shared/widgets/map/google_map_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'widgets/fire_alarms_listview_builder.dart';
import 'widgets/fire_panel_dropdown.dart';

class FirePanelDashboardScreen extends StatefulWidget {
  const FirePanelDashboardScreen({super.key});

  static const String id = '/firepanel/dashboard';

  @override
  State<FirePanelDashboardScreen> createState() =>
      _FirePanelDashboardScreenState();
}

class _FirePanelDashboardScreenState extends State<FirePanelDashboardScreen> {
  final PagingController<int, EventLogs> pagingController =
      PagingController<int, EventLogs>(firstPageKey: 1);

  final UserDataSingleton userData = UserDataSingleton();

  late FilterAppliedBloc filterAppliedBloc;
  late FilterSelectionBloc filterSelectionBloc;
  late PayloadManagementBloc payloadManagementBloc;

  final ValueNotifier<Map<String, dynamic>> mapPayloadNotifier =
      ValueNotifier<Map<String, dynamic>>({});

  @override
  void initState() {
    payloadManagementBloc = BlocProvider.of<PayloadManagementBloc>(context);

    filterAppliedBloc = BlocProvider.of<FilterAppliedBloc>(context);
    filterSelectionBloc = BlocProvider.of<FilterSelectionBloc>(context);

    payloadManagementBloc.state.payload = {
      "status": ["active"],
      "workOrderStatus": "ALL",
      "groups": ["FIREALARM"],
      "types": ["FACP"],
    };

    super.initState();
  }

  @override
  void dispose() {
    filterSelectionBloc.state.filterLabelsMap[FilterType.alarmConsole] = [];

    filterAppliedBloc.state.filterAppliedCount = 0;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: PermissionChecking(
        featureGroup: "firePanelManagement",
        feature: "dashboard",
        permission: "view",
        showNoAccessWidget: true,
        child: Stack(
          children: [
            buildFireAlarmsGoogleMap(),
            draggableSheet(),
          ],
        ),
      ),
    );
  }

  // ============================================================================

  Widget buildFireAlarmsGoogleMap() {
    return ValueListenableBuilder(
      valueListenable: mapPayloadNotifier,
      builder: (context, value, child) {
        Map<String, dynamic> filter = {
          "domain": userData.domain,
          "offset": 1,
          "order": "asc",
          "type": ["FACP"],
          "sortField": "displayName",
          "pageSize": 1000,
          "fields": [
            "displayName",
            "type",
            "identifier",
            "domain",
            "location",
            "points"
          ]
        };

        filter.addAll(value);

        return StatefulBuilder(
          builder: (context, setState) => FutureBuilder(
            future: PanelsMapServices().getFirePanelsAndAlarms(
              context: context,
              payload: filter,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const GoogleMapLoadingWidget();
              }

              if (snapshot.hasError) {
                return TextButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text("Something went wrong, Retry"),
                );
              }

              Set<Marker> markers = snapshot.data ?? {};

              return GoogleMapWidget(
                markers: markers,
                zoom: 100,
              );
            },
          ),
        );

        // return StatefulBuilder(
        //   builder: (context, setState) {
        //     return FutureBuilder(
        //       future: AlarmsMapServices().getFireAlarmsMarkersforGoogleMap(
        //         context: context,
        //         payload: filter,
        //       ),
        //       builder: (context, snapshot) {
        //         bool isLoading =
        //             snapshot.connectionState == ConnectionState.waiting;

        //         if (isLoading) {
        //           return const GoogleMapLoadingWidget();
        //         }

        //         if (snapshot.hasError) {
        //           return buildErrorWidget(context, setState);
        //         }

        //         var markers = snapshot.data ?? {};

        //         return GoogleMapWidget(
        //           markers: markers,
        //         );
        //       },
        //     );
        //   },
        // );
      },
    );
  }

  // =============================================================================

  Stack buildErrorWidget(
    BuildContext context,
    StateSetter setState,
  ) {
    return Stack(
      children: [
        GoogleMapWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30.sp),
              decoration: BoxDecoration(
                color: ThemeServices().getContainerBgColor(context),
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextButton(
                onPressed: () {
                  setState(
                    () {},
                  );
                },
                child: const Text(
                  "Something went wrong,\n Please try again",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================================
  Widget draggableSheet() {
    return CustomDraggableScroallableSheet(
      minChildSize: 0.4,
      builder: (context, controller) => Column(
        children: [
          buildRowTextButtons(context),
          Expanded(
            child: FireAlarmsPaginatedBuilder(
              controller: controller,
              pagingController: pagingController,
            ),
          )
        ],
      ),
    );
  }

  // ===============================================
  Row buildRowTextButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(FirePanelInsightsScreen.id);
            },
            child: const Text("View Insights")),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(FirePanelListScreen.id);
          },
          child: const Text("View All Panels"),
        ),
      ],
    );
  }

  // =============================
  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(70.sp),
      child: Column(
        children: [
          AppBar(
            title: const Text(
              "Fire Panel Dashbaord",
            ),
            toolbarHeight: 30.sp,
            actions: [
              PermissionChecking(
                featureGroup: "firePanelManagement",
                feature: "dashboard",
                permission: "view",
                child: FilterButtonWidget(
                  onPressed: () async {
                    FilterWidgetHelpers().filterBottomSheet(
                      isMobile: true,
                      context: context,
                      filterType: FilterType.alarmConsole,
                      excludeFieldsKeys: [
                        "category",
                        "status",
                        "workOrders",
                        "dateRange",
                        "annotations",
                        "type",
                        "assets",
                        "criticality"
                      ],
                      initialValues: [],
                      saveButtonTap: (data) {
                        pagingController.refresh();
                        Map<String, dynamic> mapPayload =
                            mapPayloadNotifier.value;

                        data = updateTemplateKeys(
                          variables: data,
                          templateKey: "searchTagIds",
                          filterKey: "path",
                        );

                        if (data.isEmpty) {
                          mapPayloadNotifier.value = {};
                        } else {
                          mapPayload.addAll(data);
                          mapPayloadNotifier.value = Map.from(mapPayload);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          PermissionChecking(
            featureGroup: "firePanelManagement",
            feature: "dashboard",
            permission: "view",
            child: FirePanelsDropdownButton(
              onChanged: (dropdownValue) {
                Map<String, dynamic> payload =
                    payloadManagementBloc.state.payload;
                Map<String, dynamic> mapPayload = mapPayloadNotifier.value;

                if (dropdownValue == null) {
                  payload['entities'] = [];
                  mapPayload['path'] = [];
                } else {
                  payload['entities'] = [
                    dropdownValue,
                  ];
                  mapPayload['path'] = [
                    dropdownValue['data']?['identifier'],
                  ];
                }

                payloadManagementBloc.add(ChangePayloadEvent(payload: payload));
                mapPayloadNotifier.value = Map.from(mapPayload);

                pagingController.refresh();
              },
            ),
          )
        ],
      ),
    );
  }
}
