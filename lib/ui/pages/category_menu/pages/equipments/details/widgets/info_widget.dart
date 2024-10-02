// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:nectar_assets/core/models/asset/get_asset_operator_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/permissions/user_permission_services.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/add_operator_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/switch_breakdown_status.dart';
import 'package:nectar_assets/ui/shared/widgets/container_with_icon.dart';
import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../shared/widgets/listtile/list_tile_with_divider.dart';
import '../../../../../../shared/widgets/listtile/listtile_info_container_card.dart';

class BuildInfoWidget extends StatefulWidget {
  const BuildInfoWidget({
    super.key,
    required this.locationName,
    required this.totalOperationHours,
    required this.onboardedDate,
    required this.type,
    required this.identifier,
    required this.assetCondition,
    required this.refetch,
    required this.ownerClientId,
    required this.assetTypeName,
  });

  final String locationName;
  final num? totalOperationHours;
  final String onboardedDate;
  final String type;
  final String identifier;
  final bool assetCondition;
  final String ownerClientId;
  final String assetTypeName;

  final Future<Object?> Function()? refetch;

  @override
  State<BuildInfoWidget> createState() => _BuildInfoWidgetState();
}

class _BuildInfoWidgetState extends State<BuildInfoWidget> {
  ValueNotifier<bool> underMaintenance = ValueNotifier<bool>(true);

  @override
  void initState() {
    underMaintenance.value = widget.assetCondition;

    super.initState();
  }

  final bool assetConditionPermission = UserPermissionServices()
      .checkingPermission(
          featureGroup: "assetManagement",
          feature: "assetList",
          permission: "view");

  @override
  Widget build(BuildContext context) {
    return ContainerInfoCardWithDivider(
      children: [
        buildAssetConditionWidget(context),
        ListTielWithDivider(
          title: "Location Name",
          trailingText: widget.locationName,
          leadingIconData: Icons.location_on,
          maxLines: 2,
          showToolTip: true,
        ),
        ListTielWithDivider(
          title: "Asset Type",
          trailingText: widget.assetTypeName,
          leadingIconData: Icons.category,
          maxLines: 2,
          showToolTip: true,
        ),
        PermissionChecking(
          featureGroup: "rosterManagement",
          feature: "roster",
          permission: "create",
          child: ListTielWithDivider(
            title: "Current Operator",
            trailing: QueryWidget(
              options: GraphqlServices().getQueryOptions(
                query: AssetSchema.getAssetOperatorQuery,
                variables: {
                  "identifier": widget.identifier,
                },
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return const CircularProgressIndicator.adaptive();
                }

                  if (result.hasException) {
                    return TextButton(
                      onPressed: () {
                        refetch!.call();
                      },
                      child: const Text("Retry"),
                    );
                    //  GraphqlServices().handlingGraphqlExceptions(
                    //     result: result, context: context, refetch: refetch);
                  }

                  var data = result.data ?? {};

                  List<GetAssetOperator> assetOperatorList =
                      getAssetOperatorModelFromJson(data).getAssetOperator ??
                          [];

                  if (assetOperatorList.isEmpty) {
                    return GestureDetector(
                      onTap: () async {
                        // showAddOperatorDialog(context);
                        bool? isComplete = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddOperatorScreen(
                              ownerClientId: widget.ownerClientId,
                              identifier: widget.identifier,
                            ),
                          ),
                        );

                        if (isComplete ?? false) {
                          refetch?.call();
                        }
                      },
                      child: const ContainerWithIcon(
                        iconData: Icons.add,
                        bgColor: Colors.transparent,
                        iconColor: Colors.blue,
                      ),
                    );
                  }

                  String operatorName =
                      assetOperatorList.first.assignee?.name ?? "";

                return Text(
                  operatorName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                );
              },
            ),
            leadingIconData: Icons.engineering,
          ),
        ),
        ListTielWithDivider(
          title: "Total Operation Hours",
          trailingText: widget.totalOperationHours != null
              ? "${widget.totalOperationHours} h"
              : "Not available",
          leadingIconData: Icons.hourglass_empty_rounded,
        ),
        ListTielWithDivider(
          title: "On Boarded Date",
          trailingText: widget.onboardedDate,
          leadingIconData: Icons.done,
        ),
      ],
    );
  }

  // ================================================================================

  PermissionChecking buildAssetConditionWidget(BuildContext context) {
    return PermissionChecking(
        featureGroup: "assetManagement",
        feature: "dashboard",
        permission: "maintenance",
        child: ListTielWithDivider(
          leadingIconData: CupertinoIcons.waveform_path_ecg,
          title: "Asset Condition",
          trailing: GestureDetector(
            onTap: () async {
              bool? isComplete =
                  await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SwitchBreakDownStatusScreen(
                  identifier: widget.identifier,
                  type: widget.type,
                  underMaintenance: widget.assetCondition,
                ),
              ));

              if (isComplete ?? false) {
                widget.refetch?.call();
              }
            },
            child: ValueListenableBuilder(
                valueListenable: underMaintenance,
                builder: (context, value, child) {
                  return Container(
                    height: 20.sp,
                    padding: EdgeInsets.symmetric(horizontal: 2.sp),
                    decoration: BoxDecoration(
                      color:
                          widget.assetCondition ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: widget.assetCondition
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                minRadius: 8.sp,
                                backgroundColor: kWhite,
                              ),
                              SizedBox(
                                width: 5.sp,
                              ),
                              Text(
                                widget.assetCondition ? "Breakdown" : "Ok",
                                style: TextStyle(
                                  color: kWhite,
                                ),
                              ),
                              SizedBox(
                                width: 2.sp,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 2.sp,
                              ),
                              Text(
                                widget.assetCondition ? "Breakdown" : "Ok",
                                style: TextStyle(
                                  color: kWhite,
                                ),
                              ),
                              SizedBox(
                                width: 5.sp,
                              ),
                              CircleAvatar(
                                minRadius: 8.sp,
                                backgroundColor: kWhite,
                              ),
                            ],
                          ),
                  );
                }),
          ),
        ),
      );
  }
}
