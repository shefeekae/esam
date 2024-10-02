import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/alarms/live_data_model.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/services/alarms/alarms_details_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../../shared/widgets/data_table_widget.dart';

class AlarmLiveDataTable extends StatelessWidget {
  AlarmLiveDataTable({
    required this.sourceId,
    required this.suspectPoints,
    super.key,
  });

  final String sourceId;
  final List suspectPoints;

  // This array used for the skelton loading

  final List<Map<String, dynamic>> loadingData = [
    {
      "Point Name": "Loading",
      "Live": "Loading....",
      "Status": "Loading ...",
    },
    {
      "Point Name": "Loading",
      "Live": "Loading....",
      "Status": "Loading ...",
    },
    {
      "Point Name": "Loading",
      "Live": "Loading....",
      "Status": "Loading ...",
    },
    {
      "Point Name": "Loading",
      "Live": "Loading....",
      "Status": "Loading ...",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
        query: AlarmsSchema.getLiveData,
        variables: {
          "id": sourceId,
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return GraphqlServices().handlingGraphqlExceptions(
            result: result,
            context: context,
            refetch: refetch,
          );
        }

        bool isLoading = result.isLoading;

        var alarmLiveData = AlarmLiveData.fromJson(result.data ?? {});

        var points = alarmLiveData.getLiveData?.points ?? [];

        List<Map<String, dynamic>> liveData = isLoading
            ? []
            : AlarmsDetailsServices().getAlarmAssetLiveTableData(
                liveData: points, suspectPoints: suspectPoints);

        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
            alarmLiveData.getLiveData?.dataTime ?? 0);

        String dateFormated =
            DateFormat("dd-MMM yyy").add_jm().format(dateTime);

        return Skeletonizer(
          enabled: isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: "Last Updated at ",
                      style: TextStyle(
                        color: Brightness.dark == Theme.of(context).brightness
                            ? kWhite
                            : kBlack,
                      ),
                      children: [
                    TextSpan(
                        text: dateFormated,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                        ))
                  ])),
              SizedBox(
                height: 4.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.flash_on,
                    color: Colors.red,
                    size: 12.sp,
                  ),
                  const Text(" = Suspect"),
                ],
              ),
              BuildDataTableWidget(
                dataColumnsLabels: const ["Point Name", "Live", "Status"],
                values: isLoading ? loadingData : liveData,
                suspectPointsList: suspectPoints,
              ),
            ],
          ),
        );
      },
    );
  }
}
