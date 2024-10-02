

// =========================================================================================
//TODO : This method is used to show the criticality wise colors

import 'package:flutter/material.dart';

Color getCriticalityColors({required String criticaliy}) {
    if (criticaliy == "HIGH") {
      return Colors.red;
    } else if (criticaliy == "CRITICAL") {
      return Colors.red.shade900;
    } else if (criticaliy == "MEDIUM") {
      return Colors.orange;
    } else if (criticaliy == "LOW") {
      return Colors.yellow.shade700;
    }

    return Colors.white;
  }

  // ===========================================================================================
// This method is used to show the status of alarm.

  Map<String, dynamic> getStausofAlarm(
      {required bool active, required bool resolved}) {
    if (active) {
      return {"text": "Active", "color": Colors.red.shade700};
    } else if (resolved) {
      return {"text": "Resolved", "color": Colors.green};
    }
    return {
      "text": "",
      "color": Colors.yellow,
    };
  }