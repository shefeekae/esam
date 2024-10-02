import 'package:app_filter_form/app_filter_form.dart';
import 'package:app_filter_form/shared/functions/update_map_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/assets/assets_services.dart';
import 'package:nectar_assets/core/services/assets/assets_status_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/shared/widgets/custom_snackbar.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:sizer/sizer.dart';
// import 'package:skeletonizer/skeletonizer.dart';

class EquipmentsStatusCard extends StatefulWidget {
  const EquipmentsStatusCard({
    required this.onChanged,
    super.key,
  });

  final Function(Map<dynamic,dynamic> initialValue) onChanged;

  @override
  State<EquipmentsStatusCard> createState() => _EquipmentsStatusCardState();
}

class _EquipmentsStatusCardState extends State<EquipmentsStatusCard> {
  late PayloadManagementBloc payloadManagementBloc;
  late FilterAppliedBloc filterAppliedBloc;

  @override
  void initState() {
    payloadManagementBloc = BlocProvider.of<PayloadManagementBloc>(context);
    filterAppliedBloc = BlocProvider.of<FilterAppliedBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.sp,
      child: BlocBuilder<PayloadManagementBloc, PayloadManagementState>(
        builder: (context, state) {
          Map<String, dynamic> payload = {
            "timeFilter":
                AssetsStatusServices().getAssetListCountTimeFilterPayload(),
          };

          payload.addAll(state.payload);

          payload = updateTemplateKeys(
            variables: payload,
            templateKey: "clients",
            filterKey: "clientDomain",
          );

          // print("status card payload: $payload");

          return QueryWidget(
              options: GraphqlServices().getQueryOptions(
                query: AssetSchema.getAssetListCount,
                rereadPolicy: true,
                variables: {
                  "filter": payload,
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

                if (result.isLoading) {
                  return ListView.separated(
                    padding: EdgeInsets.only(
                      left: 5.sp,
                      right: 5.sp,
                      bottom: 5.sp,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ShimmerLoadingContainerWidget(
                        width: 80.sp,
                        borderRadius: 5,
                        // height: 60.sp,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 5.sp,
                      );
                    },
                    itemCount: 4,
                  );
                }

                Map<String, dynamic>? data =
                    result.data?['getAssetListCount']?["result"];

                Color primaryFgColor =
                    ThemeServices().getPrimaryFgColor(context);

                List<Map<String, dynamic>> statusListData =
                    AssetsStatusServices()
                        .getStatusListData(context, data: data);

                return ListView.separated(
                  padding: EdgeInsets.only(
                    left: 5.sp,
                    right: 5.sp,
                    bottom: 5.sp,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Map<String, dynamic>? map = statusListData[index];

                    String title = map['title'] ?? "";
                    int count = map['count'] ?? 0;

                    List<Color> colors = map['colors'];

                    Color? textColor = map['textColor'];

                    return Bounce(
                      duration: const Duration(milliseconds: 100),
                      onPressed: () {
                        String key = map['key'] ?? "";

                        Map<String, dynamic> payload =
                            payloadManagementBloc.state.payload;

                        int filterAppliedCount =
                            filterAppliedBloc.state.filterAppliedCount;

                        bool statusApplied =
                            payload.containsKey("communicatingTimes") ||
                                payload.containsKey("underMaintainenceFlg");

                        if (!statusApplied) {
                          filterAppliedBloc.add(UpdateFilterAppliedCount(
                              count: filterAppliedCount + 1));
                        }

                        if (key == "MAINTENANCE") {
                          payload.remove("communicatingTimes");
                          payload['underMaintainenceFlg'] = true;
                        } else {
                          payload.remove("underMaintainenceFlg");
                          payload['communicatingTimes'] =
                              AssetsServices().getCommunicationStartDateEndDate(
                            communicationStatus: key,
                          );
                        }

                        payloadManagementBloc
                            .add(ChangePayloadEvent(payload: payload));
                        widget.onChanged(
                          {
                            "key":  "communicationStatus",
                            "identifier": key,
                            "values" : [
                              {
                                "name": title,
                                "data": key,
                              }
                            ],
                          }
                        );
                        buildSnackBar(
                          context: context,
                          value: "Communication Status $title Applied",
                        );
                      },
                      child: Container(
                        width: 80.sp,
                        decoration: BoxDecoration(
                          color: colors.first,
                          borderRadius: BorderRadius.circular(5),
                          gradient: colors.length == 1
                              ? null
                              : LinearGradient(
                                  colors: colors,
                                  // begin: Alignment.centerLeft,
                                  // end: Alignment.center,
                                ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: textColor ?? primaryFgColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                AssetsStatusServices().convertToK(count),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: textColor ?? primaryFgColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 5.sp,
                    );
                  },
                  itemCount: statusListData.length,
                );
              });
        },
      ),
    );
  }
}
