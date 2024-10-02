import 'package:flutter/material.dart';

void buildSnackBar({
  required BuildContext context,
  required String value,
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(value),
      
    ),
  );
}
