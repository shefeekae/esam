import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';

class DiagnosisRoutineWidget extends StatelessWidget {
  const DiagnosisRoutineWidget({
    super.key,
    required this.checked,
    required this.reasons,
    required this.title,
    required this.isLast,
  });

  final bool? checked;
  final String title;
  final bool isLast;
  final List reasons;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: checked == null ? 0.3 : 1,
      child: Container(
        // padding: EdgeInsets.all(7.sp),
        margin: isLast ? EdgeInsets.zero : EdgeInsets.only(bottom: 5.sp),
        decoration: BoxDecoration(
          color: ThemeServices().getContainerBgColor(context),
        ),
        child: Container(
          padding: EdgeInsets.all(7.sp),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: checked == null
                    ? Colors.yellow.shade700
                    : checked!
                        ? Colors.green
                        : Colors.red,
                width: 3.0,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                checked == null || !checked!
                    ? Icons.cancel_outlined
                    : Icons.check_circle_outline,
                color: checked == null || !checked! ? Colors.red : Colors.green,
              ),
              SizedBox(
                width: 5.sp,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (reasons.isNotEmpty)
                      SizedBox(
                        height: 5.sp,
                      ),
                    ...List.generate(
                      reasons.length,
                      (index) {
                        String data = reasons[index].toString();

                        return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 1.sp,
                            ),
                            child: Text(
                              data,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
