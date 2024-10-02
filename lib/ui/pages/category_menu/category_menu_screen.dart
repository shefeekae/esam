import 'package:firebase_config/services/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/models/category_menu/category_item_model.dart';
import 'package:nectar_assets/core/models/communities/community_hierarchy_args_model.dart';
import 'package:nectar_assets/core/services/permissions/user_permission_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/communites_insights_screen.dart';
import 'package:sizer/sizer.dart';
import '../../shared/widgets/permission/permission_checking_widget.dart';
import '../scanner/scanner_screen.dart';
import 'widgets/search_bar_textfield.dart';

class CategoryMenuScreen extends StatefulWidget {
  CategoryMenuScreen({super.key});

  static const String id = '/category/menu';

  @override
  State<CategoryMenuScreen> createState() => _CategoryMenuScreenState();
}

class _CategoryMenuScreenState extends State<CategoryMenuScreen> {
  final TextEditingController controller = TextEditingController();

  final List<CategoryItem> permissionsAppliedMenuList =
      UserPermissionServices().getPermissionCategoriesMenuList();

  @override
  void initState() {
    FirebaseMessagingServices().firebaseMessaging.requestPermission();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buidSearchBar(context),
      body: GridView.builder(
        itemCount: permissionsAppliedMenuList.length,
        padding: EdgeInsets.all(10.sp),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 7.sp,
          mainAxisSpacing: 7.sp,
          childAspectRatio: 0.6.sp,
        ),
        itemBuilder: (context, index) {
          CategoryItem item = permissionsAppliedMenuList[index];

          return Bounce(
            duration: const Duration(milliseconds: 100),
            onPressed: () {
              if (item.screenId == CommunityHierarchyScreen.id) {
                Navigator.of(context).pushNamed(item.screenId,
                    arguments: CommunityHierarchyArgs(
                      insights: Insights.community,
                    ));
              } else {
                Navigator.of(context).pushNamed(
                  item.screenId,
                );
              }
            },
            child: buildCategoryCard(item),
          );
        },
      ),
    );
  }

  // ==========================================================================================================================
  Widget buildCategoryCard(CategoryItem item) {
    return Builder(
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            color: ThemeServices().getBgColor(context),
            borderRadius: BorderRadius.circular(5.sp),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 35.sp,
                child: Text(
                  item.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              Center(
                child: Icon(
                  item.iconData,
                  size: 30.sp,
                  // color: kBlack,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ======================================================================================
  AppBar buidSearchBar(BuildContext context) {
    return AppBar(
      title: SizedBox(
        height: 30.sp,
        child: SearchBarTextfield(
          categories: permissionsAppliedMenuList,
        ),
      ),
      actions: [
        PermissionChecking(
          featureGroup: "assetManagement",
          feature: "dashboard",
          permission: "view",
          child: Padding(
            padding: EdgeInsets.only(right: 10.sp),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QrCodeBarCodeScannerScreen(),
                ));
              },
              icon: const Icon(
                Icons.qr_code_scanner,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
