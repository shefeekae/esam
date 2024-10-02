import 'package:flutter/material.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/models/insights/insights_dropdown_model.dart';
import 'package:nectar_assets/core/services/dashboards/dropdown_hierarchy_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';

class LevelDropdownWidget extends StatelessWidget {
  const LevelDropdownWidget({
    super.key,
    required this.dropDownValueNotifier,
    required this.level,
    this.communityDomain,
    this.parentEntity,
    required this.title,
    this.currentYear,
    this.previousYear,
  });
  final String? currentYear;
  final String? previousYear;
  final String title;
  final Level level;
  final String? communityDomain;
  final Map<String, dynamic>? parentEntity;
  final ValueNotifier<CommunityHierarchyDropdownData?> dropDownValueNotifier;

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
          query: DropdownHierarchyServices().getDropdownQueryMethod(level),
          variables: DropdownHierarchyServices().getDropdownQueryPayload(
            level,
            communityDomain: communityDomain,
            parentEntity: parentEntity,
            currentYear: currentYear,
            previousYear: previousYear,
          ),
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Text(title);
          }

          if (result.hasException) {
            return GraphqlServices().handlingGraphqlExceptions(
              result: result,
              context: context,
              refetch: refetch,
            );
          }

          List<CommunityHierarchyDropdownData> dropdownValues =
              DropdownHierarchyServices().getDrodpdownValues(
            resultData: result.data ?? {},
            dropdownType: level,
          );

          // var communities = ListAllCommunitiesModel.fromJson(data ?? {});

          // List<Community> list = communities.listAllCommunities ?? [];

          List<DropdownMenuItem<String>> dropdownItem = dropdownValues.map(
            (e) {
              String label = e.displayName;

              return DropdownMenuItem(
                onTap: () {
                  dropDownValueNotifier.value = e;
                },
                value: e.identifier,
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,

                  // maxLines: 2,
                ),
              );
            },
          ).toList();

          return ValueListenableBuilder(
              valueListenable: dropDownValueNotifier,
              builder: (context, dropDownvalue, child) {
                return DropdownButton<String>(
                  hint: const Text("Select Community"),
                  // style: TextStyle(fontSize: 8.sp),
                  isExpanded: true,
                  elevation: 0,
                  underline: const SizedBox(),
                  items: dropdownItem,

                  onChanged: (value) {},

                  value: dropDownvalue?.identifier,
                );
              });
        });
  }
}
