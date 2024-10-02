import 'package:flutter/material.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:nectar_assets/core/schemas/common_schemas.dart';
import 'package:nectar_assets/core/services/communities/community_insights_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/sub_community/sub_community_heirarchy_prediction_list_services.dart';
import 'package:nectar_assets/ui/shared/functions/converters.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../../core/enums/insights_enum.dart';
import '../../../../../../../core/models/communities/community_hierarchy_args_model.dart';
import '../../../../../../../core/models/insights/insights_dropdown_model.dart';
import '../../../../../../shared/widgets/container/background_container.dart';
import '../../../../../../shared/widgets/container_with_text.dart';
import '../communites_insights_screen.dart';

class Top5SubCommunitiesHeirarchyPredictionList extends StatelessWidget {
  Top5SubCommunitiesHeirarchyPredictionList({
    required this.startDate,
    required this.identifier,
    required this.insights,
    required this.endDate,
    required this.entity,
    super.key,
  });

  final UserDataSingleton userData = UserDataSingleton();
  final int startDate;
  final int endDate;
  final String? identifier;
  final Insights insights;
  final Map<String, dynamic> entity;

  final SubCommunityHeirarchyPerdictionListServices
      subCommunityHeirarchyPerdictionListServices =
      SubCommunityHeirarchyPerdictionListServices();

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
        query: subCommunityHeirarchyPerdictionListServices
            .getQueryMethod(insights),
        variables: {
          "startDate": startDate,
          "endDate": 0,
          "id": identifier,
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return GraphqlServices().handlingGraphqlExceptions(
            result: result,
            context: context,
            refetch: refetch,
          );
        }

        String key = insights == Insights.community
            ? "getCommunityForecast"
            : "getSubCommunityForecast";

        List list = result.data?[key]?['consumptionRank'] ?? [];
        // dummyData['getCommunityForecast']?['consumptionRank'] ?? [];

        list = list.length > 5 ? list.take(5).toList() : list;

        if (!result.isLoading && list.isEmpty) {
          return const SizedBox();
        }

        return Skeletonizer(
          enabled: result.isLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.sp),
            child: BgContainer(
              title:
                  "Top 5 ${subCommunityHeirarchyPerdictionListServices.getTitle(insights)} Ranking by Prediction",
              child: Column(
                children: List.generate(
                  list.length,
                  (index) {
                    Map<String, dynamic> map = list[index] ?? {};

                    num value = map['value'] ?? 0;

                    String formatedNumber = Converter().formatNumber(
                      value.toDouble(),
                    );

                    String id = map['id'] ?? "";

                    return ListTile(
                      onTap: () {},
                      minLeadingWidth: 10,
                      leading: ContainerWithTextWidget(
                        value: "${index + 1}",
                        fontSize: 8.sp,
                      ),
                      title: buildTitleQueryWidget(
                        context,
                        identifier: id,
                        communityId: identifier,
                      ),
                      trailing: ContainerWithTextWidget(
                        value: "$formatedNumber kwh",
                        fontSize: 10.sp,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // Callling the SubCommunity details api for getting the sub community name

  QueryWidget buildTitleQueryWidget(
    BuildContext context, {
    required String identifier,
    required String? communityId,
  }) {
    return QueryWidget(
      options: GraphqlServices()
          .getQueryOptions(query: CommonSchema.getSearchData, variables: {
        "data": {
          "type": subCommunityHeirarchyPerdictionListServices
              .getSearchDataPayloadType(insights),
          "keys": ["identifier"],
          "limit": 1,
          "page": 1,
          "value": identifier,
          "domain": userData.domain,
        }
      }),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return const Skeletonizer(
            enabled: true,
            child: Text("Loading...."),
          );
        }

        String title;

        try {
          if (insights == Insights.community) {
            String displayName = result.data?['getSearchData']?[0]?['data']
                    ?['displayName'] ??
                "";
            String name =
                result.data?['getSearchData']?[0]?['data']?['name'] ?? "";
            title = displayName.isEmpty ? name : displayName;
          } else {
            String displayName = result.data?['getSearchData']?[0]?['site']
                    ?['data']?['displayName'] ??
                "";
            String name = result.data?['getSearchData']?[0]?['site']?['data']
                    ?['name'] ??
                "";
            title = displayName.isEmpty ? name : displayName;
          }
        } catch (e) {
          title = "N/A";
        }

        return GestureDetector(
            onTap: () {
              try {
                Map<String, dynamic> getSearchDataMap =
                    insights == Insights.community
                        ? result.data?['getSearchData']?[0] ?? {}
                        : result.data?['getSearchData']?[0]?['site'] ?? {};

                // if (Insights.community == insights) {
                // Map<String, dynamic> getSearchDataMap =
                //     result.data?['getSearchData']?[0];

                String? type = getSearchDataMap['type'];
                String displayName =
                    getSearchDataMap['data']?['displayName'] ?? "";

                String name = getSearchDataMap['data']?['name'] ?? "";

                String id = getSearchDataMap['data']?['identifier'] ?? "";
                String locationName =
                    getSearchDataMap['data']?['locationName'] ?? "";
                String? typeName = getSearchDataMap['data']?['typeName'];
                String? domain = getSearchDataMap['data']?['domain'];

                Navigator.of(context).pushNamed(
                  CommunityHierarchyScreen.id,
                  arguments: CommunityHierarchyArgs(
                    insights:
                        CommunityInsightsServices().getNextInsights(insights),
                    communityIdentifier: communityId,
                    initialDateTimeRange: DateTimeRange(
                        start: DateTime.fromMillisecondsSinceEpoch(startDate),
                        end: DateTime.fromMillisecondsSinceEpoch(endDate)),
                    dropdownData: CommunityHierarchyDropdownData(
                      parentEntity: entity,
                      identifier: id,
                      displayName: displayName.isEmpty ? name : displayName,
                      locationName: locationName,
                      typeName: typeName,
                      entity: {
                        "type": type,
                        "data": {
                          "domain": domain,
                          "identifier": identifier,
                          "name": displayName.isEmpty ? name : displayName,
                        }
                      },
                    ),
                  ),
                );
                // }
              } catch (_) {}
            },
            child: Text(title));
      },
    );
  }
}
