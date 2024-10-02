// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nectar_assets/core/blocs/filter/filter%20applied/filter_applied_bloc.dart';
// import 'package:nectar_assets/core/blocs/filter/filter_selection/filter_selection_bloc.dart';
// import 'package:nectar_assets/core/models/filter_model.dart';
// import 'package:nectar_assets/ui/shared/widgets/custom_appbar.dart';
// import 'package:nectar_assets/ui/shared/widgets/filter/custom_filter_widget.dart';

// import '../../../core/models/filter/filter_applied_model.dart';

// class AppBarWithFilter extends StatefulWidget {
//   const AppBarWithFilter({
//     required this.filterList,
//     required this.label,
//     required this.value,
//     super.key,
//   });

//   final String label;
//   final String value;
//   final List<String> filterList;

//   @override
//   State<AppBarWithFilter> createState() => _AppBarWithFilterState();
// }

// class _AppBarWithFilterState extends State<AppBarWithFilter> {
//   late FilterSelectionBloc filterSelectionBloc;
//   late FilterAppliedBloc filterAppliedBloc;

//   @override
//   void initState() {
//     filterAppliedBloc = BlocProvider.of<FilterAppliedBloc>(context);
//     filterSelectionBloc = BlocProvider.of<FilterSelectionBloc>(context);

//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<FilterModel> filterList = widget.filterList
//         .map(
//           (e) => FilterModel(
//             label: e,
//             type: "multiselect",
//             key: e.toLowerCase(),
//             apiCallNeeded: false,
//           ),
//         )
//         .toList();

//     filterSelectionBloc.state.filterValues = List.generate(
//       widget.filterList.length,
//       (index) {
//         String key = filterList[index].key;

//         // String title = filterList[index].label;
//         // String type = filterList[index].type;
//         // if (key == "status") {
//         //   print("Status");

//         //   print(widget.filterList[index].options);
//         //   print(widget.filterList[index].type);

//         //   return FilterValue(
//         //     key: key,
//         //     selectedValues: [
//         //       SelectedValue(
//         //         name: "Active",
//         //         identifier: "active",
//         //         aliasName: "active_resolved",
//         //       )
//         //     ],
//         //   );
//         // }

//         return FilterValue(
//           key: key,
//           selectedValues: [],
//         );
//       },
//     );

//     filterAppliedBloc.state.filterAppliedList = List.generate(
//       widget.filterList.length,
//       (index) {
//         String key = filterList[index].key;

//         // String title = filterList[index].label;
//         // String type = filterList[index].type;
//         // if (key == "status") {
//         //   print("Status");

//         //   print(widget.filterList[index].options);
//         //   print(widget.filterList[index].type);

//         //   return FilterAppliedModel(
//         //     key: key,
//         //     selectedValues: [
//         //       SelectedValue(
//         //         name: "Active",
//         //         identifier: "active",
//         //         aliasName: "active_resolved",
//         //       )
//         //     ],
//         //   );
//         // }

//         return FilterAppliedModel(
//           key: key,
//           selectedValues: [],
//         );
//       },
//     );

//     return Column(
//       children: [
//         BuildCountWithTitleAppBar(
//           label: widget.label,
//           value: widget.value,
//         ),
//         BuildCommonFiltersWidget(
//           filterList: filterList,
//         ),
//       ],
//     );
//   }
// }
