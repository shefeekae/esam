import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/widgets/add_operator_widget.dart';
import 'package:sizer/sizer.dart';


class AddOperatorScreen extends StatelessWidget {
  const AddOperatorScreen({super.key, required this.ownerClientId, required this.identifier});

  final String ownerClientId;
  final String identifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Operator"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: AddOperatorWidget(
          ownerClientId: ownerClientId,
          identifier: identifier,
        ),
      ),
    );
  }
}
