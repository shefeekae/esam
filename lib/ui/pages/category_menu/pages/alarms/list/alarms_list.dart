import 'package:app_filter_form/app_filter_form.dart';
import 'package:app_filter_form/widgets/buttons/filter_button.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/core/models/custom_row_button_model.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/core/services/alarms/alarms_pagination_services.dart';
import 'package:nectar_assets/core/services/permissions/user_permission_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/enum/alarms_screens_types.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/search/alarms_search_delgate.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_row_buttons.dart';
import 'package:nectar_assets/ui/shared/widgets/images/no_access_image_widget.dart';
import 'package:sizer/sizer.dart';
import 'widgets/alarms_console.dart';
import 'widgets/alarms_insights.dart';

class AlarmsListScreen extends StatefulWidget {
  const AlarmsListScreen({super.key});

  static const String id = '/alarms/list';

  @override
  State<AlarmsListScreen> createState() => _AlarmsListScreenState();
}

class _AlarmsListScreenState extends State<AlarmsListScreen> {
  late PayloadManagementBloc payloadManagementBloc;
  late FilterSelectionBloc filterSelectionBloc;
  late FilterAppliedBloc filterAppliedBloc;

  AlarmsPaginationServices alarmsPaginationServices =
      AlarmsPaginationServices();

  late PagingController<int, EventLogs> pagingController;

  final ValueNotifier<String> searchValueNotifier = ValueNotifier<String>("");

  Map<String, dynamic> initialPayload = {
    "status": ["active"],
    "workOrderStatus": "ALL",
  };

  @override
  void initState() {
    payloadManagementBloc = BlocProvider.of<PayloadManagementBloc>(context);
    filterSelectionBloc = BlocProvider.of<FilterSelectionBloc>(context);
    filterAppliedBloc = BlocProvider.of<FilterAppliedBloc>(context);

    pagingController = PagingController(firstPageKey: 1);

    // payloadManagementBloc.state.payload = {
    //   "status": ["active"],
    //   "workOrderStatus": "ALL",
    // };

    // filterAppliedBloc.state.filterAppliedCount = 2;

    super.initState();
  }

  @override
  void dispose() {
    filterSelectionBloc.state.filterLabelsMap[FilterType.alarmConsole] = [];

    filterAppliedBloc.state.filterAppliedCount = 0;

    super.dispose();
  }

  final ValueNotifier<AlarmScreenType> valueNotifier =
      ValueNotifier<AlarmScreenType>(AlarmScreenType.console);

  bool consolePermission = UserPermissionServices().checkingPermission(
    featureGroup: "alarmManagement",
    feature: "list",
    permission: "list",
  );

  bool insightsPermission = UserPermissionServices().checkingPermission(
    featureGroup: "alarmManagement",
    feature: "insights",
    permission: "view",
  );

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    List<String> categories = args?['categories'] ?? [];
    String searchValue = args?['searchValue'] ?? "";

    if (categories.isNotEmpty) {
      initialPayload['groups'] = categories;
    }

    List<Map<String, dynamic>> filterValues = args?['filterValues'] ?? [];

    if (filterValues.isNotEmpty) {
      for (var element in filterValues) {
        String filterKey = element['filterKey'] ?? '';

        if (filterKey == "date") {
          Map<String, dynamic> map = element['identifier'] ?? {};

          initialPayload.addAll(map);

          continue;
        }

        if (filterKey.isNotEmpty) {
          initialPayload[filterKey] = element['identifier'];
        }
      }
    }

    filterAppliedBloc.state.filterAppliedCount = initialPayload.keys.length;

    if (searchValue.isNotEmpty) {
      initialPayload['names'] = [searchValue];
      searchValueNotifier.value = searchValue;
    }

    payloadManagementBloc.state.payload = initialPayload;

