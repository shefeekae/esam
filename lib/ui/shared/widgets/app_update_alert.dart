import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:upgrader/upgrader.dart';
import '../../../main.dart';

class AppUpdateAlert extends StatelessWidget {
  const AppUpdateAlert({
    this.enabled = true,
    this.notForceUpdate = false,
    required this.child,
    super.key,
  });

  final bool enabled;
  final Widget child;
  final bool notForceUpdate;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return UpgradeAlert(
      navigatorKey: MyApp.navigatorKey,
      dialogStyle: Platform.isIOS
          ? UpgradeDialogStyle.cupertino
          : UpgradeDialogStyle.material,
      showLater: notForceUpdate,
      showIgnore: notForceUpdate,
      showReleaseNotes: true,
      upgrader: Upgrader(
        durationUntilAlertAgain: const Duration(seconds: 1),
        debugLogging: false,
      ),
      child: child,
    );
  }
}
