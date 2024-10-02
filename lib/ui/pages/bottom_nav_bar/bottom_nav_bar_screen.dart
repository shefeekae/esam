import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/quick_actions/quick_actions_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/category_menu_screen.dart';
// import 'package:nectar_assets/ui/pages/category_menu/category_menu_screen.dart';
// import 'package:nectar_assets/ui/pages/home/home_screen.dart';
// import 'package:nectar_assets/ui/pages/notifications/notifications_screen.dart';
import 'package:nectar_assets/ui/pages/profile/profile_screen.dart';
import 'package:nectar_assets/ui/shared/widgets/app_update_alert.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  static const String id = '/bottom_nav_bar';

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int selectedIndex = 0;

  List<Widget> screens = [
    // HomeScreen(),
    CategoryMenuScreen(),
    const ProfileScreen(),
    // NotificationsScreen(),
    //  CategoryMenuScreen(),
  ];

  @override
  void initState() {
    QuickActionsServices().initAndSetItems(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppUpdateAlert(
      enabled: true,
      child: Scaffold(
        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          showSelectedLabels: false,

          // selectedLabelStyle: TextStyle(
          //   fontSize: 8.sp,
          // ),
          // unselectedLabelStyle: TextStyle(
          //   fontSize: 8.sp,
          //   color: Colors.grey,
          // ),
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const <BottomNavigationBarItem>[
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.home_filled),
            //   label: "Home",
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "Menu",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.notifications),
            //   label: "Notifications",
            // ),
          ],
        ),
      ),
    );
  }
}
