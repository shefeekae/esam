import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/models/alarms/mitigation_model.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'build_mitiagation_tile.dart';

class BuildMititgationWidget extends StatelessWidget {
  const BuildMititgationWidget({
    required this.eventId,
    super.key,
  });

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
          query: AlarmsSchema.findMitigationReport,
          variables: {
            "eventId": eventId,
          }),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return buildSkeltonLoading();
        }

        if (result.hasException) {
          return const Text("No Data to show");
          // return GrapghQlClientServices().handlingGraphqlExceptions(
          //   result: result,
          //   context: context,
          //   refetch: refetch,
          // );
        }

        MitigationModel mitigationModel =
            MitigationModel.fromJson(result.data ?? {});

        List<Steps> steps = mitigationModel.findMitigationReport?.steps ?? [];

        return Skeletonizer(
          enabled: result.isLoading,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 200.sp,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  steps.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                        bottom: steps.length - 1 == index ? 0 : 10.sp),
                    child: MitigationTileWidget(
                      step: steps[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSkeltonLoading() {
    return Skeletonizer(
      child: Column(
        children: List.generate(
          4,
          (index) => ListTile(
            title: Text("This is the loading data $index"),
            trailing: Text("item $index"),
          ),
        ),
      ),
    );
  }
}
