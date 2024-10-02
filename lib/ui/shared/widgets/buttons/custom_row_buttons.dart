import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/models/custom_row_button_model.dart';

class CustomRowButtons extends StatelessWidget {
  const CustomRowButtons({
    super.key,
    required this.valueListenable,
    required this.onChanged,
    required this.items,
    this.horizontalPadding,
  });

  final ValueListenable valueListenable;
  final List<CustomButtonModel> items;
  final void Function(Enum itemKey) onChanged;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      decoration: BoxDecoration(
        color: ThemeServices().getBgColor(context),
        borderRadius: BorderRadius.circular(50),
      ),
      child: ValueListenableBuilder(
        valueListenable: valueListenable,
        builder: (context, value, _) => Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
            (index) {
              CustomButtonModel model = items[index];
              Enum itemKey = model.itemKey;

              bool selected = itemKey == value;
              String title = model.title;

              return GestureDetector(
                onTap: () {
                  onChanged(itemKey);
                },
                child: buildToggleContainer(
                  context,
                  selected: selected,
                  title: title,
                  horizontal: horizontalPadding,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

// ===============================================================================

  Widget buildToggleContainer(
    BuildContext context, {
    required bool selected,
    required String title,
    double? horizontal,
  }) {
    Color? color = selected ? ThemeServices().getPrimaryFgColor(context) : null;

    return Builder(
      builder: (context) => Container(
        margin: const EdgeInsets.all(1.5),
        padding: EdgeInsets.symmetric(
            horizontal: horizontal ?? 20.sp, vertical: 5.sp),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColor : null,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 10.sp,
            color: color,
          ),
        ),
      ),
    );
  }
}
