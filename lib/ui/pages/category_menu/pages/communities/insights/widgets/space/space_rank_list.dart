import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/equipment_details.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../../core/models/space/get_space_insight_visulaization.dart';
import '../../../../../../../../core/schemas/common_schemas.dart';
import '../../../../../../../../core/services/graphql_services.dart';
import '../../../../../../../shared/widgets/container/background_container.dart';
import '../../../../../../../shared/widgets/container_with_text.dart';

class SpaceRankingList extends StatelessWidget {
  SpaceRankingList({
    super.key,
    required this.title,
    required this.unit,
    required this.maintenanceRank,
  });

  final String title;
  final List<Rank> maintenanceRank;
  final String unit;
  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    List<Rank> list = maintenanceRank.length > 5
        ? maintenanceRank.take(5).toList()
        : maintenanceRank;

    if (list.isEmpty) {
      return const SizedBox();
    }

    return BgContainer(
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      title: title,
      child: Column(
        children: List.generate(list.length, (index) {
          Rank rank = list[index];

          return QueryWidget(
              options: GraphqlServices().getQueryOptions(
                  rereadPolicy: true,
                  query: CommonSchema.getSearchData,
                  variables: {
                    "data": {
                      "type": "Equipment",
                      "keys": ["identifier"],
                      "limit": 1,
                      "page": 1,
                      "value": rank.id,
                      "domain": userData.domain
                    }
                  }),
              builder: (result, {fetchMore, refetch}) {
                return ListTile(
                  onTap: () {
                    if (result.isNotLoading) {
                      Map<String, dynamic>? equipment =
                          result.data?['getSearchData']?[0]?['equipment'];

                      if (equipment == null) {
                        return;
                      }

                      String identifier =
                          equipment['data']?["identifier"] ?? "";

                      String type = equipment["type"] ?? "";
                      String displayName =
                          equipment["data"]?['displayName'] ?? "";
                      String domain = equipment["data"]?['domain'] ?? "";

                      Navigator.of(context)
                          .pushNamed(EquipmentDetailsScreen.id, arguments: {
                        "type": type,
                        "displayName": displayName,
                        "domain": domain,
                        "identifier": identifier,
                      });
                    }
                  },
                  minLeadingWidth: 10,
                  leading: ContainerWithTextWidget(
                    value: "${index + 1}",
                    fontSize: 8.sp,
                  ),
                  title: Builder(builder: (context) {
                    if (result.isLoading) {
                      return const Skeletonizer(
                        enabled: true,
                        child: Text("Loading......."),
                      );
                    }

                    return Text(rank.name ?? "");
                  }),
                  subtitle: Builder(builder: (context) {
                    if (result.isLoading) {
                      return const Skeletonizer(
                        enabled: true,
                        child: Text("Loading......."),
                      );
                    }

                    String sourceTagPath = result.data?['getSearchData']?[0]
                            ?['equipment']?['data']?['sourceTagPath'] ??
                        "";

                    String decodedString = sourceTagPath.isEmpty
                        ? ""
                        : Uri.decodeComponent(sourceTagPath);

                    List path = jsonDecode(
                        decodedString.isEmpty ? "[]" : decodedString);

                    return Text(
                      path
                          .map((e) {
                            if (e['parentType'] == "Equipment") {
                              return "";
                            }
                            return e['name'] ?? "";
                          })
                          .toList()
                          .join(" - "),
                      style: TextStyle(
                        fontSize: 7.sp,
                      ),
                    );
                  }),
                  trailing: ContainerWithTextWidget(
                    value:
                        "$unit  ${rank.value == 0 ? 0 : rank.value?.toStringAsFixed(2) ?? 0}",
                    fontSize: 10.sp,
                  ),
                );
              });
        }),
      ),
    );
  }
}
