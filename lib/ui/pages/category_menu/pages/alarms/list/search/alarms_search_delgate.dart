import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';

class AlarmsSearchDelegate extends SearchDelegate<String?> {
  UserDataSingleton userData = UserDataSingleton();

  @override
  ThemeData appBarTheme(BuildContext context) =>  ThemeServices().getSearchThemeData(context);

  @override
  String? get searchFieldLabel => "Search Alarms";

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
  Widget buildResults(BuildContext context) {
    return buildSearchQueryWidget();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchQueryWidget();
  }

  Widget buildSearchQueryWidget() {
    if (query.isEmpty) {
      return const SizedBox();
    }

    return Builder(builder: (context) {
      return QueryWidget(
        options: GraphqlServices().getQueryOptions(
          query: AlarmsSchema.searchEvent,
          variables: {
            "data": {
              "domain": userData.domain,
              "searchValue": query,
              "limit": 10,
              "page": 1,
              "searchKey": "name"
            },
          },
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return BuildShimmerLoadingWidget(
              height: 30.sp,
            );
          }

          if (result.hasException) {
            return GraphqlServices().handlingGraphqlExceptions(
              result: result,
              context: context,
              refetch: refetch,
            );
          }

          List list = result.data?['searchEvent'] ?? [];

          bool searchedValueContains = list.any((element) =>
              element['name'].toString().toLowerCase() == query.toLowerCase());

          if (!searchedValueContains) {
            list = [
              {"name": query},
              ...list
            ];
          }

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              var map = list[index];

              String name = map['name'] ?? '';

              return buildListTile(name);
            },
          );
        },
      );
    });
  }

  Widget buildListTile(String name) {
    return Builder(builder: (context) {
      return ListTile(
        onTap: () {
          Navigator.of(context).pop(name);
        },
        leading: const Icon(Icons.search),
        title: Text(name),
      );
    });
  }
}
