import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/models/scheduler/scheduler_list_model.dart';
import 'package:nectar_assets/core/schemas/scheduler_shemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/scheduler/widgets/scheduler_card.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';

class SchedulesSearchDelegate extends SearchDelegate {
  final UserDataSingleton userData = UserDataSingleton();

  @override
  ThemeData appBarTheme(BuildContext context) =>
      ThemeServices().getSearchThemeData(context);

  @override
  String? get searchFieldLabel => "Search Scheduler";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Visibility(
        visible: query.isNotEmpty,
        child: IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear),
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) => buildQueryWidget(context);

  @override
  Widget buildSuggestions(BuildContext context) => buildQueryWidget(context);

  Widget buildQueryWidget(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
        query: SchedulerSchema.getSchedulerListPaged,
        variables: {
          "pageObj": {
            // "page": 0,
            // "size": 10,
            "sort": "name,asc",
          },
          "data": {
            "clientId": [
              userData.domain,
            ],
            "name": query,
            "includeStatus": ["ACTIVE", "INACTIVE"]
          },
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return BuildShimmerLoadingWidget(
            height: 80.sp,
            padding: 0,
          );
        }

        if (result.hasException) {
          return GraphqlServices().handlingGraphqlExceptions(
            result: result,
            context: context,
            refetch: refetch,
          );
        }

        var model = SchedulerListModel.fromJson(result.data ?? {});

        // int? totalCount = model.getSchedulerListPaged?.totalItems;

        var schedulesList = model.getSchedulerListPaged?.items ?? [];

        return ListView.separated(
          itemCount: schedulesList.length,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 7.sp,
            );
          },
          itemBuilder: (context, index) {
            return SchedulerCard(
              item: schedulesList[index],
            );
          },
        );
      },
    );
  }
}
