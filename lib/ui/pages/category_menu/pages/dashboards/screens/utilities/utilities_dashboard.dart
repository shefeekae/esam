import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/model/compare_year_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/widgets/bar_chart_list.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/widgets/compare_year_widget.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/widgets/status_card.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/widgets/submeter_list_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/dropdown/level_dropdown_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:nectar_assets/core/models/insights/insights_dropdown_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/widgets/electricity_consumption_space_distribution_widget.dart';

class UtilitiesDashboard extends StatefulWidget {
  const UtilitiesDashboard({
    super.key,
    this.dropDownData,
    required this.level,
    this.communityDomain,
    this.parentEntity,
  });

  final CommunityHierarchyDropdownData? dropDownData;
  final Level level;
  final String? communityDomain;
  final Map<String, dynamic>? parentEntity;

  @override
  State<UtilitiesDashboard> createState() => _UtilitiesDashboardState();
}

class _UtilitiesDashboardState extends State<UtilitiesDashboard> {
  late ValueNotifier<CommunityHierarchyDropdownData?> dropDownValueNotifier;

  // int yearValue = 2023;
  // int compareYearValue = 2018;

  final UserDataSingleton userData = UserDataSingleton();

  late ValueNotifier<CompareYearModel> compareYearValueNotifier;

  @override
  void initState() {
    // yearDropdownItem = y

    final DateTime now = DateTime.now();

    compareYearValueNotifier = ValueNotifier(
      CompareYearModel(
        year: now.year,
        compareYear: now.year - 1,
      ),
    );

    dropDownValueNotifier = ValueNotifier(widget.dropDownData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PermissionChecking(
          featureGroup: "dashboard",
          feature: "utilities",
          permission: "view",
          child: LevelDropdownWidget(
           currentYear: compareYearValueNotifier.value.year.toString(),
            previousYear: compareYearValueNotifier.value.compareYear.toString(),
            level: widget.level,
            communityDomain: widget.communityDomain,
            parentEntity: widget.parentEntity,
            dropDownValueNotifier: dropDownValueNotifier,
            title: 'Utilities Dashboard',
          ),
        ),
      ),
      body: PermissionChecking(
        featureGroup: "dashboard",
        feature: "utilities",
        permission: "view",
        showNoAccessWidget: true,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: Builder(builder: (context) {
                return CompareYearDropdownWidget(
                  compareYearValueNotifier: compareYearValueNotifier,
                );
              }),
            ),
            ValueListenableBuilder(
                valueListenable: compareYearValueNotifier,
                builder: (context, value, child) {
                  int yearValue = value.year;
                  int compareYearValue = value.compareYear;

                  return ValueListenableBuilder(
                      valueListenable: dropDownValueNotifier,
                      builder: (context, value, child) {
                        return UtilitiesStatusCard(
                          currentYear: yearValue,
                          previousYear: compareYearValue,
                          entity: dropDownValueNotifier.value?.entity ,
                          level: widget.level,
                        );
                      });
                }),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: dropDownValueNotifier,
                  builder: (context, value, _) {
                    return ValueListenableBuilder(
                        valueListenable: compareYearValueNotifier,
                        builder: (context, value, _) {
                          int yearValue = value.year;
                          int compareYearValue = value.compareYear;
                          return ListView(
                            padding: EdgeInsets.symmetric(horizontal: 8.sp),
                            children: [
                              Visibility(
                                visible: widget.level != Level.subMeter,
                                child:
                                    ElectricityConsumptionSpaceDistributionWidget(
                                  yearValue: yearValue,
                                  compareYearValue: compareYearValue,
                                  identifier:
                                      dropDownValueNotifier.value?.identifier,
                                  level: widget.level,
                                  entity: dropDownValueNotifier.value?.entity,
                                ),
                              ),
                              SubMeterListWidget(
                                  level: widget.level,
                                  dropDownValueNotifier: dropDownValueNotifier),
                              BarChartList(
                                yearValue: yearValue,
                                compareYearValue: compareYearValue,
                               
                                level: widget.level,
                                entity: dropDownValueNotifier.value?.entity,
                              )
                            ],
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
