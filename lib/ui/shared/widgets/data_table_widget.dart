import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';

class BuildDataTableWidget extends StatelessWidget {
  const BuildDataTableWidget({
    super.key,
    required this.dataColumnsLabels,
    required this.values,
    this.suspectPointsList = const [],
  });

  final List<String> dataColumnsLabels;
  final List values;

//  Only using for alarm asset live checking the asset is available or not then showing the suspect icon
  final List suspectPointsList;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 3,
          dataRowMaxHeight: 45.sp,
          headingRowColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).primaryColor),
          columns: List.generate(
            dataColumnsLabels.length,
            (index) => DataColumn(
              label: Expanded(
                child: Text(
                  dataColumnsLabels[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          rows: List.generate(
            values.length,
            (index) {
              var map = values[index];

              return DataRow(
                color: index.isOdd
                    ? MaterialStatePropertyAll(
                        ThemeServices().getContainerBgColor(context))
                    : null,
                cells: List.generate(
                  dataColumnsLabels.length,
                  (index) {
                    String label = dataColumnsLabels[index];

                    String value = map[dataColumnsLabels[index]];

                    bool isSuspect = suspectPointsList.isEmpty
                        ? false
                        : label == "Point Name" &&
                            suspectPointsList.any(
                                (element) => element['pointName'] == value);

                    return buildDataCell(
                      value: map[dataColumnsLabels[index]],
                      isSuspect: isSuspect,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  DataCell buildDataCell({
    required String? value,
    required bool isSuspect,
  }) {
    return DataCell(
      SizedBox(
        width: 80.sp,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.sp),
          child: Builder(builder: (context) {
            if (isSuspect) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.flash_on_rounded,
                    color: Colors.red,
                    size: 12.sp,
                  ),
                  Expanded(
                    child: Text(
                      value ?? "N/A",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              );
            }

            return Text(
              value ?? "N/A",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            );
          }),
        ),
      ),
    );
  }
}
