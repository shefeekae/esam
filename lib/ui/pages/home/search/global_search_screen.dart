import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/shared/widgets/container_with_text.dart';
import 'package:nectar_assets/ui/shared/widgets/custom_searchfield.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../shared/widgets/circle_avatar_with_icon.dart';

class GloabalSearchScreen extends StatelessWidget {
  GloabalSearchScreen({super.key});

  static const String id = '/globalsearch';

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BuildCustomSearchField(
          controller: searchController,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(7.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Searches",
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return buildCard(context: context);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 8.sp,
                  );
                },
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

// ==================================================================

  Widget buildCard({required BuildContext context}) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ThemeServices().getBgColor(context),
      ),
      child: Row(
        children: [
          const CircleAvatarWithIcon(
            iconData: Icons.construction,
          ),
          SizedBox(
            width: 10.sp,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Equipment name"),
              SizedBox(
                height: 2.sp,
              ),
              ContainerWithTextWidget(
                // bgColor: f1White,
                value: "Equipment",
                fgColor: kBlack,
                borderRadius: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}
