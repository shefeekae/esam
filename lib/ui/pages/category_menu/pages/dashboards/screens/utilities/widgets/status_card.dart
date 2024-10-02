import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/models/dashboard/utilities_stat_card_model.dart';
import 'package:nectar_assets/core/schemas/dashboard_schema.dart';
import 'package:nectar_assets/core/services/communities/communites_insights_status_cards_services.dart';
import 'package:nectar_assets/core/services/dashboards/dashboard_status_card_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';

class UtilitiesStatusCard extends StatelessWidget {
  UtilitiesStatusCard({
    this.entity,
    required this.currentYear,
    required this.previousYear,
    required this.level,
    super.key,
  });

  final Map<String, dynamic>? entity;
  final Level level;

  final CommunityInsightsStatusServices communityInsightsStatusServices =
      CommunityInsightsStatusServices();

  final int currentYear;
  final int previousYear;

  // final DateTime dateTime = DateTime.now();

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "currentYear": currentYear.toString(),
      "previousYear": previousYear.toString(),
    };

    if (entity != null) {
      String? identifier = entity?['data']?['identifier'];
      if (level == Level.community) {
        data['community'] = identifier;
      } else if (level == Level.subCommunity) {
        data['subCommunity'] = entity;
      } else if (level == Level.site) {
        data["site"] = entity;
      } else if (level == Level.site) {
        data["site"] = entity;
      } else if (level == Level.equipment) {
        data["equipment"] = entity;
      } else if (level == Level.subMeter) {
        data["subMeter"] = entity;
      }
    } else {
      data['domain'] = userData.domain;
    }

    return Column(
      children: [
        SizedBox(
          height: 75.sp,
          child: QueryWidget(
              options: GraphqlServices().getQueryOptions(
                rereadPolicy: true,
                query: DashboardSchema.getUtilitiesData,
                variables: {"data": data},
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return BuildShimmerLoadingWidget(
                    scrollDirection: Axis.horizontal,
                    height: 70.sp,
                    width: 120.sp,
                    padding: 0,
                  );
                }

                if (result.hasException) {
                  GraphqlServices().handlingGraphqlExceptions(
                      result: result, context: context);
                }

                var data = result.data ?? {};

                List<UtilitiesStatusCardModel> list =
                    DashboardStatusCardServices().getStatusCardList(
                        data, currentYear, previousYear, level);

                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    UtilitiesStatusCardModel data = list[index];

                    Color? bgColor = data.color ??
                        communityInsightsStatusServices
                            .getIncreaseDecreaseColor(
                                increased: data.increased)['bgColor'];
                    Color? iconColor = communityInsightsStatusServices
                        .getIncreaseDecreaseColor(
                            increased: data.increased)['iconColor'];

                    return Visibility(
                      visible:
                          data.currentValue != '0' || data.previousValue != '0',
                      child: Container(
                        // width: 250.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: bgColor,
                        ),
                        padding: EdgeInsets.all(5.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildHeader(data.name),
                            SizedBox(
                              height: 5.sp,
                            ),
                            buildCenter(
                              value: data.compareValue,
                              iconColor: iconColor,
                              increased: data.increased,
                              percentage: data.percentage,
                              unit: data.unit,
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            buildFooter(
                              yearValue: data.currentValue,
                              previousYearValue: data.previousValue,
                              previousYear: data.previousYear,
                              year: data.currentYear,
                              percentageColor: iconColor,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 5.sp);
                  },
                  itemCount: list.length,
                );
              }),
        ),
      ],
    );
  }

  // ==============

  Widget buildFooter({
    required String year,
    required String yearValue,
    required String previousYear,
    required String previousYearValue,
    required Color? percentageColor,
  }) {
    TextStyle style = TextStyle(
      color: kWhite,
      fontSize: 8.sp,
      fontWeight: FontWeight.bold,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          year.isEmpty ? yearValue : "$year : $yearValue",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: style,
        ),
        Text(
          previousYear.isEmpty
              ? previousYearValue
              : "$previousYear : $previousYearValue",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: style,
        ),
      ],
    );
  }

  // ===========================================

  Widget buildCenter({
    required String value,
    required Color? iconColor,
    required bool? increased,
    required String percentage,
    required String unit,
  }) {
    if (increased == null) {
      return Text(
        value,
        maxLines: 1,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: kWhite,
        ),
      );
    }

    return Row(
      children: [
        Icon(
          increased ? Icons.arrow_downward : Icons.arrow_upward,
          color: iconColor,
          size: 20.sp,
        ),
        SizedBox(
          width: 3.sp,
        ),
        Text(
          "$value $unit",
          maxLines: 1,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: kWhite,
          ),
        ),
        Text(
          percentage,
          maxLines: 1,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: kWhite,
          ),
        ),
      ],
    );
  }

  // ==========================================

  Text buildHeader(String name) => Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 10.sp,
          color: kWhite,
          fontWeight: FontWeight.w600,
        ),
      );
}
