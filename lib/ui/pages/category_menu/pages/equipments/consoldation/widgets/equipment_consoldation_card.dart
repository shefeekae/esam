import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/consoldation/consoldation_alarms_list_screen.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../core/services/assets/assets_services.dart';
import '../../../../../../../core/services/theme/theme_services.dart';
import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../shared/widgets/container_with_text.dart';

// ignore: must_be_immutable
class EquipmentConsoldationCard extends StatelessWidget {
  EquipmentConsoldationCard({
    super.key,
    required this.activeCount,
    required this.resolvedCount,
    required this.name,
    required this.pecentage,
    required this.filterValues,
  });

  final String name;
  final int activeCount;
  final int resolvedCount;
  final double pecentage;
  final List<Map> filterValues;
  final UserDataSingleton userData = UserDataSingleton();

  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7.sp),
      decoration: BoxDecoration(
        color: ThemeServices().getBgColor(context),
        borderRadius: BorderRadius.circular(7),
      ),
      child: QueryWidget(
        options: GraphqlServices().getQueryOptions(
          query: AssetSchema.getAssetDetailsFromName,
          variables: {
            "assetName": name,
            "domain": userData.domain,
          },
          rereadPolicy: true,
        ),
        builder: (result, {fetchMore, refetch}) {
          bool isLoading = result.isLoading;

          Map<String, dynamic>? data = result.data?['getAssetDetailsFromName'];

          String typeName = data?['equipment']?['data']?['typeName'] ?? "";

          List sourceTagPath = jsonDecode(
              result.data?['getAssetDetailsFromName']?['sourceTagPath'] ??
                  "[]");

          // Map<String, dynamic>? equipment = data?['equipment'];

          // Map<String, dynamic>? assetEntity = equipment == null
          //     ? null
          //     : {
          //         "type": equipment["type"],
          //         "data": {
          //           "domain": equipment['data']?['domain'],
          //           "identifier": equipment['data']?['identifier'],
          //           "name": equipment['data']?['displayName'],
          //         }
          //       };

          return Column(
            children: [
              buildHeader(),
              SizedBox(
                height: 5.sp,
              ),
              buildCenter(
                context,
                isLoading: isLoading,
                typeName: typeName,
              ),
              SizedBox(
                height: 5.sp,
              ),
              buildFooter(
                isLoading: isLoading,
                path: AssetsServices().getPath(
                  list: sourceTagPath,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

// =======================================================================
  // Footer

  Widget buildFooter({
    required bool isLoading,
    required String path,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: !isLoading && path.isNotEmpty,
          child: Icon(
            Icons.location_on,
            size: 12.sp,
          ),
        ),
        SizedBox(
          width: 3.sp,
        ),
        Expanded(
          child: Builder(builder: (context) {
            if (isLoading) {
              return ShimmerLoadingContainerWidget(
                height: 20.sp,
              );
            }

            return Visibility(
              visible: path.isNotEmpty,
              child: Text(
                path,
                style: TextStyle(
                  fontSize: 8.sp,
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  // ====================================================================
  // card center widget

  Row buildCenter(
    BuildContext context, {
    required bool isLoading,
    required String typeName,
  }) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.loose(Size.fromWidth(50.w)),
          child: Builder(
            builder: (context) {
              if (isLoading) {
                return ShimmerLoadingContainerWidget(
                  width: 80.sp,
                  height: 15.sp,
                );
              }

              return Visibility(
                visible: typeName.isNotEmpty,
                child: ContainerWithTextWidget(
                  value: typeName,
                  fontSize: 10.sp,
                ),
              );
            },
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 50.sp,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: LinearProgressIndicator(
              backgroundColor: f1White,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ), // Color of the progress bar

              value: pecentage / 100.0,
            ),
          ),
        ),
        SizedBox(
          width: 4.sp,
        ),
        Text("${pecentage.toStringAsFixed(1)}%")
      ],
    );
  }

  // =================================================================
  // Header

  Widget buildHeader() {
    return Row(
      children: [
        Expanded(child: Text(name)),
        SizedBox(
          width: 4.sp,
        ),
        buildCircleAvatar(
          value: resolvedCount.toString(),
          bgColor: Colors.green,
          isActive: false,
        ),
        SizedBox(
          width: 8.sp,
        ),
        buildCircleAvatar(
          value: activeCount.toString(),
          bgColor: Colors.red,
          isActive: true,
        ),
      ],
    );
  }

  Map<String, String> keyMapping = {
    'criticalities': 'criticality',
    'groups': 'category',
    'date': 'dateRange',
  };

  Map<String, String> filterKeyMapping = {
    'clientDomain': 'clients',
    'community': 'community',
    'subCommunity': 'siteGroup',
    'building': 'site',
  };

  // =====================================================================

  Widget buildCircleAvatar({
    required Color bgColor,
    required String value,
    required bool isActive,
  }) {
    int? count = int.tryParse(value);

    if (count == null) {
      value = "0";
    } else {
      value = count > 999 ? "999+" : count.toString();
    }

    return Builder(
        builder: (context) => GestureDetector(
            onTap: () {
              // filterValues
              //     .removeWhere((element) => element['key'] == "community");

              for (var element in filterValues) {
                String key = element['key'];

                if (key == "clientDomain") {
                  element['key'] == "clients";
                } else if (key == "community") {
                  element['key'] = "community";
                } else if (key == "subCommunity") {
                  element['key'] = "siteGroup";
                } else if (key == "building") {
                  element['key'] = "site";
                }

                if (element['key'] == "type") {
                  element['filterKey'] = "types";

                  dynamic value = element['identifier'];

                  if (value.runtimeType == String) {
                    element['identifier'] = [value];
                  }
                }

                if (keyMapping.containsKey(element['key'])) {
                  element['key'] = keyMapping[element['key']];
                }

                // if (filterKeyMapping.containsKey(key)) {
                //   element['filterKey'] = filterKeyMapping[key];
                // }

                String filterKey = element['filterKey'] ?? "";

                // print("filterKey: $filterKey");

                // if (filterKey == "type") {
                //   element['filterKey'] = "types";
                // }

                if (filterKey == "entity") {
                  Map<String, dynamic> entity = element['identifier'];

                  String? identifier = entity['data']?['identifier'];

                  element['filterKey'] = "searchTagIds";

                  if (element['key'] == "community") {
                    element['identifier'] = [identifier];

                    element['values'][0]['data'] = identifier;
                  }
                }
              }

              String? assetName = name;

              Navigator.of(context).pushNamed(
                ConslodationAlarmsListScreen.id,
                arguments: {
                  "alarmType":
                      isActive ? AlarmsTypes.active : AlarmsTypes.resolved,
                  "filterValues": [
                    ...filterValues,
                    {
                      "key": "assets",
                      "filterKey": "searchTagNames",
                      "identifier": [assetName],
                      "values": [
                        {
                          "name": assetName,
                          "data": assetName,
                        }
                      ]
                    },
                  ],
                },
              );
            },
            child: Chip(
              // padding: EdgeInsets.zero,
              backgroundColor: bgColor,
              label: Text(
                value,
                style: TextStyle(
                  color: kWhite,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )));
  }
}
