import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/services/details/service_detalis_scree.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../shared/widgets/container_with_text.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({
    super.key,
    required this.map,
  });

  final Map map;

  @override
  Widget build(BuildContext context) {
    String status = map['status'] ?? "n";
    String date = map['date'];
    // String asset = map['asset'];
    // String assetType = map['assetType'];
    // int? jobId = map['jobId'];
    double? actRunHours = map['actRunhours'];
    double? expRunHours = map['expRunhours'];
    double? actOdometer = map['actOdoMeter'];
    double? expOdometer = map['expOdoMeter'];

    return Bounce(
      duration: const Duration(milliseconds: 100),
      onPressed: () {
        Navigator.of(context).pushNamed(ServiceDetailsScreen.id);
      },
      child: Container(
        color: ThemeServices().getBgColor(context),
        padding: EdgeInsets.all(8.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            statusAndDateRow(
              status: status,
              date: date,
            ),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              map['title'],
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.sp,
            ),
            assetAndAssetTypeRow(),
            SizedBox(
              height: 5.sp,
            ),
            Row(
              children: [
                const Expanded(child: Text("Building Demo")),
                jobIdWidget(context)
              ],
            ),
            SizedBox(
              height: 5.sp,
            ),
            Builder(builder: (context) {
              if (status == "COMPLETED" ||
                  status == "DUE" ||
                  status == "OVERDUE") {
                String runhoursTitle =
                    status == "COMPLETED" ? "Serviced Runhours" : "Runhours";
                String odoMeterTitle =
                    status == "COMPLETED" ? "Serviced Odometer" : "Odometer";

                return Padding(
                  padding: EdgeInsets.only(top: 3.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      runHoursOdoMeterValueAndLabel(
                        title: runhoursTitle,
                        value: "2500",
                      ),
                      runHoursOdoMeterValueAndLabel(
                        title: odoMeterTitle,
                        value: "3000",
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  odoMeterRunHoursValuesRow(
                    leadingTitle: "Actual Run Hours",
                    leadingValue: actRunHours,
                    trailingTitle: "Expected Run Hours",
                    trailingValue: expRunHours,
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  odoMeterRunHoursValuesRow(
                    leadingTitle: "Actual Odometer",
                    leadingValue: actOdometer,
                    trailingTitle: "Expected Odometer",
                    trailingValue: expOdometer,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  // =======================================================================================

  Widget odoMeterRunHoursValuesRow({
    required String leadingTitle,
    required double? leadingValue,
    required String trailingTitle,
    required double? trailingValue,
  }) {
    if (leadingValue == null || trailingValue == null) {
      return const SizedBox();
    }

    double value = leadingValue - trailingValue;

    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

    String actualValue = leadingValue.toString().replaceAll(regex, '');
    String expectedValue = trailingValue.toString().replaceAll(regex, '');
    String comparedValue = value.abs().toString().replaceAll(regex, '');

    return Row(
      children: [
        runHoursOdoMeterValueAndLabel(
          title: leadingTitle,
          value: actualValue,
        ),
        SizedBox(
          width: 3.sp,
        ),
        const Expanded(child: Divider()),
        SizedBox(
          width: 3.sp,
        ),
        ConstrainedBox(
          constraints: BoxConstraints.loose(Size.fromWidth(50.sp)),
          child: Text(
            comparedValue,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: value.isNegative ? Colors.green : Colors.red,
            ),
          ),
        ),
        SizedBox(
          width: 3.sp,
        ),
        const Expanded(child: Divider()),
        SizedBox(
          width: 3.sp,
        ),
        runHoursOdoMeterValueAndLabel(
          title: trailingTitle,
          value: expectedValue,
        ),
      ],
    );
  }

  // ================================================================================

  Row runHoursOdoMeterValueAndLabel({
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Text(
          "$title: ",
          style: TextStyle(fontSize: 8.sp),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.loose(Size.fromWidth(30.sp)),
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8.sp,
            ),
          ),
        ),
      ],
    );
  }

  Row assetAndAssetTypeRow() {
    return Row(
      children: [
        Expanded(
          child: Text(map['asset']),
        ),
        ContainerWithTextWidget(
          value: map['assetType'],
          fgColor: kWhite,
          borderRadius: 5,
          padding: EdgeInsets.all(5.sp),
        )
      ],
    );
  }

  Row statusAndDateRow({
    required String status,
    required String date,
  }) {
    Color color = Colors.blue;

    switch (status) {
      case "CANCELLED":
        color = Colors.red;
        break;
      case "COMPLETED":
        color = Colors.green;
        break;
      default:
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ContainerWithTextWidget(
          value: status,
          fontSize: 8.sp,
          bgColor: color,
          fgColor: kWhite,
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 3.sp),
        ),
        Text(
          date,
          style: TextStyle(
            fontSize: 8.sp,
            color: kGrey,
          ),
        )
      ],
    );
  }

  // ===========================================================================================

  Widget jobIdWidget(BuildContext context) {
    int? jobId = map['jobId'];

    if (jobId == null) {
      return SizedBox();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 5.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(
            Icons.checklist,
            size: 10.sp,
            color: kWhite,
          ),
          SizedBox(
            width: 5.sp,
          ),
          Text(
            jobId.toString(),
            style: TextStyle(
              fontSize: 7.sp,
              color: kWhite,
            ),
          ),
        ],
      ),
    );
  }
}
