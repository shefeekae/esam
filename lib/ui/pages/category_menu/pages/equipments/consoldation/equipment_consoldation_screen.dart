import 'package:app_filter_form/app_filter_form.dart';
import 'package:app_filter_form/core/services/filter_helpers.dart';
import 'package:app_filter_form/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/asset/equipment_consoldation_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/consoldation/widgets/equipment_consoldation_card.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../core/services/assets/equipment_consoldation_services.dart';

class EquipmentConsoldationScreen extends StatefulWidget {
  const EquipmentConsoldationScreen({super.key});

  static const String id = 'equipment/consoldation';

  @override
  State<EquipmentConsoldationScreen> createState() =>
      _EquipmentConsoldationScreenState();
}

class _EquipmentConsoldationScreenState
    extends State<EquipmentConsoldationScreen> {
  late FilterAppliedBloc filterAppliedBloc;
  late FilterSelectionBloc filterSelectionBloc;

  Map<String, dynamic> payload = {};
  List<Map> filterValues = [];

  final FilterType filterType = FilterType.equipmentConsoldation;

  final ValueNotifier<Map<String, dynamic>> payloadNotifier =
      ValueNotifier<Map<String, dynamic>>({});

  final ValueNotifier<int> filterCountNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    filterAppliedBloc = BlocProvider.of<FilterAppliedBloc>(context);
    filterSelectionBloc = BlocProvider.of<FilterSelectionBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    filterAppliedBloc.state.filterAppliedCount = 0;
    filterSelectionBloc.state.filterLabelsMap[filterType] = [];
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args?['filterValues'] != null) {
      filterValues = args?['filterValues'];

      for (var element in filterValues) {
        if (element['key'] == "date") {
          payload.addAll(element['identifier']);
          continue;
        }
        payload[element['filterKey']] = element['identifier'];
      }

      // filterAppliedBloc.state.filterAppliedCount = filterValues.length;
      filterCountNotifier.value = filterValues.length;
    }

    payloadNotifier.value = payload;

    return Scaffold(
      appBar: buildAppbar(context),
      body: StatefulBuilder(builder: (context, setState) {
        return ValueListenableBuilder(
          valueListenable: payloadNotifier,
          builder: (context, payload, child) {
            return FutureBuilder(
              future: EquipmentConsoldationServices().getData(
                payload: payload,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return BuildShimmerLoadingWidget(
                    padding: EdgeInsets.all(8.sp),
                    itemCount: 5,
                    height: 50.sp,
                  );
                }

                List<EquipmentConsoldationModel> list =
                    snapshot.data?['list'] ?? [];

                int activeTotalCount = snapshot.data?['activeTotalCount'] ?? 0;

                if (list.isEmpty) {
                  return const Center(
                    child: Text("No Data to show"),
                  );
                }

                return RefreshIndicator.adaptive(
                  onRefresh: () async {
                    setState(
                      () {},
                    );
                  },
                  child: ListView.separated(
                    padding: EdgeInsets.all(8.sp),
                    itemBuilder: (context, index) {
                      EquipmentConsoldationModel data = list[index];

                      return EquipmentConsoldationCard(
                        activeCount: data.activeCount,
                        resolvedCount: data.resolvedCount,
                        name: data.assetName,
                        pecentage: calculatePercentage(
                          data.activeCount.toDouble(),
                          activeTotalCount.toDouble(),
                        ),
                        filterValues: filterValues,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 7.sp,
                    ),
                    itemCount: list.length,
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }

  // ===========================================================================
  double calculatePercentage(double part, double whole) {
    if (whole == 0) {
      return 0; // Avoid division by zero
    }
    return (part / whole) * 100;
  }

  // ===========================================================================
  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text("Equipment consolidation"),
      actions: [
        ValueListenableBuilder(
            valueListenable: filterCountNotifier,
            builder: (context, count, _) {
              return IconButton(
                icon: Builder(builder: (context) {
                  bool filterApplied = count != 0;

                  if (!filterApplied) {
                    return const Icon(
                      Icons.filter_alt_off,
                      // color: Theme.of(context).colorScheme.secondary,
                    );
                  }

                  return Badge.count(
                    count: count,
                    child: Icon(
                      filterApplied ? Icons.filter_alt : Icons.filter_alt_off,
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }),
                onPressed: () {
                  FilterWidgetHelpers().filterBottomSheet(
                    context: context,
                    filterType: filterType,
                    isMobile: true,
                    initialValues: filterValues,
                    saveButtonTap: (value) {
                      payload.addAll(value);

                      filterCountNotifier.value =
                          FilterHelpers().getFilterAppliedCount(
                        filterType: filterType,
                        context: context,
                      );
                      payloadNotifier.value = Map.from(payload);
                    },
                  );
                },
              );
            })
      ],
    );
  }
}
