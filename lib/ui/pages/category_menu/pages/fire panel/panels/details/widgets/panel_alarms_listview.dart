import 'package:app_filter_form/core/blocs/filter/payload/payload_management_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/core/services/alarms/alarms_pagination_services.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/widgets/alarm_card.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';

class PanelAlarmsListView extends StatefulWidget {
  const PanelAlarmsListView({
    super.key,
    required this.alarmPagingController,
    required this.domain,
    required this.identifier,
  });

  final PagingController<int, EventLogs> alarmPagingController;
  final String domain;
  final String identifier;

  @override
  State<PanelAlarmsListView> createState() => _PanelAlarmsListViewState();
}

class _PanelAlarmsListViewState extends State<PanelAlarmsListView> {
  final UserDataSingleton userData = UserDataSingleton();

  final AlarmsPaginationServices alarmsPaginationServices =
      AlarmsPaginationServices();

  @override
  void initState() {
    Map<String, dynamic> initialPayload = {
      "status": ["active"],
      "domain": userData.domain,
      "entities": [
        {
          "type": "FACP",
          "data": {
            "identifier": widget.identifier,
            "domain": widget.domain,
          }
        }
      ]
    };

    PayloadManagementBloc payloadManagementBloc =
        BlocProvider.of<PayloadManagementBloc>(context);

    payloadManagementBloc.state.payload.remove("order");
    payloadManagementBloc.state.payload.remove("sortField");


    widget.alarmPagingController.addPageRequestListener(
      (pageKey) {
        alarmsPaginationServices.getAlarmsList(
          pagingController: widget.alarmPagingController,
          pageKey: pageKey,
          payloadManagementBloc: payloadManagementBloc,
          additionalPayload: initialPayload,
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        widget.alarmPagingController.refresh();
      },
      child: PagedListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        shrinkWrap: true,
        pagingController: widget.alarmPagingController,
        builderDelegate: PagedChildBuilderDelegate<EventLogs>(
          itemBuilder: (context, item, index) {
            return PanelAlarmCard(
              eventLog: item,
            );
          },
          newPageErrorIndicatorBuilder: (context) {
            return TextButton.icon(
              onPressed: () {
                widget.alarmPagingController.retryLastFailedRequest();
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Retry"),
            );
          },
          firstPageProgressIndicatorBuilder: (context) {
            return BuildShimmerLoadingWidget(
              itemCount: 10,
              height: 100.sp,
              shrinkWrap: true,
              padding: 0,
              borderRadius: 0,
            );
          },
          newPageProgressIndicatorBuilder: (context) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
          noItemsFoundIndicatorBuilder: (context) {
            return Padding(
              padding: EdgeInsets.only(top: 15.sp),
              child: Center(
                child: Text(
                  "No items found",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
          noMoreItemsIndicatorBuilder: (context) {
            var itemsCount = widget.alarmPagingController.itemList?.length ?? 0;

            if (itemsCount < 3) {
              return const SizedBox();
            }

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: const Center(
                child: Text("No data to show"),
              ),
            );
          },
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 10.sp,
        ),
      ),
    );
  }
}
