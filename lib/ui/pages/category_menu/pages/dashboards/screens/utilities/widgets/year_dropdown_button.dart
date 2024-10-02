import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class YearDropdownButton extends StatelessWidget {
  const YearDropdownButton({
    super.key,
    required this.yearList,
    required this.onChanged,
    required this.selectedValue,
  });

  final List<int> yearList;
  final void Function(int?)? onChanged;
  final int selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: const SizedBox(),
      borderRadius: BorderRadius.circular(5.sp),
      items: yearList.map((e) {
        String label = e.toString();

        return DropdownMenuItem(
          value: e,
          child: Text(label),
        );
      }).toList(),
      onChanged: onChanged,
      value: selectedValue,
    );
  }
}