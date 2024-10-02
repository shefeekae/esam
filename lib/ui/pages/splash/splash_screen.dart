import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/pages/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:nectar_assets/ui/pages/splash/widgets/splash_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String id = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    handlingInitState();

    // TODO: implement initState
    super.initState();
  }

  handlingInitState() async {
    bool rememberMe = await StorageServices().getRememberMe();

    String id = rememberMe ? BottomNavBarScreen.id : LoginScreen.id;

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashWidget();
  }
}
