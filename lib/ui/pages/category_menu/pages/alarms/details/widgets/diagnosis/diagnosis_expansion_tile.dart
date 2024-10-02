

import 'package:flutter/material.dart';

import '../../../../../../../shared/widgets/custom_expansion_tile.dart';
import 'diagnosis_and_report_widget.dart';

class DiagnosisAndReportExpansionTile extends StatelessWidget {
  const DiagnosisAndReportExpansionTile({
    super.key,
    required this.initiallyExpanded, required this.eventId, required this.name, required this.sourceId,
  });

  final bool initiallyExpanded;
  final String eventId;
  final String name;
  final String sourceId;

  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      initiallyExpanded: initiallyExpanded,
      title: "Diagnosis and Report",
      onExpansionChanged: (value) {
        if (value) {
          // expansionTileExpandNotifier.value = category;
        }
      },
      // initiallyExpanded: expansionTileExpandNotifier.value == category,
      children: [
        DiagnosisAndReportWidget(
          eventId: eventId,
          sourceId: sourceId,
          name: name,
        ),
      ],
    );
  }
}
