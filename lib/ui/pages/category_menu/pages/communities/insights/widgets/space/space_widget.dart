// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/schemas/space_schema.dart';
import 'package:nectar_assets/core/services/charts/line_series_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/widgets/space/space_variance_distribution_chart.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../../core/models/space/get_space_insight_visulaization.dart';
import '../../../../../../../shared/widgets/cards/status_cards.dart';
import '../../../../../../../shared/widgets/container/background_container.dart';
import '../../../../../../../shared/widgets/loading_widget.dart';
import 'duration_analysis_space_chart.dart';
import 'space_rank_list.dart';

class SpaceInsightsWidgets extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String spaceId;

  SpaceInsightsWidgets({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.spaceId,
  }) : super(key: key);

  final LineSeriesServices lineSeriesServices = LineSeriesServices();

  @override
  Widget build(BuildContext context) {
    String formatedStartDate = DateFormat("dd MMM yyyy").format(startDate);
    String formatedEndDate = DateFormat("dd MMM yyyy").format(endDate);

    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
            rereadPolicy: true,
            query: SpaceSchema.getSpaceInsightVisualization,
            variables: {
              "data": {
                "dateRange": {
                  "startTime": startDate.millisecondsSinceEpoch,
                  "endTime": endDate.millisecondsSinceEpoch,
                },
                "spaceId": spaceId,
              }
            }),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              child: BgContainer(
                title:
                    "Temperature Analysis Consolidation from $formatedStartDate to $formatedEndDate",
                child: SizedBox(
                  height: 80.sp,
                  child: BuildShimmerLoadingWidget(
                    scrollDirection: Axis.horizontal,
                    height: 70.sp,
                    width: 120.sp,
                    padding: 10,
                  ),
                ),
              ),
            );
          }

          GetSpaceInsightVisualizationModel getSpaceInsightVisualizationModel =
              getSpaceInsightVisualizationModelFromJson(result.data ?? {});

          var varianceDistribution = getSpaceInsightVisualizationModel
                  .getSpaceInsightVisualization?.varianceDistribution ??
              [];

          List<Analysis> analysis = getSpaceInsightVisualizationModel
                  .getSpaceInsightVisualization?.analysis ??
              [];

          Consolidation? consolidation = getSpaceInsightVisualizationModel
              .getSpaceInsightVisualization?.consolidation;

          return Column(
            children: [
              bulidTemperatureAnalysisConsolidation(
                formatedStartDate: formatedStartDate,
                formatedEndDate: formatedEndDate,
                list: [
                  {
                    "title": "Average Return Temperature",
                    "value": consolidation?.avgTemperature,
                    "unit": "°C",
                  },
                  {
                    "title": "Average Set Point Temperature",
                    "value": consolidation?.avgSetpoint,
                    "unit": "°C",
                  },
                  {
                    "title": "Average Variance",
                    "value": consolidation?.avgVariance,
                  },
                  {
                    "title": "Cooling Index",
                    "value": consolidation?.coolingIndex,
                  },
                ],
              ),
              SpaceVarianceSpaceDistributionChart(
                varianceDistributionList: varianceDistribution,
                formatedStartDate: formatedStartDate,
                formatedEndDate: formatedEndDate,
              ),
              DurationAnalysisSpaceChart(
                formatedStartDate: formatedStartDate,
                formatedEndDate: formatedEndDate,
                analysis: analysis,
              ),
              SpaceRankingList(
                unit: "COP",
                title:
                    "Maintenance Rank from $formatedStartDate to $formatedEndDate",
                maintenanceRank: getSpaceInsightVisualizationModel
                        .getSpaceInsightVisualization?.maintenanceRank ??
                    [],
              ),
              SpaceRankingList(
                unit: "CI",
                title:
                    "Cooling Rank from $formatedStartDate to $formatedEndDate",
                maintenanceRank: getSpaceInsightVisualizationModel
                        .getSpaceInsightVisualization?.coolingIndexRank ??
                    [],
              ),
            ],
          );
        });
  }

  // ====================================================================================================

  Widget bulidTemperatureAnalysisConsolidation({
    required String formatedStartDate,
    required String formatedEndDate,
    required List list,
  }) {
    return BgContainer(
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      title:
          "Temperature Analysis Consolidation from $formatedStartDate to $formatedEndDate",
      child: SizedBox(
        height: 80.sp,
        child: ListView.separated(
          padding: EdgeInsets.all(7.sp),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = list[index];

            String title = data['title'];
            num value = data['value'] ?? 0;
            String unit = data['unit'] ?? "";

            return StatusCard(
              title: title,
              value: "${value.toStringAsFixed(1)} $unit",
              color: Theme.of(context).primaryColor,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: 5.sp);
          },
          itemCount: list.length,
        ),
      ),
    );
  }
}
