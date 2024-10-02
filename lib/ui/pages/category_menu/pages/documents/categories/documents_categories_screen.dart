import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'widgets/document_categories.dart';
import 'widgets/document_expiring_category_card.dart';

class DocumentCategoriesScreen extends StatelessWidget {
  DocumentCategoriesScreen({super.key});

  static const String id = '/documents/categories';

  final List expiringCategories = [
    {
      "title": "Expired",
      "icon": Icons.cancel_outlined,
      "color": Colors.red,
    },
    {
      "title": "Expiring Today",
      "icon": Icons.event,
      "color": Colors.amber,
    },
    {
      "title": "Never Expiring",
      "icon": Icons.all_inclusive,
      "color": Colors.blue,
    },
    {
      "title": "Not Expired",
      "icon": Icons.check_circle_outline,
      "color": Colors.green,
    },
  ];

  final List categories = [
    "All",
    "Driving License",
    "Insurance",
    "Bills",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: ListView(
          shrinkWrap: true,
          children: [
            buildExpireCategories(),
            SizedBox(
              height: 15.sp,
            ),
            Text(
              "Categories",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            DocumentCategories(categories: categories),
          ],
        ),
      ),
    );
  }

  // ===========================================================

  Widget buildExpireCategories() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 4,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.sp,
        crossAxisSpacing: 10.sp,
        childAspectRatio: 10 / 6,
      ),
      itemBuilder: (context, index) {
        var map = expiringCategories[index];

        return DocumentExpiringCategoryCard(
          title: map['title'],
          iconData: map['icon'],
          value: "20",
          iconColor: map['color'],
        );
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Documents"),
    );
  }
}


