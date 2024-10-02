import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/asset/equipment_ppm_log_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/functions/duration_format.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:nectar_assets/ui/shared/widgets/container_with_text.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:sizer/sizer.dart';

class EquipmentMaintenanceScreen extends StatelessWidget {
  const EquipmentMaintenanceScreen({super.key});

  static const String id = "equipment/maintenance";

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Maintenance Log"),
      ),
      body: QueryWidget(
          options: GraphqlServices().getQueryOptions(
            query: AssetSchema.getPPMLogs,
            variables: {
              "asset": args?['asset'],
              "page": 0
            },
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return BuildShimmerLoadingWidget(
                height: 100.sp,
                padding: 8.sp,
              );
            }

            if (result.hasException) {
              return GraphqlServices().handlingGraphqlExceptions(
                result: result,
                context: context,
                refetch: refetch,
              );
            }

            GetPPMLogModel getPPMLogModel =
                GetPPMLogModel.fromJson(result.data ?? {});

            List<Items> items = getPPMLogModel.getPPMLog?.items ?? [];

            if (items.isEmpty) {
              return const Center(
                child: Text("No Data"),
                
              );
            }

            return RefreshIndicator.adaptive(
              onRefresh: () async {
                refetch?.call();
              },
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                itemBuilder: (context, index) {
                  Items item = items[index];

                  return BgContainer(
                    padding: EdgeInsets.all(8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: item.createdBy != null,
                          child: Row(
                            children: [
                              Text(
                                "Marked By: ",
                                style: TextStyle(
                                  fontSize: 8.sp,
                                ),
                              ),
                              // Spacer(),
                              // SizedBox(width: 10.sp, child: Divider()),
                              Expanded(
                                child: Text(
                                  item.createdBy ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.sp),
                            child: ContainerWithTextWidget(
                              value: item.status ?? "",
                              fontSize: 8.sp,
                            )),
                        Builder(builder: (context) {
                          String? startTimeFormatted = item.startTime == null
                              ? null
                              : DateFormat("MMM dd, yyyy").add_jm().format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      item.startTime!));

                          String? endTimeFormatted = item.endTime == null
                              ? null
                              : DateFormat("MMM dd, yyyy").add_jm().format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      item.endTime!));

                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  startTimeFormatted ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                endTimeFormatted ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        }),
                        Visibility(
                          visible: item.duration != null,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.sp),
                            child: Center(
                              child: Text(
                                formatDuration(
                                    Duration(milliseconds: item.duration ?? 0),
                                    hourSymbol: "hours",
                                    minutesSymbol: "min",
                                    secondsSymbol: "seconds"),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7.sp,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "Work Order Id: ",
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                    ),
                                  ),
                                  ContainerWithTextWidget(
                                    value: item.workOrderId ?? "N/A",
                                    fontSize: 8.sp,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Work Order Number: ",
                              style: TextStyle(
                                fontSize: 8.sp,
                              ),
                            ),
                            ContainerWithTextWidget(
                              value: item.workOrderNo ?? "N/A",
                              fontSize: 8.sp,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10.sp,
                  );
                },
                itemCount: items.length,
              ),
            );
          }),
    );
  }
}
