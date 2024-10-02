import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/custom_row_button_model.dart';
import 'package:nectar_assets/core/models/service_logs_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/services/list/enum/services_row_buttons_enum.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_row_buttons.dart';
import 'package:sizer/sizer.dart';
import 'widgets/services_card.dart';

class ServicesListScreen extends StatelessWidget {
  ServicesListScreen({super.key});

  static const String id = '/services/list';

  final ValueNotifier<ServicesState> valueNotifier =
      ValueNotifier<ServicesState>(ServicesState.upComing);

  Map map = {
    ServicesState.upComing: [
      {
        "status": "REGISTERED",
        "date": "3 Dec 2023 10:00 AM",
        "title": "300 run hour engine oil Change",
        "asset": "S A! Water Meter 01",
        "assetType": "Water Meter",
        // "jobId": 23045,
        "actRunhours": 3000.0,
        "expRunhours": 40000.0,
      },
      {
        "status": "REGISTERED",
        "date": "3 Dec 2023 10:00 AM",
        "title": "300 run hour engine oil Change",
        "asset": "S A! Water Meter 01",
        "assetType": "Water Meter",
        "jobId": 23045,
        "actOdoMeter": 4000.0,
        "expOdoMeter": 30000.0,
      },
    ],
    ServicesState.completed: [
      {
        "status": "COMPLETED",
        "date": "3 Dec 2023 10:00 AM",
        "title": "300 run hour engine oil Change",
        "asset": "S A! Water Meter 01",
        "assetType": "Water Meter",
        "jobId": 23045,
        "servicedRunhours": 3000.0,
        "servicedOdometer": 40000.0,
      },
      {
        "status": "CANCELLED",
        "date": "3 Dec 2023 10:00 AM",
        "title": "300 run hour engine oil Change",
        "asset": "S A! Water Meter 01",
        "assetType": "Water Meter",
      },
    ],
    ServicesState.unAttended: [
      {
        "status": "DUE",
        "date": "3 Dec 2023 10:00 AM",
        "title": "300 run hour engine oil Change",
        "asset": "S A! Water Meter 01",
        "assetType": "Water Meter",
        "jobId": 23045,
        // "servicedRunhours": 3000.0,
        // "servicedOdometer": 40000.0,
      },
      {
        "status": "OVERDUE",
        "date": "3 Dec 2023 10:00 AM",
        "title": "300 run hour engine oil Change",
        "asset": "S A! Water Meter 01",
        "assetType": "Water Meter",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          Center(
            child: rowButtons(),
          ),
          Expanded(
            child: RefreshIndicator.adaptive(
              onRefresh: () async {},
              child: ValueListenableBuilder(
                valueListenable: valueNotifier,
                builder: (context, value, _) {
                  List list = map[value] ?? [];

                  return ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    // padding: EdgeInsets.all(10.sp),
                    itemBuilder: (context, index) {
                      return ServicesCard(
                        map: list[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10.sp,
                      );
                    },
                    itemCount: list.length,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================================

  CustomRowButtons rowButtons() {
    return CustomRowButtons(
      horizontalPadding: 15.sp,
      valueListenable: valueNotifier,
      items: [
        CustomButtonModel(
          title: "Upcoming",
          itemKey: ServicesState.upComing,
        ),
        CustomButtonModel(
          title: "Completed",
          itemKey: ServicesState.completed,
        ),
        CustomButtonModel(
          title: "Unattended",
          itemKey: ServicesState.unAttended,
        ),
      ],
      onChanged: (itemKey) {
        valueNotifier.value = itemKey as ServicesState;
      },
    );
  }

  // ==============================================================================

  AppBar appBar() {
    return AppBar(
      title: const Text("Services"),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined)),
      ],
    );
  }
}
