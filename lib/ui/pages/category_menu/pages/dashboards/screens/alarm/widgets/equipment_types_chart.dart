import 'package:app_filter_form/core/blocs/filter/payload/payload_management_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/models/dashboard/equipment_type_chart_data_model.dart';
import 'package:nectar_assets/core/schemas/dashboard_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/panels/panels_instights_charts_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/alarm_dashboard.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/functions/chart_functions.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/model/active_alarm_aging_distribution_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/model/equipment_type_chart_model.dart';
import 'package:nectar_assets/ui/shared/functions/reorder_map.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EquipmentTypesChartWidget extends StatelessWidget {
  EquipmentTypesChartWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.entity,
    required this.dropdownType,
  });

  final int startDate;
  final int endDate;
  final Map<String, dynamic>? entity;
  final Level dropdownType;

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "domain": userData.domain,
      "facetField": "sourceType",
      "startDate": startDate,
      "endDate": endDate,
      "entity": {
        "type": userData.tenant["type"],
        "data": {
          "domain": userData.tenant["domain"],
          "identifier": userData.tenant["identifier"],
        }
      }
    };

    if (entity != null) {
      data["entity"] = entity;
    }

    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
          query: DashboardSchema.getTypeEventConsolidation,
          rereadPolicy: true,
          variables: {"data": data},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Skeletonizer(
              enabled: true,
              child: buildLayout(
                context,
                [],
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

          List<EquipmentTypeChartModel> chartData = [];

          var data = result.data ?? {};

          EquipmentTypeChartData equipmentTypeChartData =
              EquipmentTypeChartData.fromJson(data);

          List<GetTypeEventConsolidation> equipmentTypeList =
              equipmentTypeChartData.getTypeEventConsolidation ?? [];

          if (equipmentTypeList.isEmpty) {
            return const SizedBox();
          }

          equipmentTypeList = equipmentTypeList.length > 10
              ? equipmentTypeList.take(10).toList()
              : equipmentTypeList;

          chartData = List.generate(equipmentTypeList.length, (index) {
            GetTypeEventConsolidation eventConsolidation =
                equipmentTypeList[index];
            return EquipmentTypeChartModel(
              count: eventConsolidation.count ?? 0,
              title: eventConsolidation.typeName ?? "",
              type: eventConsolidation.type ?? "",
            );
          });

          return buildLayout(context, chartData);
        });
  }

  Padding buildLayout(
      BuildContext context, List<EquipmentTypeChartModel> chartData) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: BgContainer(
        title: "Top 10 Equipment types based on All Alarms",
        titilePadding: EdgeInsets.all(8.sp),
        child: SfCartesianChart(
          backgroundColor: ThemeServices().getBgColor(context),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            canShowMarker: true,
            activationMode: ActivationMode.singleTap,
            shouldAlwaysShow: true,
            shared: true,
          ),
          plotAreaBorderWidth: 0,
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enablePanning: true,
          ),
          primaryXAxis: CategoryAxis(
            axisLine: const AxisLine(width: 1),
            majorTickLines: const MajorTickLines(size: 0),
            labelAlignment: LabelAlignment.center,
          ),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compact(),
          ),
          series: ChartServices().getEquipmentTypeChartSeries(
              chartData: chartData,
              context: context,
              dropdownType: dropdownType,
              endDate: endDate,
              startDate: startDate,
              entity: entity),
        ),
      ),
    );
  }
}
