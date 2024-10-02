import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/scheduler/scheduler_details_model.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/shared/widgets/data_table_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../shared/widgets/custom_expansion_tile.dart';

class EquipmentActionExpansionTile extends StatelessWidget {
  const EquipmentActionExpansionTile({
    required this.source,
    required this.path,
    super.key,
  });

  final Source source;
  final String path;

  @override
  Widget build(BuildContext context) {
    List<Points> points = source.points ?? [];

    return CustomExpansionTile(
        title: source.equipment?.data?.displayName ?? "N/A",
        subTitle:
           path,
        subTitleStyle: TextStyle(
          fontSize: 7.sp,
        ),
        children: [
          buildActionPointwidget(points),
        ]);
  }

  // ==========================================================================

  Widget buildActionPointwidget(List<Points> points) {
    return BuildDataTableWidget(
        dataColumnsLabels: const [
          'Point Name',
          "Schedule Value",
          "Out Of Schedule Value"
        ],
        values: List.generate(points.length, (index) {
          Points point = points[index];

          return {
            "Point Name": point.pointName ?? "",
            "Schedule Value":
                point.data == null ? "N/A" : point.data.toString(),
            "Out Of Schedule Value": point.defaultData == null
                ? "N/A"
                : point.defaultData.toString(),
          };
        }));

  }

// ==================================================

  Widget iconWithText(IconData iconData, String value) {
    return Builder(builder: (context) {
      return Row(
        children: [
          Icon(
            iconData,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: 2.sp,
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    });
  }
}
