// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../shared/widgets/container/background_container.dart';

class BuildingDetailsCard extends StatelessWidget {
  const BuildingDetailsCard({
    required this.title,
    required this.list,
    super.key,
  });

  final String title;
  final List<CardData> list;

  @override
  Widget build(BuildContext context) {
    bool valuesEmpty = list.every((element) => element.value == null);

    if (valuesEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      child: BgContainer(
        title: title,
        child: Column(
            children: list.map(
          (e) {
            if (e.showDivider) {
              return const Divider();
            }

            String? value = e.value;

            if (value == null || value.isEmpty) {
              return const SizedBox();
            }

            return ListTile(
              title: Text(
                e.label ?? "",
                style: TextStyle(
                  fontSize: 10.sp,
                ),
              ),
              trailing: ConstrainedBox(
                constraints: BoxConstraints.loose(Size.fromWidth(60.w)),
                child: Text(
                  e.value ?? "N/A",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            );
          },
        ).toList()),
      ),
    );
  }
}

class CardData {
  final String? label;
  final String? value;
  final bool showDivider;

  CardData({
    this.label,
    this.value,
    this.showDivider = false,
  });
}
