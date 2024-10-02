import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:nectar_assets/core/models/work_order/work_order_details_model.dart';
import 'package:nectar_assets/core/schemas/work_order_schemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/functions/date_helpers.dart';
import 'package:nectar_assets/ui/shared/pages/work_order/work_order_details_screen.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:nectar_assets/ui/shared/widgets/container_with_text.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../core/models/work_order/work_order_list_model.dart';
import '../../../../../../shared/widgets/buttons/date_range_button.dart';

class WorkOrdersListScreen extends StatelessWidget {
  WorkOrdersListScreen({super.key});

  static const String id = "equipment/workorders";

  final ValueNotifier<DateTimeRange> dateRangeNotifier =
      ValueNotifier<DateTimeRange>(DateHelpers().get30DaysDateRange());

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    String? assetCode = args?['assetCode'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Work Orders"),
      ),
      body: PermissionChecking(
        featureGroup: "assetManagement",
        feature: "dashboard",
        permission: "workOrders",
        showNoAccessWidget: true,
        child: Column(
          children: [
            Center(
              child: DateRangePickerButton(
                initialDateTimeRange: DateHelpers().get30DaysDateRange(),
                onChanged: (dateTimeRange) {
                  dateRangeNotifier.value = dateTimeRange;
                },
              ),
            ),
            SizedBox(
              height: 5.sp,
            ),
            ValueListenableBuilder(
                valueListenable: dateRangeNotifier,
                builder: (context, dateRange, _) {
                  return QueryWidget(
                    options: GraphqlServices().getQueryOptions(
                      query: WorkOrderSchema.getWorkOrderListData,
                      variables: {
                        "data": {
                          "assetCode": assetCode,
                          "startDate": dateRange.start.millisecondsSinceEpoch,
                          "endDate": dateRange.end.millisecondsSinceEpoch,
                        }
                      },
                    ),
                    builder: (result, {fetchMore, refetch}) {
                      if (result.isLoading) {
                        return Expanded(
                          child: BuildShimmerLoadingWidget(
                            height: 50.sp,
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

                      GetWorkOrderListDataModel getWorkOrderListDataModel =
                          GetWorkOrderListDataModel.fromJson(result.data ?? {});

                      List<Wolist> wolist = getWorkOrderListDataModel
                              .getWorkOrderListData?.wolist ??
                          [];

                      return Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.all(7.sp),
                          itemBuilder: (context, index) {
                            Wolist workOrder = wolist[index];

                            return Bounce(
                              duration: const Duration(milliseconds: 100),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return WorkOrderDetailsScreen(
                                      workOrderId: null,
                                      woDetail:
                                          WoDetail.fromJson(workOrder.toJson()),
                                    );
                                  },
                                ));
                              },
                              child: BgContainer(
                                padding: EdgeInsets.all(7.sp),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints.loose(
                                              Size.fromWidth(40.w)),
                                          child: ContainerWithTextWidget(
                                            value:
                                                "#${workOrder.wONumber ?? ""}",
                                            fontSize: 8.sp,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          workOrder.reportedDate ?? "",
                                          style: TextStyle(
                                            fontSize: 8.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child:
                                              Text(workOrder.jobAgeing ?? ""),
                                        ),
                                        Text(workOrder.wOStatus ?? "")
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10.sp,
                            );
                          },
                          itemCount: wolist.length,
                        ),
                      );
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
