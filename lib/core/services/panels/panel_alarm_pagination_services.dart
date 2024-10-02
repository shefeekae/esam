import 'package:app_filter_form/app_filter_form.dart';
import 'package:flutter/foundation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:secure_storage/secure_storage.dart';

class PanelAlarmsPaginationServices {
  // static  final PagingController<int, EventLogs> pagingController =
  //     PagingController(firstPageKey: 1);

  // PagingController<int, EventLogs> get pagingController => pagingController;

  UserDataSingleton userData = UserDataSingleton();

  // ================================================================================

  Future<void> getAlarmsList({
    required PagingController pagingController,
    required int pageKey,
    required PayloadManagementBloc payloadManagementBloc,
  }) async {
    // UserDataSingleton userData = UserDataSingleton();

    Map<String, dynamic> filter = {
      "domain": userData.domain,
      "offset": pageKey,
      "pageSize": 10,
    };

    var filterAppliedData = payloadManagementBloc.state.payload;

    filter.addAll(filterAppliedData);

    var result = await GraphqlServices().performQuery(
      query: AlarmsSchema.listAlarmsQuery,
      variables: {
        "filter": filter,
      },
    );

    if (result.hasException) {
      pagingController.error = result.exception;
      if (kDebugMode) {
        print("exception: ${result.exception}");
      }
      return;
    }

    var listAlarms = ListAlarmsModel.fromJson(result.data ?? {});

    int? totalCount = listAlarms.listAlarms?.count;

    var alarmsList = listAlarms.listAlarms?.eventLogs ?? [];

    if (totalCount == null) {
      pagingController.appendLastPage(alarmsList);

      return;
    }

    var totalItems = pagingController.itemList ?? [];

    int totalValuesCount = totalItems.length + alarmsList.length;

    if (totalValuesCount == totalCount) {
      pagingController.appendLastPage(alarmsList);
    } else if (alarmsList.isEmpty) {
      pagingController.appendLastPage([]);
    } else {
      pagingController.appendPage(
        alarmsList,
        pageKey + 1,
      );
    }
  }

//  ==============================================================================

  getPayload() {}
}
