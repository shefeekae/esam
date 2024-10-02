import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/asset/asset_info_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/schemas/documents_schemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/permissions/user_permission_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/documents/list/documents_list_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/connected_equipments/connected_equipments_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/equipment_data_trends_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/equipment_maintenance_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/equpment_live_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/work_orders_list_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/widgets/info_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/circle_avatar_with_icon.dart';
import 'package:nectar_assets/ui/shared/widgets/container_with_icon.dart';
import 'package:nectar_assets/ui/shared/widgets/container_with_listtile.dart';
import 'package:nectar_assets/ui/shared/widgets/container_with_text.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'pages/profile_screen.dart';
import 'widgets/insights_expansion_tile.dart';
import 'package:collection/collection.dart';

class EquipmentDetailsScreen extends StatelessWidget {
  EquipmentDetailsScreen({super.key});

  static const String id = 'equipments/details';

  final SizedBox sizedBox = SizedBox(
    height: 10.sp,
  );

  final UserDataSingleton userData = UserDataSingleton();

  final bool hasPermission = UserPermissionServices().checkingPermission(
      featureGroup: "assetManagement",
      feature: "assetList",
      permission: "view");

  final ValueNotifier<String> appBarNameNotifer = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Assets asset = arguments["asset"];
    String identifier = arguments["identifier"] ?? "";
    String type = arguments["type"] ?? "";
    String displayName = arguments['displayName'] ?? "Asset Details";
    String domain = arguments['domain'] ?? "";

