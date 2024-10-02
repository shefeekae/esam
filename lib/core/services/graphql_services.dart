import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlServices {
  // ================================================================================
  // This method is used to return the query options.
  // Its easy to reuse the commonn properties.

  QueryOptions getQueryOptions({
    required String query,
    bool rereadPolicy = false,
    Map<String, dynamic> variables = const {},
  }) {

    return GrapghQlClientServices().getQueryOptions(
      document: query,
      variables: variables,
      rereadPolicy: rereadPolicy,
    );
  }

  // ===============================================================================
  // This method is used to call the graphql query call.

  Future<QueryResult> performQuery({
    required String query,
    Map<String, dynamic> variables = const {},
  }) async {
    QueryResult result = await GrapghQlClientServices()
        .performQuery(query: query, variables: variables);

    return result;
  }

  // ==============================================================================
  //

  Future<QueryResult> performMutation({
    required BuildContext context,
    required String query,
    Map<String, dynamic> variables = const {},
    bool refreshTokenCalled = false,
  }) async {
    QueryResult result = await GrapghQlClientServices()
        .performMutation(context: context, mutation: query, variables: variables);

    return result;
  }

  // ==================================================================================
  // Handling graphql expception.

  Widget handlingGraphqlExceptions({
    required QueryResult result,
    required BuildContext context,
    Future<QueryResult<Object?>?> Function()? refetch,
    Function(void Function())? setState,
  }) {
    return GrapghQlClientServices().handlingGraphqlExceptions(
      result: result,
      context: context,
      refetch: refetch,
      setState: setState,
    );
  }
}
