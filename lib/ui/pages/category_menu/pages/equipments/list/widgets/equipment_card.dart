import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/asset/assets_list_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../core/services/assets/assets_services.dart';
import '../../../../../../../core/services/theme/theme_services.dart';
import '../../../../../../shared/widgets/container_with_text.dart';
import '../../details/equipment_details.dart';
import 'package:timeago/timeago.dart' as timeago;

class EquipmentCard extends StatelessWidget {
  const EquipmentCard({super.key, required this.asset, this.bgColor});

  final Assets asset;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) => buildEquipmentCard(context);

// ==============================================================================
  Widget buildEquipmentCard(BuildContext context) {
    String locationPath = asset.path == null
        ? "Not available"
        : AssetsServices()
            .getPath(list: asset.path!.map((e) => e.toJson()).toList());

    return Bounce(
      duration: const Duration(milliseconds: 100),
      onPressed: () {
        Navigator.of(context).pushNamed(EquipmentDetailsScreen.id, arguments: {
          "domain": asset.domain,
          "type": asset.type,
          "identifier": asset.identifier,
          "displayName": asset.displayName,
        });
      },
      child: Container(
        padding: EdgeInsets.all(4.sp),
        decoration: BoxDecoration(
          color: bgColor ?? ThemeServices().getContainerBgColor(context),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.sp,
            ),
            Row(
              children: [
                QueryWidget(
                    options: GraphqlServices().getQueryOptions(
                        query: AssetSchema.getAssetTypeImage,
                        rereadPolicy: true,
                        variables: {
                          "type": asset.type,
                        }),
                    builder: (result, {fetchMore, refetch}) {
                      if (result.isLoading) {
                        return CircleAvatar(
                          minRadius: 23.sp,
                        );
                      }

                      String? base64Encoded =
                          result.data?['getAssetTypeImage']?['data'];

                      if (base64Encoded == null) {
                        return CircleAvatar(
                          minRadius: 23.sp,
                          backgroundImage: const AssetImage(
                            "assets/images/no-image.jpeg",
                          ),
                        );
                      }

                      return Container(
                        height: 40.sp,
                        width: 40.sp,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            // fit: BoxFit.f,
                            image: MemoryImage(
                              base64Decode(
                                base64Encoded,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  width: 5.sp,
                ),
                buildAssetTypeAndStatus()
              ],
            ),
            SizedBox(
              height: 3.sp,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                equipmentNameWithStatusIcon(
                  displayName: asset.displayName ?? "",
                  operationStatus: asset.operationStatus ?? "",
                ),
                SizedBox(
                  height: 7.sp,
                ),
                // equipmentTypewithStatus(
                //     typeName: asset.typeName ?? "", dataTime: asset.dataTime),
                // SizedBox(
                //   height: 10.sp,
                // ),
                lastCommunicated(dataTime: asset.dataTime),
                SizedBox(
                  height: 10.sp,
                ),
                buildOnboardedDate(
                  asset.createdOn,
                ),
                SizedBox(
                  height: 5.sp,
                ),
                buildAssetLocation(locationPath: locationPath),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column buildAssetTypeAndStatus() {
    String typeName = asset.typeName ?? "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Visibility(
          visible: typeName.isNotEmpty,
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(Size(70.sp, 25.sp)),
            child: ContainerWithTextWidget(
              value: typeName,
            ),
          ),
        ),
        SizedBox(
          height: 5.sp,
        ),
        Builder(
          builder: (context) {
            bool dataTimeIsNotNull = asset.dataTime != null;

            return ConstrainedBox(
              constraints: BoxConstraints.loose(Size(70.sp, 25.sp)),
              child: ContainerWithTextWidget(
                value: dataTimeIsNotNull ? "Connected" : "Not Connected",
                bgColor: dataTimeIsNotNull ? Colors.green : Colors.red,
                fgColor: dataTimeIsNotNull ? null : kWhite,
              ),
            );
          },
        )
      ],
    );
  }

  Row buildAssetLocation({required String locationPath}) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          // color: kBlack,
          size: 10.sp,
        ),
        SizedBox(
          width: 5.sp,
        ),
        ConstrainedBox(
          constraints: BoxConstraints.loose(Size(110.sp, 20.sp)),
          child: Text(
            locationPath,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 6.sp,
            ),
          ),
        ),
      ],
    );
  }

  getLocationPath(List<String?> list) {
    String value = list.where((element) => element != null).join(" - ");

    return value;
  }

  Row buildOnboardedDate(int? createdOn) {
    String dateTime = DateFormat("d MMM yyyy")
        .add_jm()
        .format(DateTime.fromMillisecondsSinceEpoch(createdOn ?? 0));

    return Row(
      children: [
        Icon(
          Icons.airplane_ticket_outlined,
          // color: kBlack,
          size: 10.sp,
        ),
        SizedBox(
          width: 5.sp,
        ),
        ConstrainedBox(
          constraints: BoxConstraints.loose(Size(110.sp, 20.sp)),
          child: Text(
            "Onboarded on ${dateTime.toString()}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 6.sp,
            ),
          ),
        ),
      ],
    );
  }

  Row lastCommunicated({required int? dataTime}) {
    DateTime? lastCommunicatedTime =
        dataTime == null ? null : DateTime.fromMillisecondsSinceEpoch(dataTime);

    String communicationMessage = lastCommunicatedTime == null
        ? "Communication not started"
        : "Communicated ${timeago.format(lastCommunicatedTime)}";

    return Row(
      children: [
        Icon(
          Icons.call_made,
          color: dataTime == null ? Colors.red : Colors.green,
          size: 10.sp,
        ),
        SizedBox(
          width: 5.sp,
        ),
        Expanded(
          child: Text(
            communicationMessage,
            maxLines: 2,
            style: TextStyle(
              fontSize: 6.sp,
            ),
          ),
        )
      ],
    );
  }

  Row equipmentTypewithStatus(
      {required String typeName, required int? dataTime}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ContainerWithTextWidget(
            value: typeName,
          ),
        ),
        SizedBox(
          width: 5.sp,
        ),
        Builder(
          builder: (context) {
            bool dataTimeIsNotNull = dataTime != null;

            return Expanded(
              child: ContainerWithTextWidget(
                value: dataTimeIsNotNull ? "Connected" : "Not Connected",
                bgColor: dataTimeIsNotNull ? Colors.green : Colors.red,
                fgColor: dataTimeIsNotNull ? null : kWhite,
              ),
            );
          },
        )
        // : const ContainerWithTextWidget(
        //     value: "Not Connected",
        //     bgColor: Colors.red,
        //     fgColor: Colors.white,
        //   )
        // : const SizedBox(),
      ],
    );
  }

  Row equipmentNameWithStatusIcon(
      {required String displayName, required String operationStatus}) {
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(Size.fromHeight(30.sp)),
            child: Text(
              displayName,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.sp),
          child: Tooltip(
            message:
                "Operation Status ${operationStatus.isEmpty ? "Unavailable" : operationStatus}",
            triggerMode: TooltipTriggerMode.tap,
            waitDuration: const Duration(seconds: 3),
            child: Icon(
              Icons.circle,
              size: 8.sp,
              color: AssetsServices()
                  .getOperationStatusColor(operationStatus: operationStatus),
            ),
          ),
        ),
      ],
    );
  }
}
