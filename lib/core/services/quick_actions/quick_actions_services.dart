import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/alarms_list.dart';
import 'package:quick_actions/quick_actions.dart';
import '../../../ui/pages/scanner/scanner_screen.dart';

class QuickActionsServices {
  QuickActions quickActions = const QuickActions();

  final String alarmsType = "alarms";
  final String barcodeScannerType = "scanner";

 void initAndSetItems(BuildContext context) {
    quickActions.initialize((String shortcutType) {
      if (shortcutType == alarmsType) {
        Navigator.of(context).pushNamed(AlarmsListScreen.id);
      } else if (shortcutType == barcodeScannerType) {
        Navigator.of(context).pushNamed(QrCodeBarCodeScannerScreen.id);
      }
    });

   // calling the setShortcutItems function
    setActionsItems();
  }

  // ============================================================================

 void setActionsItems() {
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
        type: alarmsType,
        localizedTitle: 'Alarms',
        icon: 'alarms',
      ),
      ShortcutItem(
        type: barcodeScannerType,
        localizedTitle: 'Scanner',
        icon: 'scanner',
      ),
    ]);
  }
}
