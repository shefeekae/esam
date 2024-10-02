import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/core/schemas/scheduler_shemas.dart';
import 'package:secure_storage/secure_storage.dart';
import '../../models/scheduler/scheduler_list_model.dart';
import '../graphql_services.dart';

class SchedulerPaginationServices {
// ====================================================

  Future<void> getPagintedSchedulesList({
    required PagingController<int, Items> pagingController,
    required int pageKey,
    bool dateRangeCalled = false,
    int? startDate,
    int? endDate,
  }) async {
    UserDataSingleton userData = UserDataSingleton();

    Map<String, dynamic> data = {
      "clientId": [
        userData.domain,
      ],
      "includeStatus": ["ACTIVE", "INACTIVE"]
    };

    if (startDate != null && endDate != null) {
      data['startDate'] = startDate;
      data['endDate'] = endDate;
    }

    Map<String, dynamic> variables = {
      "pageObj": {
        "page": pageKey,
        "size": 20,
        "sort": "name,asc",
      },
      "data": data,
    };

    var result = await GraphqlServices().performQuery(
      query: SchedulerSchema.getSchedulerListPaged,
      variables: variables,
    );

    // print(result.data);

    if (result.hasException) {
      pagingController.error = result.exception;
      return;
    }

    var model = SchedulerListModel.fromJson(result.data ?? {});

    int? totalCount = model.getSchedulerListPaged?.totalItems;

    var schedulesList = model.getSchedulerListPaged?.items ?? [];


    if (dateRangeCalled) {
      pagingController.itemList = [];
      pagingController.appendPage(schedulesList, pageKey + 1);
      return;
    }

    if (totalCount == null) {
      pagingController.appendLastPage(schedulesList);
      return;
    }

    var totalItems = pagingController.itemList ?? [];

    int totalValuesCount = totalItems.length + schedulesList.length;

    if (totalValuesCount == totalCount) {
      pagingController.appendLastPage(schedulesList);
    } else if (schedulesList.isEmpty) {
      pagingController.appendLastPage([]);
    } else {
      pagingController.appendPage(
        schedulesList,
        pageKey + 1,
      );
    }
  }
}