    return Scaffold(
      appBar: buildAppBar(
        context,
        filterValues,
      ),
      body: Column(
        children: [
          Builder(builder: (context) {
            if (!consolePermission || !insightsPermission) {
              return const SizedBox();
            }

            return CustomRowButtons(
              valueListenable: valueNotifier,
              onChanged: (itemKey) {
                valueNotifier.value = itemKey as AlarmScreenType;
              },
              items: [
                CustomButtonModel(
                  title: "Console",
                  itemKey: AlarmScreenType.console,
                ),
                CustomButtonModel(
                  title: "Insights",
                  itemKey: AlarmScreenType.insights,
                ),
              ],
            );
          }),
          Builder(builder: (_) {
            if (!insightsPermission && !consolePermission) {
              return const Center(
                child: NoAccessImageWidget(),
              );
            }

            if (insightsPermission && !consolePermission) {
              return Expanded(child: AlarmInsights());
            }

            if (!insightsPermission && consolePermission) {
              return Expanded(
                child: AlarmsConsole(
                  pagingController: pagingController,
                ),
              );
            }

            return Expanded(
              child: ValueListenableBuilder(
                valueListenable: valueNotifier,
                builder: (context, value, _) {
                  if (value == AlarmScreenType.console) {
                    return AlarmsConsole(
                      pagingController: pagingController,
                    );
                  }

                  return AlarmInsights();
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  // // ===================================================================================
  AppBar buildAppBar(BuildContext context, List<Map> initialValues) {
    return AppBar(
        title: const Text("Alarms"),
        actions: consolePermission
            ? [
                ValueListenableBuilder(
                  valueListenable: searchValueNotifier,
                  builder: (context, value, child) {
                    if (value.isEmpty) {
                      return buildSearchIconButton(
                        context: context,
                        showCloseIcon: false,
                      );
                    }

                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showSearch<String?>(
                              context: context,
                              delegate: AlarmsSearchDelegate(),
                              query: value,
                            );
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
                  },
                ),
                FilterButtonWidget(
                  onPressed: () async {
                    var statusMap = {
                      "key": "status",
                      "identifier": ["active"],
                      "values": [
                        {
                          "name": "Active",
                          "aliasName": "active_resolved",
                          "data": "active",
                        },
                      ],
                    };

                    var workOrderMap = {
                      "key": "workOrders",
                      "identifier": "ALL",
                      "values": [
                        {
                          "name": "All Alarms",
                          "data": "ALL",
                        },
                      ],
                    };

                    if (!initialValues
                        .any((element) => element['key'] == "workOrders")) {
                      initialValues.add(workOrderMap);
                    }

                    if (!initialValues
                        .any((element) => element['key'] == "status")) {
                      initialValues.add(
                        statusMap,
                      );
                    }

                    await FilterWidgetHelpers().filterBottomSheet(
                      isMobile: true,
                      context: context,
                      filterType: FilterType.alarmConsole,
                      // useInitailValueRepeatly: true,
                      initialValues: initialValues,
                      resetNotApplyingKeys: ["status", "workOrders"],
                      saveButtonTap: (data) {
                        pagingController.refresh();
                      },
                    );
                  },
                  // icon: const Icon(Icons.filter_alt),
                ),
              ]
            : []);
  }

  IconButton buildSearchIconButton({
    required BuildContext context,
    required bool showCloseIcon,
  }) {
    return IconButton(
      onPressed: () async {
        if (showCloseIcon) {
          payloadManagementBloc.state.payload['names'] = [];
          pagingController.refresh();

          searchValueNotifier.value = '';

          return;
        }

        List searchedNames = payloadManagementBloc.state.payload['names'] ?? [];

        String? alarmName = await showSearch<String?>(
          context: context,
          delegate: AlarmsSearchDelegate(),
          query: searchedNames.isEmpty ? "" : searchedNames.first,
        );

        if (alarmName != null) {
          searchValueNotifier.value = alarmName;
          payloadManagementBloc.state.payload['names'] = [alarmName];
          pagingController.refresh();
        }
      },
      icon: Icon(showCloseIcon ? Icons.close : Icons.search),
    );
  }
}
