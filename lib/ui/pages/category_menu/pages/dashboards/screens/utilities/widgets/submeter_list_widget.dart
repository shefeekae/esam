import 'package:flutter/material.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/models/dashboard/submeter_model.dart';
import 'package:nectar_assets/core/models/insights/insights_dropdown_model.dart';
import 'package:nectar_assets/core/schemas/dashboard_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/widgets/served_to_equipments.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/equipment_details.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:nectar_assets/ui/shared/widgets/container_with_text.dart';
import 'package:secure_storage/model/user_data_model.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SubMeterListWidget extends StatelessWidget {
  SubMeterListWidget({
    super.key,
    required this.level,
    required this.dropDownValueNotifier,
  });

  final Level level;
  final ValueNotifier<CommunityHierarchyDropdownData?> dropDownValueNotifier;

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: level == Level.site,
        child: QueryWidget(
            options: GraphqlServices().getQueryOptions(
                query: DashboardSchema.getSubMetersList,
                variables: {
                  "site": dropDownValueNotifier.value?.entity,
                },
                rereadPolicy: true),
            builder: (result, {fetchMore, refetch}) {
              var data = result.data ?? {};

              if (result.isLoading) {
                return Skeletonizer(child: buildLayout([]));
              }

              SubMeterModel subMeterModel = SubMeterModel.fromJson(data);

              List<GetSubMetersList> subMeterList =
                  subMeterModel.getSubMetersList ?? [];

              return buildLayout(subMeterList);
            }));
  }

  Widget buildLayout(List<GetSubMetersList> subMeterList) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: SizedBox(
        child: BgContainer(
            height: 250.sp,
            title: "Sub Meters",
            child: Flexible(
              child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 4.sp),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    List<Child> childList =
                        subMeterList[index].grandchildren ?? [];

                    childList = childList.where((element) {
                      return element.data != null;
                    }).toList();

                    String title =
                        subMeterList[index].child?.data?.displayName ?? " ";

                    return Padding(
                      padding: EdgeInsets.all(4.sp),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.sp),
                        child: ExpansionTile(
                          collapsedBackgroundColor:
                              ThemeServices().getContainerBgColor(context),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title),
                              ContainerWithTextWidget(
                                  value: "${childList.length} Equipments"),
                            ],
                          ),
                          children: List.generate(childList.length, (index) {
                            String identifier =
                                childList[index].identifier ?? "";

                            String displayName =
                                childList[index].data?.displayName ?? "";
                            String name = childList[index].data?.name ?? "N/A";

                            String title =
                                displayName.isEmpty ? name : displayName;

                            // String domain = childList[index].data?.domain ?? "";

                            String type = childList[index].type ?? "";

                            if (childList.isEmpty) {
                              return const Text("No Equipments");
                            }

                            return Container(
                              decoration: BoxDecoration(
                                  color: ThemeServices()
                                      .getContainerBgColor(context)),
                              child: ListTile(
                                title: Text(title),
                                trailing: SizedBox(
                                  width: 80.sp,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 20.sp,
                                        width: 20.sp,
                                        decoration: BoxDecoration(
                                            color: ThemeServices()
                                                .getBgColor(context),
                                            borderRadius:
                                                BorderRadius.circular(5.sp)),
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  ServedToEquipmentsScreen(
                                                      name: title,
                                                      identifier: identifier),
                                            ));
                                          },
                                          icon: Icon(
                                            Icons.cable_rounded,
                                            size: 8.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Container(
                                        height: 20.sp,
                                        width: 20.sp,
                                        decoration: BoxDecoration(
                                            color: ThemeServices()
                                                .getBgColor(context),
                                            borderRadius:
                                                BorderRadius.circular(5.sp)),
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                EquipmentDetailsScreen.id,
                                                arguments: {
                                                  "type": type,
                                                  "identifier": identifier,
                                                  "displayName": title,
                                                  "domain": userData.domain,
                                                });
                                          },
                                          icon: Icon(
                                            Icons.speed,
                                            size: 8.sp,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(),
                  itemCount: subMeterList.length),
            )),
      ),
    );
  }
}
