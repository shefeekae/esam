import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/equipment_details.dart';
import 'package:scanner/ui/screens/scanner/scanner_screen.dart';

class QrCodeBarCodeScannerScreen extends StatelessWidget {
  const QrCodeBarCodeScannerScreen({super.key});

  static const String id = '/qrcode_barcode/scanner';

  @override
  Widget build(BuildContext context) {
    return ScannerScreen(
      navigateToAssetDetails: (data) async {
        await Navigator.of(context).pushNamed(
          EquipmentDetailsScreen.id,
          arguments: {
            "type": data.type,
            "identifier": data.identifier,
            "domain": data.domain,
            "displayName": data.displayName,
          },
        );
      },
    );
  }
}
