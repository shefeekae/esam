import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/models/documents/document_list_model.dart';
import 'package:nectar_assets/core/schemas/documents_schemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/documents/list/widgets/document_list_tile.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';

class DocumentSearchDelegate extends SearchDelegate {
  final UserDataSingleton userData = UserDataSingleton();

  @override
  ThemeData appBarTheme(BuildContext context) =>
      ThemeServices().getSearchThemeData(context);

  @override
  String? get searchFieldLabel => "Search Documents";

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
        query: DocumentSchema.getDocumentListQuery,
        variables: {
          "data": {
            "domain": userData.domain,
            "pageSize": 15,
            "offset": 1,
            "name": query
          }
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

        var documentData = DocumentListModel.fromJson(result.data ?? {});

        List<Result> documentResult =
            documentData.getDocumentsList?.result ?? [];

        // int? totalCount = model.getSchedulerListPaged?.totalItems;

        return ListView.separated(
          itemCount: documentResult.length,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 7.sp,
            );
          },
          itemBuilder: (context, index) {
            return DocumentListTiile(documentResult: documentResult[index]);
          },
        );
      },
    );
  }
}
