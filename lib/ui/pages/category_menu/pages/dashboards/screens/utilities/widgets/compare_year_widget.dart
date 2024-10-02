
import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/model/compare_year_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/widgets/year_dropdown_button.dart';
import 'package:sizer/sizer.dart';

class CompareYearDropdownWidget extends StatelessWidget {
  const CompareYearDropdownWidget({
    super.key,
    required this.compareYearValueNotifier,
  });

  final ValueNotifier<CompareYearModel> compareYearValueNotifier;

  List<int> getYearList({
    required bool compareYear,
  }) {
    int applicationStartYear = DateTime(2018).year;

    int currentYear = DateTime.now().year;

    int value = currentYear - applicationStartYear;

    List<int> yearList = [];

    if (compareYear) {
      for (int i = 0; i < value; i++) {
        yearList.add(applicationStartYear + i);
      }
      return yearList;
    }

    for (int i = 1; i <= value; i++) {
      yearList.add(applicationStartYear + i);
    }
    return yearList;
  }

  @override
  Widget build(BuildContext context) {
    List<int> yearList = getYearList(compareYear: false);

    List<int> compareYearList = getYearList(compareYear: true);

    return ValueListenableBuilder(
        valueListenable: compareYearValueNotifier,
        builder: (context, value, _) {
          int year = value.year;
          int compareYear = value.compareYear;

          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              YearDropdownButton(
                yearList: yearList,
                onChanged: (value) {
                  compareYearValueNotifier.value = CompareYearModel(
                    year: value!,
                    compareYear: value <= compareYear ? value - 1 : compareYear,
                  );
                },
                selectedValue: year,
              ),
              SizedBox(
                width: 4.sp,
              ),
              const Text("To"),
              SizedBox(
                width: 8.sp,
              ),
              YearDropdownButton(
                yearList: compareYearList,
                onChanged: (value) {
                  compareYearValueNotifier.value = CompareYearModel(
                    year: value! >= year ? value + 1 : year,
                    compareYear: value,
                  );
                },
                selectedValue: compareYear,
              ),
            ],
          );
        });
  }
}


