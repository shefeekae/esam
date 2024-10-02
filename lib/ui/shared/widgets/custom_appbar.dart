// import 'package:easy_debounce/easy_debounce.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nectar_assets/core/blocs/appbar%20count/appbar_count_bloc.dart';
// import 'package:nectar_assets/core/blocs/filter/payload/payload_management_bloc.dart';
// import 'package:nectar_assets/core/services/alarms_services.dart';
// import 'package:nectar_assets/core/services/platform_services.dart';
// import 'package:nectar_assets/utils/constants/colors.dart';
// import 'package:sizer/sizer.dart';

// // AppBar buildCountWithTitleAppBar({
// //   required String label,
// //   required String value,
// //   required BuildContext context,
// // }) {
// //   return BuildCountWithTitleAppBar();
// // }

// class BuildCountWithTitleAppBar extends StatefulWidget {
//   const BuildCountWithTitleAppBar({
//     super.key,
//     required this.label,
//     this.screenKey = "",
//     this.groupValue = "",
//     this.visibleSearch = true,
//   });

//   final String label;
//   final String screenKey;
//   final String groupValue;
//   final bool visibleSearch;

//   @override
//   State<BuildCountWithTitleAppBar> createState() =>
//       _BuildCountWithTitleAppBarState();
// }

// class _BuildCountWithTitleAppBarState extends State<BuildCountWithTitleAppBar> {
//   bool searchEnabled = false;
//   // String count = "";

//   late PayloadManagementBloc payloadManagementBloc;

//   @override
//   void initState() {
//     // print("${widget.value} initistate");
//     // count = widget.value;
//     payloadManagementBloc = BlocProvider.of<PayloadManagementBloc>(context);

//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isAndroid = PlatformServices().checkPlatformIsAndroid(context);

//     return AppBar(
//       elevation: 0,
//       title: searchEnabled
//           ? CupertinoTextField(
//               placeholder: "Search",
//               autofocus: true,
//               cursorColor: primaryColor,
//               onChanged: (value) {
//                 print(widget.groupValue);
//                 Map<String, dynamic> payload =
//                     payloadManagementBloc.state.payload;
//                 if (widget.screenKey == "alarms") {
//                   EasyDebounce.debounce(
//                     'search_event',
//                     const Duration(milliseconds: 500),
//                     () async {
//                       List<String> names =
//                           await AlarmsServices().getAlarmsSuggetsionList(
//                         searchValue: value,
//                       );

//                       payload['filter']['names'] = names;
//                       payloadManagementBloc.add(
//                         ChangePayloadEvent(payload: payload),
//                       );
//                     },
//                   );

//                   // payloadManagementBloc.add(event)
//                 } else if (widget.screenKey == "documents") {
//                   payload['data']['name'] = value;
//                   payloadManagementBloc.add(
//                     ChangePayloadEvent(payload: payload),
//                   );
//                 } else if (widget.screenKey == "services") {
//                   // if (widget.groupValue == "completed") {
//                   payload['data']['serviceName'] = value;
//                   print(payload);
//                   payloadManagementBloc.add(
//                     ChangePayloadEvent(
//                       payload: payload,
//                     ),
//                   );
//                   // } else {

//                   // }
//                 } else if (widget.screenKey == "parts") {
//                   payload['body']['displayName'] = value;
//                   payloadManagementBloc.add(
//                     ChangePayloadEvent(
//                       payload: payload,
//                     ),
//                   );
//                 }
//               },
//             )
//           : buildTitleWithCountWidget(),
//       actions: [
//         widget.visibleSearch
//             ? IconButton(
//                 onPressed: () {
//                   if (searchEnabled) {
//                     Map<String, dynamic> payload =
//                         payloadManagementBloc.state.payload;

//                     if (widget.screenKey == "alarms") {
//                       payload['filter']['names'] = [];
//                     } else if (widget.screenKey == "documents") {
//                       payload['data']['name'] = "";
//                     } else if (widget.screenKey == "services") {
//                       payload['data']['serviceName'] = "";
//                     } else if (widget.screenKey == "parts") {
//                       payload['body']['displayName'] = "";
//                     }
//                     payloadManagementBloc
//                         .add(ChangePayloadEvent(payload: payload));
//                   }

//                   setState(() {
//                     searchEnabled = !searchEnabled;
//                   });
//                 },
//                 icon: searchEnabled
//                     ? Icon(isAndroid ? Icons.close : CupertinoIcons.clear)
//                     : Icon(
//                         isAndroid ? Icons.search : CupertinoIcons.search,
//                       ),
//               )
//             : SizedBox(),
//       ],
//     );
//   }

//   BlocBuilder<AppbarCountBloc, AppbarCountState> buildTitleWithCountWidget() {
//     return BlocBuilder<AppbarCountBloc, AppbarCountState>(
//       builder: (context, state) {
//         String value = state.count;
//         // .isEmpty ? "" : state.count;

//         return Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               value,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18.sp,
//               ),
//             ),
//             SizedBox(
//               width: 2.1.w,
//             ),
//             Text(
//               widget.label,
//               style: TextStyle(
//                 fontSize: 15.sp,
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
