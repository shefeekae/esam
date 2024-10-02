import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/models/communities/community_heirarchy_map_model.dart';
import 'package:nectar_assets/core/services/communities/communites_map_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/insights/community_hirearchy_insights_services.dart';
import 'package:nectar_assets/ui/shared/widgets/map/google_map_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/map/loading_google_map.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../core/models/communities/community_hierarchy_args_model.dart';
import '../../../../../../core/models/insights/insights_dropdown_model.dart';
import '../../../../../../core/models/sub_community/list_all_site_groups_has_alarm_model.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen(
      {required this.communityHierarchyDropdownData,
      required this.insights,
      super.key});

  final CommunityHierarchyDropdownData communityHierarchyDropdownData;
  final Insights insights;

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  final UserDataSingleton userData = UserDataSingleton();

  late final ValueNotifier<CommunityHierarchyDropdownData>
      dropdownValueNotifier;

  final CommunityHirearchyMapServices communityHirearchyMapServices =
      CommunityHirearchyMapServices();

  final CommunityHierarchyServices communityHierarchyServices =
      CommunityHierarchyServices();

  @override
  void initState() {
    dropdownValueNotifier = ValueNotifier<CommunityHierarchyDropdownData>(
        widget.communityHierarchyDropdownData);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: ValueListenableBuilder(
          valueListenable: dropdownValueNotifier,
          builder: (context, dropdownData, _) {
            return QueryWidget(
                options: GraphqlServices().getQueryOptions(
                  query: communityHirearchyMapServices
                      .getQueryMehod(widget.insights),
                  variables: communityHirearchyMapServices.getVariables(
                    widget.insights,
                    entity: dropdownData.entity,
                  ),
                ),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return const GoogleMapLoadingWidget();
                  }

                  if (result.hasException) {
                    return GraphqlServices().handlingGraphqlExceptions(
                      result: result,
                      context: context,
                      refetch: refetch,
                    );
                  }

                  List<CommunityHeirarchyMapDataModel> list =
                      communityHirearchyMapServices.getMapData(
                    widget.insights,
                    resultData: result.data ?? {},
                    entity: dropdownData.entity,
                  );

                  var markers =
                      CommunityHirearchyMapServices().convertToMarkerData(
                    context: context,
                    list: list,
                    communityIdentifier: dropdownData.identifier,
                  );

                  return GoogleMapWidget(
                    markers: markers,
                    zoom: 10,
                  );
                });
          }),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      title: QueryWidget(
          options: GraphqlServices().getQueryOptions(
            query: communityHierarchyServices
                .getDropdownQueryMethod(widget.insights),
            variables: communityHierarchyServices.getDropdownQueryPayload(
              widget.insights,
              communityDomain: widget
                  .communityHierarchyDropdownData.entity['data']?['domain'],
            ),
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              String title = "";

              if (widget.insights == Insights.community) {
                title =
                    "${widget.communityHierarchyDropdownData.displayName} - Sub Communities";
              } else if (widget.insights == Insights.subCommunity) {
                title =
                    "${widget.communityHierarchyDropdownData.displayName} - Sites";
              }

              return Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              );
            }

            if (result.hasException) {
              return GraphqlServices().handlingGraphqlExceptions(
                result: result,
                context: context,
                refetch: refetch,
              );
            }

            List<CommunityHierarchyDropdownData> dropdownValues =
                communityHierarchyServices.getDrodpdownValues(
                  entity: widget.communityHierarchyDropdownData.parentEntity ?? {},
              resultData: result.data ?? {},
              insights: widget.insights,
            );

          

            return ValueListenableBuilder<CommunityHierarchyDropdownData>(
                valueListenable: dropdownValueNotifier,
                builder: (context, value, child) {
                  String identifier = value.identifier;
                  return DropdownButton(
                    isExpanded: true,
                    underline: const SizedBox(),
                    value: identifier,
                    items: List.generate(
                      dropdownValues.length,
                      (index) => DropdownMenuItem(
                        onTap: () {
                          dropdownValueNotifier.value = dropdownValues[index];
                        },
                        value: dropdownValues[index].identifier,
                        child: Text(
                          dropdownValues[index].displayName,
                        ),
                      ),
                    ),
                    onChanged: (value) {},
                  );
                });
          }),
    );
  }
}
