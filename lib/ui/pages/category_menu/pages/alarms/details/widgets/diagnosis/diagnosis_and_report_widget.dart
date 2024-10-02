// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/ui/shared/widgets/build_title_and_data.dart';
import 'package:sizer/sizer.dart';

import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:skeletonizer/skeletonizer.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import '../../../../../../../../core/models/alarms/diagnosis_and_report_model.dart';
import 'diagnosis_routine_widget.dart';

// ignore: must_be_immutable
class DiagnosisAndReportWidget extends StatelessWidget {
  final String eventId;
  final String sourceId;
  final String name;
  DiagnosisAndReportWidget({
    Key? key,
    required this.eventId,
    required this.sourceId,
    required this.name,
  }) : super(key: key);

  List possibleCauses = [];
  List suggestions = [];
  List tools = [];
  List skills = [];

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
      options: GrapghQlClientServices().getQueryOptions(
          document: AlarmsSchema.getEventDetailDiagnosis,
          variables: {
            "data": {
              "eventId": eventId,
              "name": name,
              "sourceId": sourceId,
            },
          }),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return Skeletonizer(
            child: Column(
              children: List.generate(
                4,
                (index) => ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5.sp),
                    color: Colors.grey,
                    height: 30.sp,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          );
        }

        if (result.hasException) {
          return GrapghQlClientServices().handlingGraphqlExceptions(
            result: result,
            context: context,
            refetch: refetch,
          );
        }

        DiagnosisAndReportModel diagnosisAndReportModel =
            DiagnosisAndReportModel.fromJson(result.data ?? {});

        if (diagnosisAndReportModel.getEventDetailDiagnosis?.isEmpty ?? true) {
          return Column(
            children: [
              SvgPicture.asset(
                "assets/images/No connection-pana.svg",
                height: 70.sp,
              ),
              const Text("No data to show")
            ],
          );
        }

        List<Routines> routines = diagnosisAndReportModel
                .getEventDetailDiagnosis?.first.report?.routines ??
            [];

        routines.sort(
          (a, b) {
            int bPrecedence = b.precedence ?? 0;
            int aPrecedence = a.precedence ?? 0;

            return aPrecedence.compareTo(bPrecedence);
          },
        );

        bool routinesAllDone =
            routines.every((element) => element.success ?? false);

        if (routinesAllDone) {
          if (routines.isNotEmpty) {
            var reports = routines.last.reports ?? [];
            var report = reports.singleWhereOrNull(
                (element) => element.reportNature == "SUCCESS");

            suggestions = report?.suggestion ?? [];
            skills = report?.skills ?? [];
            tools = report?.tools ?? [];
            possibleCauses = report?.reason ?? [];
          }
        } else {
          var reports = routines.singleWhereOrNull((element) {
                return element.executionStatus != null &&
                    !element.executionStatus!;
              })?.reports ??
              [];

          var report = reports.singleWhereOrNull((element) {
            return element.reportNature == "FAILURE";
          });

          suggestions = report?.suggestion ?? [];
          skills = report?.skills ?? [];
          tools = report?.tools ?? [];
          possibleCauses = report?.reason ?? [];
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              routines.length,
              (index) {
                var routine = routines[index];

                String title = routine.name ?? "";

                bool? checked =
                    routine.executionStatus == null ? null : routine.success;

                List reasons = [];

                if (checked != null) {
                  reasons = routine.reports?.singleWhereOrNull((element) {
                        String reportNature = checked ? "SUCCESS" : "FAILURE";

                        return element.reportNature == reportNature;
                      })?.reason ??
                      [];
                }

                return DiagnosisRoutineWidget(
                  checked: checked,
                  // diagnosisList: diagnosisList,
                  title: title,
                  isLast: routines.length - 1 == index,
                  reasons: reasons,
                );
              },
            ),
            SizedBox(
              height: 10.sp,
            ),
            buildTitleAndData(
              title: "Possible causes",
              values: possibleCauses.isEmpty
                  ? ["No issues found"]
                  : routinesAllDone
                      ? ["No Possible causes"]
                      : possibleCauses,
            ),
            buildTitleAndData(
              title: "Suggestions",
              values: suggestions.isEmpty ? ["No suggestions"] : suggestions,
            ),
            buildTitleAndData(
              title: "Tools",
              values: tools.isEmpty
                  ? ["No tool recommendations available."]
                  : tools,
            ),
            buildTitleAndData(
              title: "Skills",
              values: skills.isEmpty
                  ? ["No skill recommendations available."]
                  : skills,
            )
          ],
        );
      },
    );
  }

  Widget buildTitleAndData({
    required String title,
    required List values,
  }) {
    return BuildTitleAndData(
      title: title,
      values: values,
    );
    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(
    //       title,
    //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.sp),
    //     ),
    //     SizedBox(
    //       height: 1.sp,
    //     ),
    //     ...List.generate(
    //       values.length,
    //       (index) => Text(
    //         values[index].toString(),
    //         style: TextStyle(
    //           height: 1.6,
    //           fontSize: 10.sp,
    //           fontWeight: FontWeight.w400,
    //         ),
    //       ),
    //     ),
    //     SizedBox(
    //       height: 13.sp,
    //     ),
    //   ],
    // );

    // return ListTile(
    //   title: Text(
    //     title,
    //     style: const TextStyle(
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    //   subtitle: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: List.generate(
    //         values.length,
    //         (index) => Text(
    //           values[index],
    //           style: TextStyle(
    //             height: 1.5,
    //           ),
    //         ),
    //       )),
    // );
  }
}
