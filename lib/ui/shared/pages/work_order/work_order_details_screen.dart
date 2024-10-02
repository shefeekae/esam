import 'package:flutter/material.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:nectar_assets/core/models/work_order/work_order_details_model.dart';
import 'package:nectar_assets/core/schemas/work_order_schemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:sizer/sizer.dart';

class WorkOrderDetailsScreen extends StatelessWidget {
  WorkOrderDetailsScreen({this.woDetail, required this.workOrderId, super.key});

  static const String id = "workorder/details";

  final WoDetail? woDetail;
  final String? workOrderId;

  final ValueNotifier<String> appBarNameNotifier = ValueNotifier<String>("");

  void updateAppbarName(WoDetail? woDetail) {
    // addPostFrameCallback a function that schedules a callback to be called after the current frame is drawn
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appBarNameNotifier.value =
          woDetail?.wONumber == null ? "" : "WO #${woDetail?.wONumber ?? ""}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
            valueListenable: appBarNameNotifier,
            builder: (context, value, child) {
              return Text(value.isEmpty ? "Work Order Details" : value);
            }),
      ),
      body: Builder(builder: (context) {
        // If Work order details is already available showing that data
        if (woDetail != null) {
          return buildLayout(woDetail);
        }

        //  If work order detail not available calling the api
        return QueryWidget(
          options: GraphqlServices().getQueryOptions(
            query: WorkOrderSchema.getWorkOrderDetails,
            variables: {
              "workOrderId": workOrderId,
            },
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return BuildShimmerLoadingWidget(
                height: 40.sp,
              );
            }

            if (result.hasException) {
              return GraphqlServices().handlingGraphqlExceptions(
                result: result,
                context: context,
                refetch: refetch,
              );
            }

            GetWorkOrderDetailsModel getWorkOrderDetailsModel =
                GetWorkOrderDetailsModel.fromJson(result.data ?? {});

            GetWorkOrderDetails? getWorkOrderDetails =
                getWorkOrderDetailsModel.getWorkOrderDetails;

            List<WoDetail> woDetailList = getWorkOrderDetails?.woDetail ?? [];

            WoDetail? woDetail =
                woDetailList.isEmpty ? null : woDetailList.first;

            return buildLayout(woDetail);
          },
        );
      }),
    );
  }

  Padding buildLayout(WoDetail? woDetail) {
    updateAppbarName(woDetail);

    return Padding(
      padding: EdgeInsets.all(7.sp),
      child: ListView(
        children: [
          bulidListTile(
            title: "WO Number",
            value: woDetail?.wONumber,
          ),
          bulidListTile(
            title: "Sub Contractor",
            value: woDetail?.subContractor,
          ),
          bulidListTile(
            title: "WO Status",
            value: woDetail?.wOStatus,
          ),
          bulidListTile(
            title: "Assigned",
            value: woDetail?.assigned,
          ),
          bulidListTile(
            title: "Priority",
            value: woDetail?.priority,
          ),
          bulidListTile(
            title: "Contact",
            value: woDetail?.contact,
          ),
          bulidListTile(
            title: "Contact Number",
            value: woDetail?.contactNumber,
          ),
        ],
      ),
    );
  }

  Widget bulidListTile({
    required String title,
    required String? value,
  }) {
    return Builder(
        builder: (context) => BgContainer(
              margin: EdgeInsets.symmetric(vertical: 3.sp),
              child: ListTile(
                title: Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitle: Text(
                    value == null || value.isEmpty ? "Not Available" : value),
              ),
            ));
  }
}
