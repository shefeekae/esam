import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../utils/constants/colors.dart';
import '../../../shared/widgets/textfield/image_with_textfield.dart';

class FeedCard extends StatelessWidget {
  FeedCard({
    super.key,
  });

  final List<SalesData> chartData = [
    SalesData(DateTime(2010), 100),
    SalesData(DateTime(2011), 50),
    SalesData(DateTime(2012), 70),
    SalesData(DateTime(2013), 90),
    SalesData(DateTime(2014), 40),
    SalesData(DateTime(2015), 70),
    // SalesData(DateTime(2010), 35),
  ];

  final List<SalesData> chartData2 = [
    SalesData(DateTime(2010), 80),
    SalesData(DateTime(2011), 60),
    SalesData(DateTime(2012), 70),
    SalesData(DateTime(2013), 65),
    SalesData(DateTime(2014), 20),
    SalesData(DateTime(2015), 90),
    // SalesData(DateTime(2010), 35),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50.sp,
      color: kWhite,
      child: Column(
        children: [
          buildListTile(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: const Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          buildLineChart(),
          SizedBox(
            height: 5.sp,
          ),
          buildButtons(),
          SizedBox(
            height: 5.sp,
          ),
          buildImageWithTextfield(),
          SizedBox(
            height: 10.sp,
          ),
        ],
      ),
    );
  }

  // ===================================================================================================

  SfCartesianChart buildLineChart() {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      series: <ChartSeries>[
        // Renders line chart
        LineSeries<SalesData, DateTime>(
            dataSource: chartData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            markerSettings: const MarkerSettings(
              isVisible: true,
              // Marker shape is set to diamond
              shape: DataMarkerType.circle,
            )),
        LineSeries<SalesData, DateTime>(
            dataSource: chartData2,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            markerSettings: const MarkerSettings(
              isVisible: true,
              // Marker shape is set to diamond
              shape: DataMarkerType.circle,
            ))
      ],
    );
  }

  // ========================================================================================================

  BuildImageWithTextfield buildImageWithTextfield() {
    return const BuildImageWithTextfield(
      eventId: "",
    );
  }

  // ===============================================================================

  Column buildButtons() {
    return Column(
      children: [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildIconWithText(Icons.bookmark_outline, "Save"),
            buildIconWithText(Icons.chat_bubble_outline, "20 Comments"),
            buildIconWithText(Icons.send_outlined, "Share"),
          ],
        ),
        const Divider(),
      ],
    );
  }

  // ==============================================================================

  Row buildIconWithText(IconData icon, String label) {
    return Row(
      children: [
        Icon(
          icon,
          size: 13.sp,
          color: Colors.grey,
        ),
        SizedBox(
          width: 2.sp,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 8.sp,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  //================================================

  ListTile buildListTile() {
    return ListTile(
      leading: CircleAvatar(
        maxRadius: 12.sp,
        backgroundColor: f1White,
        child: Icon(
          Icons.access_alarm,
          color: kBlack,
        ),
      ),
      title: const Text(
        "Titile text",
      ),
      subtitle: Text("1 minutes ago"),
      trailing: PopupMenuButton(
        itemBuilder: (context) {
          return [
            const PopupMenuItem(child: Text("Item 1")),
            const PopupMenuItem(child: Text("Item 1")),
          ];
        },
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
