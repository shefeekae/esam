
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../shared/widgets/container_with_listtile.dart';
import '../../list/documents_list_screen.dart';

class DocumentCategories extends StatelessWidget {
  const DocumentCategories({
    super.key,
    required this.categories,
  });

  final List categories;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
                    Navigator.of(context).pushNamed(DocumentsListScreen.id,arguments: {
                      "title": categories[index],
                    });

          },
          child: ContainerWithListTile(
            title: categories[index],
            titleTextStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            trailing: Text(
              "2",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 7.sp,
        );
      },
    );
  }
}