    appBarNameNotifer.value = displayName;

    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
            valueListenable: appBarNameNotifer,
            builder: (context, value, child) {
              return Text(
                value,
              );
            }),
      ),
      body: PermissionChecking(
        featureGroup: "assetManagement",
        feature: "assetList",
        permission: "view",
        showNoAccessWidget: true,
        child: QueryWidget(
          options: GraphqlServices().getQueryOptions(
            query: AssetSchema.findAssetSchema,
            variables: {
              "domain": domain,
              "identifier": identifier,
              "type": type,
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

            if (result.isLoading) {
              return Skeletonizer(
                child: buildLayout(
                  null,
                  null,
                  assetDataMap: {},
                ),
              );
            }

            Map<String, dynamic> data = result.data ?? {};

            AssetInfoModel assetInfo = assetInfoModelFromJson(data);

            updateAppbarName(assetInfo.findAsset?.asset?.data?.displayName);

            return buildLayout(
              assetInfo,
              refetch,
              assetDataMap: result.data?['findAsset']?['asset'] ?? {},
            );
          },
        ),
      ),
    );
  }

  void updateAppbarName(String? value) {
    Future.delayed(
      const Duration(milliseconds: 10),
      () {
        appBarNameNotifer.value = value ?? "Asset Details";
      },
    );
  }

  Column buildLayout(
    AssetInfoModel? assetInfo,
    Future<Object?> Function()? refetch, {
    required Map<String, dynamic> assetDataMap,
  }) {
    int? dataTime = assetInfo?.findAsset?.assetLatest?.dataTime;

    AssetData assetData = assetInfo?.findAsset?.asset?.data ?? AssetData();

    DateTime? parsedTime =
        dataTime == null ? null : DateTime.fromMillisecondsSinceEpoch(dataTime);

    var dateFormat = DateFormat.yMd().add_jm();

    String communicationMessage = parsedTime == null
        ? "Communication not started"
        : "Last Communicated on ${dateFormat.format(parsedTime).toString()} ";

    String locationName = assetInfo?.findAsset?.assetLatest?.path == null
        ? "Not available"
        : getPath(
            list: assetInfo?.findAsset?.assetLatest?.path
                ?.map((e) => e.toJson())
                .toList());

    String onboardedDate = DateFormat("dd MMM yyy").add_jm().format(
        DateTime.fromMillisecondsSinceEpoch(
            assetInfo?.findAsset?.asset?.data?.createdOn ?? 0));

    num? runHours = assetInfo?.findAsset?.settings?.runhours;

    Point? fuelPoint = getPointData(
        assetInfo?.findAsset?.assetLatest?.points, "Fuel Remaining");

    Point? engineStatusPoint = getPointData(
        assetInfo?.findAsset?.assetLatest?.points, "Engine Status");

    num? fuelRemaining;

    if (fuelPoint?.data.runtimeType == double ||
        fuelPoint?.data.runtimeType == int) {
      fuelRemaining = fuelPoint?.data;
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10.sp),
          child: buildHeader(
            assetInfo?.findAsset,
            assetType:
                assetInfo?.findAsset?.asset?.data?.typeName ?? "Not available",
            dataTime: assetInfo?.findAsset?.assetLatest?.dataTime,
            fuelRemaining: fuelRemaining?.toDouble(),
            lastCommuncatedMessage: communicationMessage,
            engineStatus: engineStatusPoint?.data,
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(10.sp),
            children: [
              // SizedBox(
              //   height: 10.sp,
              // ),
              PermissionChecking(
                featureGroup: "assetManagement",
                feature: "dashboard",
                permission: "insights",
                child: InsightsExpansionTile(
                  asset: assetData,
                  type: assetInfo?.findAsset?.asset?.type,
                ),
              ),
              // sizedBox,
              BuildInfoWidget(
                ownerClientId:
                    assetInfo?.findAsset?.device?.data?.ownerClientId ?? "",
                assetCondition:
                    assetInfo?.findAsset?.assetLatest?.underMaintenance ??
                        false,
                locationName: locationName,
                onboardedDate: onboardedDate,
                totalOperationHours: runHours,
                type: assetInfo?.findAsset?.asset?.type ?? "",
                identifier: assetInfo?.findAsset?.asset?.data?.identifier ?? "",
                assetTypeName:
                    assetInfo?.findAsset?.asset?.data?.typeName ?? "N/A",
                refetch: refetch,
              ),
              buildContainerWithListTile(
                title: "Data Trends",
                iconData: Icons.trending_up,
                screenId: EquipmentDataTrendsScreen.id,
                arguments: {
                  "criticalPoints": assetInfo?.findAsset?.criticalPoints
                      ?.map((e) => e.data?.pointName ?? "")
                      .toList(),
                  "points": assetInfo?.findAsset?.assetLatest?.points?.map((e) {
                    return e.pointName ?? "";
                  }).toList(),
                  "identifier": assetData.identifier ?? "",
                  "domain": assetData.domain ?? "",
                  "type": assetInfo?.findAsset?.asset?.type ?? "",
                },
              ),
              PermissionChecking(
                featureGroup: "assetManagement",
                feature: "dashboard",
                permission: "workOrders",
                child: buildContainerWithListTile(
                  title: "Work Orders",
                  iconData: Icons.list_alt,
                  screenId: WorkOrdersListScreen.id,
                  arguments: {
                    "assetCode": assetData.assetCode,
                  },
                ),
              ),
              PermissionChecking(
                featureGroup: "assetManagement",
                feature: "dashboard",
                permission: "connectedAssets",
                child: buildContainerWithListTile(
                  title: "Connected Equipments",
                  iconData: Icons.cable,
                  screenId: ConnectedEquipmentsScreen.id,
                  arguments: {
                    "entity": {
                      "type": assetDataMap['type'],
                      "data": {
                        "identifier": assetDataMap['data']?['identifier'],
                        "domain": assetDataMap['data']?['domain'],
                      },
                    },
                  },
                ),
              ),
              PermissionChecking(
                featureGroup: "assetManagement",
                feature: "dashboard",
                permission: "maintenance",
                child: buildContainerWithListTile(
                  title: "Maintenance",
                  iconData: Icons.manage_accounts,
                  screenId: EquipmentMaintenanceScreen.id,
                  arguments: {
                    "asset": {
                      "type": assetDataMap['type'],
                      "data": {
                        "identifier": assetDataMap['data']?['identifier'],
                        "domain": assetDataMap['data']?['domain'],
                      },
                    },
                  },
                ),
              ),
              PermissionChecking(
                featureGroup: "assetManagement",
                feature: "assetList",
                permission: "update",
                child: buildContainerWithListTile(
                  title: "Profile",
                  iconData: Icons.info_outline,
                  screenId: EquipmentProfileScreen.id,
                  refetch: refetch,
                  arguments: {
                    "assetEntity": {
                      "type": assetDataMap['type'],
                      "data": {
                        "identifier": assetDataMap['data']?['identifier'],
                        "domain": assetDataMap['data']?['domain'],
                      },
                    },
                    "assetInfoData": assetDataMap['data'],
                  },
                ),
              ),
              PermissionChecking(
                featureGroup: "assetManagement",
                feature: "dashboard",
                permission: "live",
                child: buildContainerWithListTile(
                  title: "Live",
                  iconData: Icons.settings_input_antenna,
                  screenId: EquipmentLiveScreen.id,
                  arguments: {
                    "identifier": assetInfo?.findAsset?.asset?.data?.identifier,
                    "type": assetInfo?.findAsset?.asset?.type,
                  },
                ),
              ),
              buildContainerWithListTile(
                  title: "Documents",
                  iconData: Icons.folder,
                  screenId: DocumentsListScreen.id,
                  arguments: {
                    "asset": {
                      "type": assetInfo?.findAsset?.asset?.type,
                      "data": {
                        "domain": assetInfo?.findAsset?.asset?.data?.domain,
                        "identifier":
                            assetInfo?.findAsset?.asset?.data?.identifier,
                        "displayName":
                            assetInfo?.findAsset?.asset?.data?.displayName,
                      }
                    },
                  }),
              // buildContainerWithListTile(
              //   title: "Graphics",
              //   iconData: Icons.graphic_eq,
              //   screenId: "",
              //   arguments: {},
              // ),

              // buildContainerWithListTile(
              //   title: "Services",
              //   iconData: Icons.design_services,
              //   screenId: EquipmentLiveScreen.id,
              // ),
            ],
          ),
        ),
      ],
    );
  }

  // =================================================

  Widget buildContainerWithListTile({
    required String title,
    required IconData iconData,
    required String screenId,
    required Map<String, dynamic> arguments,
    Future<Object?> Function()? refetch,
  }) {
    return Builder(
        builder: (context) => Padding(
              padding: EdgeInsets.only(top: 10.sp),
              child: ContainerWithListTile(
                onTap: () async {
                  bool? isSuccess = await Navigator.of(context)
                      .pushNamed<dynamic>(screenId, arguments: arguments);

                  if (isSuccess ?? false) {
                    if (refetch != null) {
                      refetch();
                    }
                  }
                },
                leading: ContainerWithIcon(iconData: iconData),
                title: title,
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 10.sp,
                ),
              ),
            ));
  }

  String getPath({required List? list}) {
    String sourceTagPath = "";

    for (var index = 0; index < list!.length; index++) {
      String name = list[index]['name'];
      sourceTagPath = index == 0 ? name : "$sourceTagPath  -  $name";
    }
    return sourceTagPath;
  }

  // =====================================================================

  Widget buildHeader(
    FindAsset? findAsset, {
    required String assetType,
    required int? dataTime,
    required double? fuelRemaining,
    required String lastCommuncatedMessage,
    required String? engineStatus,
  }) {
    return Row(
      children: [
        buildProfileImage(findAsset),
        SizedBox(
          width: 10.sp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ContainerWithTextWidget(value: assetType),
                SizedBox(
                  width: 5.sp,
                ),
                Builder(builder: (context) {
                  bool dataTimeIsNotNull = dataTime != null;

                  return ContainerWithTextWidget(
                    value: dataTimeIsNotNull ? "Connected" : "Not Connected",
                    bgColor: dataTimeIsNotNull ? Colors.green : Colors.red,
                    fgColor: kWhite,
                  );
                }),
              ],
            ),
            SizedBox(
              height: 7.sp,
            ),
            Row(
              children: [
                Visibility(
                  visible: fuelRemaining != null,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CircleAvatarWithIcon(
                          iconData: Icons.local_gas_station_outlined,
                          iconSize: 13.sp,
                        ),
                      ),
                      CircularProgressIndicator(
                        value: fuelRemaining == null ? 0 : fuelRemaining / 100,
                        // value: 9.0 / 100,
                        backgroundColor: Colors.grey.shade400,
                        color: getFuelColor(fuelRemaining ?? 0),
                        strokeWidth: 5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5.sp,
                ),
                Visibility(
                  visible: engineStatus != null,
                  child: Icon(
                    Icons.power_settings_new_outlined,
                    size: 20.sp,
                    color: engineStatus == "ON" ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 7.sp,
            ),
            Text(
              lastCommuncatedMessage,
              style: TextStyle(
                fontSize: 8.sp,
                color: kGrey,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildProfileImage(FindAsset? findAsset) {
    return QueryWidget(
      options: GrapghQlClientServices().getQueryOptions(
        document: DocumentSchema.getFilePreviewQuery,
        variables: {
          "fileName": findAsset?.asset?.data?.profileImage,
          // "10221276943_57de974346_h.jpg_e79666c9-3a72-4506-8243-b71b304eb3ac.jpg",
          "filePath":
              "assets/${findAsset?.asset?.data?.domain}/${findAsset?.asset?.data?.identifier}/profileImages"
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return CircleAvatar(
            radius: 30.sp,
          );
        }

        if (result.hasException) {}

        String? data = result.data?["getFileForPreview"]?['data'];

        if (data == null) {
          return CircleAvatar(
            radius: 30.sp,
            backgroundImage: const AssetImage(
              "assets/images/no-image.jpeg",
            ),
          );
        }

        return Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                // fullscreenDialog: true,
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Scaffold(
                      // backgroundColor: Colors.transparent,
                      body: Center(
                          child: Hero(
                        tag: "profile_image",
                        child: Container(
                          // radius: 120.sp,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: MemoryImage(
                              base64Decode(data),
                            ),
                          )),
                        ),
                      )),
                    ),
                  );
                },
              ));
            },
            child: Hero(
              tag: "profile_image",
              child: CircleAvatar(
                radius: 30.sp,
                backgroundImage: MemoryImage(base64Decode(data)),
              ),
            ),
          );
        });
      },
    );
  }

  getPointData(List<Point>? points, String matchValue) {
    var fuelPoint =
        points?.singleWhereOrNull((point) => point.pointName == matchValue);

    return fuelPoint;
  }

  getFuelColor(double fuelRemaining) {
    if (fuelRemaining >= 50) {
      return Colors.green;
    } else if (fuelRemaining < 50 && fuelRemaining >= 10) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
