import 'package:app_filter_form/app_filter_form.dart';
import 'package:app_filter_form/widgets/buttons/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/asset/assets_list_model.dart';
import 'package:nectar_assets/core/models/custom_row_button_model.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/core/services/permissions/user_permission_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/enum/panel_details_screentypes.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/search/alarms_search.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/search/equipment_search.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/widgets/panel_alarms_listview.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/widgets/panel_equipment_listview.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_row_buttons.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:sizer/sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:app_filter_form/shared/functions/update_map_keys.dart';

class PanelDetailsScreen extends StatefulWidget {
  const PanelDetailsScreen({super.key});

  static String id = "panelDetails";

  @override
  State<PanelDetailsScreen> createState() => _PanelDetailsScreenState();
}

class _PanelDetailsScreenState extends State<PanelDetailsScreen>
    with TickerProviderStateMixin {
  late PayloadManagementBloc payloadManagementBloc;

  late PagingController<int, EventLogs> alarmPagingController;
  late PagingController<int, Assets> assetsPagingController;

  final ValueNotifier<PanelDetailsScreenType> screenNotifier =
      ValueNotifier<PanelDetailsScreenType>(
          PanelDetailsScreenType.activeAlarms);

  final ValueNotifier<String> searchValueNotifier = ValueNotifier<String>("");

  bool alarmPermission = UserPermissionServices().checkingPermission(
    featureGroup: "alarmManagement",
    feature: "list",
    permission: "list",
  );

  bool assetPermission = UserPermissionServices().checkingPermission(
    featureGroup: "assetManagement",
    feature: "assetList",
    permission: "list",
  );

  late String firePanelDomain;
  late String firePanelIdentifier;

  late FilterAppliedBloc filterAppliedBloc;
  late FilterSelectionBloc filterSelectionBloc;

  @override
  void initState() {
    payloadManagementBloc = BlocProvider.of<PayloadManagementBloc>(context);
    filterSelectionBloc = BlocProvider.of<FilterSelectionBloc>(context);
    filterAppliedBloc = BlocProvider.of<FilterAppliedBloc>(context);

    alarmPagingController = PagingController(firstPageKey: 1);

    assetsPagingController = PagingController(firstPageKey: 1);

    payloadManagementBloc.state.payload = {};

    super.initState();
  }

  @override
  void dispose() {
    filterAppliedBloc.state.filterAppliedCount = 0;
    filterSelectionBloc.state.filterLabelsMap[FilterType.firePanelDetails] = [];

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    firePanelDomain = args?['domain'] ?? "";
    firePanelIdentifier = args?['identifier'] ?? "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Panel Details"),
        actions: [
          PermissionChecking(
            featureGroup: "firePanelManagement",
            feature: "dashboard",
            permission: "view",
            child: ValueListenableBuilder(
                valueListenable: searchValueNotifier,
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return buildSearchIconButton(
                        context: context, showCloseIcon: false);
                  }
                  //===================================================
                  //Alarm Search
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          String? alarmName = await showSearch<String?>(
                            context: context,
                            delegate: PanelAlarmsSearchDelegate(),
                            query: value,
                          );

                          if (alarmName != null) {
                            searchValueNotifier.value = alarmName;
                            payloadManagementBloc.state.payload['names'] = [
                              alarmName
                            ];
                            alarmPagingController.refresh();
                          }
                        },
                        child: SizedBox(
                          width: 35.w,
                          child: Text(
                            value,
                            maxLines: 2,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      buildSearchIconButton(
                          context: context, showCloseIcon: true),
                    ],
                  );
                }),
          ),
          ValueListenableBuilder(
              valueListenable: screenNotifier,
              builder: (context, screenType, child) {
                return FilterButtonWidget(
                  onPressed: () {
                    FilterWidgetHelpers().filterBottomSheet(
                      context: context,
                      filterType: FilterType.firePanelDetails,
                      isMobile: true,
                      initialValues: [],
                      saveButtonTap: (value) {
                        if (value.isEmpty) {
                          payloadManagementBloc.state.payload = {};
                        }

                        if (screenType == PanelDetailsScreenType.activeAlarms) {
                          payloadManagementBloc.state.payload =
                              updateTemplateKeys(
                            variables: payloadManagementBloc.state.payload,
                            templateKey: "type",
                            filterKey: "types",
                          );

                          alarmPagingController.refresh();
                        } else {
                          payloadManagementBloc.state.payload = updateKeys(
                              variables: payloadManagementBloc.state.payload);

                          assetsPagingController.refresh();
                        }
                      },
                    );
                  },
                  // icon: const Icon(Icons.filter_alt_outlined),
                );
              }),
        ],
      ),
      body: Center(
        child: PermissionChecking(
          featureGroup: "firePanelManagement",
          feature: "dashboard",
          permission: "view",
          showNoAccessWidget: true,
          child: Column(
            children: [
              Builder(builder: (context) {
                if (!alarmPermission || !assetPermission) {
                  return const SizedBox();
                }

                return CustomRowButtons(
                  valueListenable: screenNotifier,
                  onChanged: (itemKey) {
                    if (searchValueNotifier.value.isNotEmpty) {
                      searchValueNotifier.value = "";
                      payloadManagementBloc.state.payload = {};
                    }

                    var variables = payloadManagementBloc.state.payload;

                    if (itemKey == PanelDetailsScreenType.activeAlarms) {
                      if (variables.containsKey("path")) {
                        variables["searchTagIds"] = variables["path"];

                        variables.remove("path");
                      }

                      variables = updateTemplateKeys(
                        variables: variables,
                        templateKey: "type",
                        filterKey: "types",
                      );
                    } else {
                      if (variables.containsKey("searchTagIds")) {
                        variables["path"] = variables["searchTagIds"];

                        variables.remove("searchTagIds");
                      }

                      variables = updateTemplateKeys(
                        variables: variables,
                        templateKey: "types",
                        filterKey: "type",
                      );
                    }

                    payloadManagementBloc.state.payload = variables;

                    screenNotifier.value = itemKey as PanelDetailsScreenType;

                    if (itemKey == PanelDetailsScreenType.activeAlarms) {
                      alarmPagingController.refresh();
                    } else {
                      assetsPagingController.refresh();
                    }
                  },
                  items: [
                    CustomButtonModel(
                      title: "Active Alarms",
                      itemKey: PanelDetailsScreenType.activeAlarms,
                    ),
                    CustomButtonModel(
                      title: "All Equipments",
                      itemKey: PanelDetailsScreenType.allEquipments,
                    ),
                  ],
                );
              }),
              Builder(builder: (context) {
                if (alarmPermission) {
                  screenNotifier.value = PanelDetailsScreenType.activeAlarms;
                } else {
                  screenNotifier.value = PanelDetailsScreenType.allEquipments;
                }

                return Expanded(
                    child: ValueListenableBuilder(
                  valueListenable: screenNotifier,
                  builder: (context, value, child) {
                    if (value == PanelDetailsScreenType.activeAlarms) {
                      return PanelAlarmsListView(
                        alarmPagingController: alarmPagingController,
                        domain: firePanelDomain,
                        identifier: firePanelIdentifier,
                      );
                    }

                    return PanelEquipmentsListView(
                      assetsPagingController: assetsPagingController,
                      domain: firePanelDomain,
                      identifier: firePanelIdentifier,
                    );
                  },
                ));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchIconButton({
    required BuildContext context,
    required bool showCloseIcon,
  }) {
    return ValueListenableBuilder(
        valueListenable: screenNotifier,
        builder: (context, value, child) {
          return IconButton(
            onPressed: () async {
              if (value == PanelDetailsScreenType.activeAlarms) {
                if (showCloseIcon) {
                  payloadManagementBloc.state.payload['names'] = [];
                  alarmPagingController.refresh();

                  searchValueNotifier.value = '';

                  return;
                }

                List searchedNames =
                    payloadManagementBloc.state.payload['names'] ?? [];

                String? alarmName = await showSearch<String?>(
                  context: context,
                  delegate: PanelAlarmsSearchDelegate(),
                  query: searchedNames.isEmpty ? "" : searchedNames.first,
                );

                if (alarmName != null) {
                  searchValueNotifier.value = alarmName;
                  payloadManagementBloc.state.payload['names'] = [alarmName];
                  alarmPagingController.refresh();
                }
              } else {
                showSearch(
                    context: context,
                    delegate: PanelEquipmentSearchDelegate(entity: {
                      "type": "FACP",
                      "data": {
                        "identifier": firePanelIdentifier,
                        "domain": firePanelDomain,
                      }
                    }));
              }
            },
            icon: Icon(showCloseIcon ? Icons.close : Icons.search),
          );
        });
  }
}

// =======================================================================================================
// Used to change template api key to filter key

Map<String, dynamic> updateKeys({
  required Map<String, dynamic> variables,
}) {
  if (variables.containsKey("searchTagIds")) {
    variables["path"] = variables["searchTagIds"];

    variables.remove("searchTagIds");
  }

  return variables;
}
