import 'package:app_filter_form/app_filter_form.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/core/models/documents/document_list_model.dart';
import 'package:nectar_assets/core/schemas/documents_schemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:secure_storage/secure_storage.dart';

class DocumentPaginationServices {
  UserDataSingleton userData = UserDataSingleton();

  getDocumentList({
    required PagingController pagingController,
    required int pageKey,
    required PayloadManagementBloc payloadManagementBloc,
  }) async {
    Map<String, dynamic> data = {
      "domain": userData.domain,
      "pageSize": 10,
      "offset": pageKey,
      "name": ""
    };

    data.addAll(payloadManagementBloc.state.payload);

    var result = await GraphqlServices()
        .performQuery(query: DocumentSchema.getDocumentListQuery, variables: {
      "data": data,
    });

    if (result.hasException) {
      print("document list exception: ${result.exception}");
      pagingController.error = result.exception;
      return;
    }

    var getDocumentListModel = DocumentListModel.fromJson(result.data ?? {});

    int? totalCount = getDocumentListModel.getDocumentsList?.totalDocumentCount;

    var documentList = getDocumentListModel.getDocumentsList?.result ?? [];

    print("Document list length : ${documentList.length}");

    if (totalCount == null) {
      pagingController.appendLastPage(documentList);

      return;
    }

    var totalItems = pagingController.itemList ?? [];

    int totalValuesCount = totalItems.length + documentList.length;

    if (totalValuesCount == totalCount) {
      pagingController.appendLastPage(documentList);
    } else if (documentList.isEmpty) {
      pagingController.appendLastPage([]);
    } else {
      pagingController.appendPage(
        documentList,
        pageKey + 1,
      );
    }
  }
}
