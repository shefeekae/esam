import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/models/scheduler/scheduler_details_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:collection/collection.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'equipment_actions_expansion_tile.dart';
import 'package:nectar_assets/core/models/asset/assets_list_model.dart';

class SchedulerEquipmentPointActionsTiles extends StatefulWidget {
  SchedulerEquipmentPointActionsTiles({required this.equipments, super.key});

  final List<Source> equipments;

  @override
  State<SchedulerEquipmentPointActionsTiles> createState() =>
      _SchedulerEquipmentPointActionsTilesState();
}

class _SchedulerEquipmentPointActionsTilesState
    extends State<SchedulerEquipmentPointActionsTiles> {
  final UserDataSingleton userData = UserDataSingleton();

  final ValueNotifier<String> searchValueNotifier = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
        query: AssetSchema.getAssetList,
        variables: {
          "filter": {
            "assets": widget.equipments.map(
              (e) {
                return e.equipment?.toJson();
              },
            ).toList(),
            "order": "asc",
            "sortField": "displayName",
            "clients": [
              userData.domain,
            ]
          }
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return Skeletonizer(
            child: Column(
              children: List.generate(
                5,
                (index) => Padding(
                  padding: EdgeInsets.only(top: 5.sp),
                  child: ListTile(
                    tileColor: ThemeServices().getBgColor(context),
                    title: const Text("Loading"),
                    trailing: const Text("Loading...."),
                  ),
                ),
              ),
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

        var model = AssetsListModel.fromJson(result.data ?? {});

        var assetsList = model.getAssetList?.assets ?? [];

        return Column(
          children: [
            buildEquipmentActionsHeading(widget.equipments.length.toString()),
            ValueListenableBuilder(
                valueListenable: searchValueNotifier,
                builder: (context, value, _) {
                  var searchedList = widget.equipments.where((element) {
                    String name = element.equipment?.data?.displayName ?? "";

                    return name.toLowerCase().contains(value.toLowerCase());
                  }).toList();

                  return Column(
                    children: List.generate(
                      searchedList.length,
                      (index) {
                        var asset = assetsList.singleWhereOrNull((element) =>
                            element.identifier ==
                            searchedList[index].equipment?.data?.identifier);

                        var pathList = asset?.path
                                ?.where((element) => element.name != null)
                                .toList() ??
                            [];

                        String path = pathList
                            .map((e) => e.name ?? '')
                            .toList()
                            .join(' - ');

                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.sp),
                          child: EquipmentActionExpansionTile(
                            source: searchedList[index],
                            path: path,
                          ),
                        );
                      },
                    ),
                  );
                })
          ],
        );
      },
    );
  }

  // ======================================================
  Widget buildEquipmentActionsHeading(String count) {
    bool searchEnabled = false;

    return StatefulBuilder(
        builder: (context, setState) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Equipment Point Actions",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
              ),
              subtitle: Builder(
                builder: (context) {
                  if (searchEnabled) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 7.sp),
                      child: SizedBox(
                        height: 25.sp,
                        child: CupertinoTextField(
                          placeholder: "Search equpments",
                          style: TextStyle(
                            color:
                                Brightness.dark == Theme.of(context).brightness
                                    ? kWhite
                                    : kBlack,
                          ),
                          onChanged: (value) {
                            searchValueNotifier.value = value;
                          },
                        ),
                      ),
                    );
                  }

                  return Row(
                    children: [
                      Text(
                        "$count ",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          // color: kBlack,
                        ),
                      ),
                      Text(
                        "Equipments",
                        style: TextStyle(
                          fontSize: 10.sp,
                          // color: kBlack,
                        ),
                      ),
                    ],
                  );
                },
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(
                    () {
                      if (searchEnabled) {
                        searchValueNotifier.value = "";
                      }
                      searchEnabled = !searchEnabled;
                    },
                  );
                },
                icon: Icon(searchEnabled ? Icons.search_off : Icons.search),
              ),
            ));
  }
}
