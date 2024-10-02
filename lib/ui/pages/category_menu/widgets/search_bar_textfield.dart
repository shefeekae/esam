import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/models/category_menu/category_item_model.dart';
import '../../../../utils/constants/colors.dart';

class SearchBarTextfield extends StatelessWidget {
  const SearchBarTextfield({
    required this.categories,
    super.key,
  });

  final List<CategoryItem> categories;

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      dividerColor: Colors.transparent,
      viewElevation: 0,
      builder: (context, controller) {
        return SearchBar(
          controller: controller,
          elevation: const MaterialStatePropertyAll(0),
          hintText: "Search Menu",
          onTap: () {
            controller.openView();
          },
          onChanged: (value) {
            controller.openView();
          },
          hintStyle: MaterialStatePropertyAll(
            TextStyle(
              color: kGrey,
              fontSize: 12.sp,
            ),
          ),
          leading: Icon(
            Icons.search,
            color: kGrey,
          ),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        String searchValue = controller.text.trim();

        var filterdList = categories
            .where((element) =>
                element.name.toLowerCase().contains(searchValue.toLowerCase()))
            .toList();

        return List<ListTile>.generate(filterdList.length, (int index) {
          // final String item = 'item $index';

          var item = filterdList[index];

          return ListTile(
            leading: Icon(item.iconData),
            title: Text(item.name),
            onTap: () {
              Navigator.of(context).pushNamed(item.screenId);
            },
          );
        });
      },
    );
  }
}
