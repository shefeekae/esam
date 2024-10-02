import 'package:app_filter_form/app_filter_form.dart';
import 'package:app_filter_form/widgets/buttons/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/custom_row_button_model.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/widgets/alarms_console.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_row_buttons.dart';
// ignore: depend_on_referenced_packages
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

enum AlarmsTypes { active, resolved }

class ConslodationAlarmsListScreen extends StatefulWidget {
  const ConslodationAlarmsListScreen({super.key});

  static const String id = "equipment/consoldation/alarms/list";

  @override
  State<ConslodationAlarmsListScreen> createState() =>
      _ConslodationAlarmsListScreenState();
}

class _ConslodationAlarmsListScreenState
    extends State<ConslodationAlarmsListScreen> {
  final ValueNotifier<AlarmsTypes> valueNotifier =
      ValueNotifier<AlarmsTypes>(AlarmsTypes.active);

  final PagingController<int, EventLogs> pagingController =
      PagingController(firstPageKey: 1);

  late PayloadManagementBloc payloadManagementBloc;
  late FilterAppliedBloc filterAppliedBloc;
  late FilterSelectionBloc filterSelectionBloc;

  List<Map> filterValues = [];
  Map<String, dynamic> payload = {};

  @override
  void initState() {
    payloadManagementBloc = BlocProvider.of<PayloadManagementBloc>(context);
    payloadManagementBloc.state.payload = {};
    filterAppliedBloc = BlocProvider.of<FilterAppliedBloc>(context);
    filterSelectionBloc = BlocProvider.of<FilterSelectionBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    filterSelectionBloc
        .state.filterLabelsMap[FilterType.equipmentConsolidationAlarms] = [];
    // payloadManagementBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    AlarmsTypes alarmsType = args?['alarmType'] ?? AlarmsTypes.active;

    payloadManagementBloc.state.payload['status'] = [
      alarmsType == AlarmsTypes.active ? "active" : "resolved"
    ];

    valueNotifier.value = alarmsType;

    if (args?['filterValues'] != null) {
      filterValues = args?['filterValues'];

      for (var element in filterValues) {
        if (element['key'] == "dateRange") {
          payload.addAll(element['identifier']);
          continue;
        }

        if (element['filterKey'] == "searchTagIds") {
          if (element['key'] != "community") {
            dynamic entity = element['identifier'];

            if (entity.runtimeType != List) {
              payload[element['filterKey']] = [entity['data']?['identifier']];
              element['identifier'] = [entity];
            }
          }
          continue;
        }

        payload[element['filterKey']] = element['identifier'];
      }

      payloadManagementBloc.state.payload.addAll(payload);

      filterAppliedBloc.state.filterAppliedCount = filterValues.length;
    }

    return Scaffold(
      appBar: buildAppbar(context),
      body: Column(
        children: [
          Center(
            child: CustomRowButtons(
              valueListenable: valueNotifier,
              onChanged: (itemKey) {
                valueNotifier.value = itemKey as AlarmsTypes;

                payloadManagementBloc.state.payload['status'] = [
                  valueNotifier.value == AlarmsTypes.active
                      ? "active"
                      : "resolved"
                ];
                pagingController.refresh();
              },
              items: [
                CustomButtonModel(
                  title: "Active",
                  itemKey: AlarmsTypes.active,
                ),
                CustomButtonModel(
                  title: "Resolved",
                  itemKey: AlarmsTypes.resolved,
                ),
              ],
            ),
          ),
          buildAlarmsList()
        ],
      ),
    );
  }

  // =====================================================
  Expanded buildAlarmsList() {
    return Expanded(
      child: ValueListenableBuilder(
          valueListenable: valueNotifier,
          builder: (context, value, _) {
            return AlarmsConsole(
              pagingController: pagingController,
              showComments: false,
              showChart: false,
            );
          }),
    );
  }

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text("Alarms List"),
      actions: [
        FilterButtonWidget(
          onPressed: () {
            FilterWidgetHelpers().filterBottomSheet(
              context: context,
              filterType: FilterType.equipmentConsolidationAlarms,
              isMobile: true,
              excludeFieldsKeys: [
                "status",
                "workOrders",
                "annotations",
                "location"
              ],
              initialValues: filterValues,
              saveButtonTap: (value) {
                pagingController.refresh();
              },
            );
          },
        )
      ],
    );
  }
}
