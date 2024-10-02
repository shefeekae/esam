import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/charts/pie_chart_model.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../../core/models/space/get_space_insight_visulaization.dart';
import '../../../../../../../shared/widgets/chart/pie_chart_widget.dart';
import '../../../../../../../shared/widgets/container/background_container.dart';

class DurationAnalysisSpaceChart extends StatelessWidget {
  const DurationAnalysisSpaceChart({
    super.key,
    required this.formatedStartDate,
    required this.formatedEndDate,
    required this.analysis,
  });

  final String formatedStartDate;
  final String formatedEndDate;
  final List<Analysis> analysis;

  @override
  Widget build(BuildContext context) {
    if (analysis.isEmpty) {
      return const SizedBox();
    }

    return BgContainer(
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      title: "Duration Analysis from $formatedStartDate to $formatedEndDate",
      child: PieChartWidget(
        chartData: analysis.map(
          (e) {
            double value = e.value?.truncateToDouble() ?? 0;

            Color? color;

            switch (e.type) {
              case "maintained":
                color = Colors.green;
                break;
              case "off":
                color = Colors.red;
                break;
              default:
            }

            return ChartData(
              label: e.type ?? "",
              value: value,
              color: color,
            );
          },
        ).toList(),
        onDoubleTap: (chartData) {},
      ),
    );
  }
}
