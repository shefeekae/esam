import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/asset/asset_info_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/assets/assets_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/widgets/sheets/custom_draggable_sheet.dart';
import 'package:nectar_assets/ui/shared/widgets/map/google_map_widget.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EquipmentLiveScreen extends StatelessWidget {
  EquipmentLiveScreen({super.key});

  static const String id = '/equipments/details/live';

  final UserDataSingleton userData = UserDataSingleton();

  final ValueNotifier<String> searchValueNotifier = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;

    String identifier = arguments["identifier"];
    String type = arguments["type"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Live"),
      ),
      body: QueryWidget(
          options: GraphqlServices().getQueryOptions(
            query: AssetSchema.findAssetSchema,
            variables: {
              "domain": userData.domain,
              "identifier": identifier,
              "type": type,
            },
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.hasException) {
              return GraphqlServices().handlingGraphqlExceptions(
                  result: result, context: context, refetch: refetch);
            }

            if (result.isLoading) {
              return Skeletonizer(child: buildDraggableSheet([], ""));
            }

            Map<String, dynamic> data = result.data!;

            AssetInfoModel assetInfo = assetInfoModelFromJson(data);

            List<Point> livePointsList =
                assetInfo.findAsset?.assetLatest?.points ?? [];

            String lastUpdated = DateFormat("dd MMM yyy").add_jm().format(
                DateTime.fromMillisecondsSinceEpoch(
                    assetInfo.findAsset?.assetLatest?.dataTime ?? 0));

            LatLng? latLng = AssetsServices().parseWktPoint(
                assetInfo.findAsset?.assetLatest?.location ?? "");

            return Skeletonizer(
              enabled: result.isLoading,
              child: Stack(
                children: [
                  GoogleMapWidget(
                    markers: AssetsServices().convertToMarkerLiveData(
                      context: context,
                      findAsset: assetInfo.findAsset,
                    ),
                    useFiltBounds: false,
                    zoom: 15,
                    target: latLng,
                  ),
                  buildDraggableSheet(livePointsList, lastUpdated),
                ],
              ),
            );
          }),
    );
  }

  // ===========================================================================

  Widget buildDraggableSheet(List<Point> livePointList, String lastUpdated) {
    return CustomDraggableScroallableSheet(
      builder: (context, controller) {
        return ListView(
          // controller: controller,
          controller: controller,
          shrinkWrap: true,
          children: [
            buildLiveDataHeader(context, lastUpdated),
            ValueListenableBuilder(
                valueListenable: searchValueNotifier,
                builder: (context, value, child) {
                  var searchedList = livePointList.where(
                    (element) {
                      String name = element.displayName ?? "";

                      return name.toLowerCase().contains(value.toLowerCase());
                    },
                  ).toList();

                  return ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    physics: const NeverScrollableScrollPhysics(),
                    // controller: controller,
                    itemBuilder: (context, index) {
                      Point livePoint = searchedList[index];

                      String unit = livePoint.unit ?? "";

                      String unitSymbol =
                          unit == "unitless" ? "" : livePoint.unitSymbol ?? "";

                      return ListTile(
                        title: Text(livePoint.pointName ?? ""),
                        trailing: SizedBox(
                          width: 110.sp,
                          child: Text(
                            livePoint.data == null
                                ? "N/A"
                                : "${livePoint.data.toString()} $unitSymbol",
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: searchedList.length,
                  );
                }),
          ],
        );
      },
    );
  }

  buildLiveDataHeader(BuildContext context, String lastUpdated) {
    bool isSearchEnabled = false;

    return StatefulBuilder(builder: (context, setState) {
      return ListTile(
        title: isSearchEnabled
            ? CupertinoTextField(
                placeholder: "Search live points",
                style: TextStyle(
                  color: Brightness.light == Theme.of(context).brightness
                      ? kBlack
                      : kWhite,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.sp),
                  color: Brightness.light == Theme.of(context).brightness
                      ? Colors.grey.shade300
                      : Colors.grey.shade800,
                ),
                onChanged: (value) {
                  searchValueNotifier.value = value;
                },
              )
            : RichText(
                text: TextSpan(
                    text: "Last Updated at  ",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                      color: Brightness.dark == Theme.of(context).brightness
                          ? kWhite
                          : kBlack,
                    ),
                    children: [
                      TextSpan(
                          text: lastUpdated,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ))
                    ]),
              ),
        trailing: IconButton(
          onPressed: () {
            setState(
              () {
                if (isSearchEnabled) {
                  searchValueNotifier.value = "";
                }

                isSearchEnabled = !isSearchEnabled;
              },
            );
          },
          icon: Icon(isSearchEnabled ? Icons.close : Icons.search),
        ),
      );
    });
  }
}
