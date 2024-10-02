import 'package:collection/collection.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';

import '../../enums/insights_enum.dart';

class CommunityInsightsServices {
  List<Map<String, dynamic>> groupByDate(List<Map<String, dynamic>> list) {
    List<Map<String, dynamic>> newArray = [];

    for (var element in list) {
      var existing = newArray.firstWhereOrNull(
        (item) => item['date'] == element['date'],
      );

      if (existing == null) {
        newArray.add({
          'date': element['date'],
          'actual': (element['type'] == 'actual') ? element['value'] : null,
          'predicted':
              (element['type'] == 'predicted') ? element['value'] : null,
        });
      } else {
        if (element['type'] == 'actual') {
          existing['actual'] = element['value'] ?? 0;
        } else if (element['type'] == 'predicted') {
          existing['predicted'] = element['value'] ?? 0;
        }
      }
    }

    return newArray;
  }

// =========================================================================================================
// Getting the next level enum. Eg: if the screen is community insights the function will be return next navigating screen is subCommunity

  Insights getNextInsights(Insights insights) {
    switch (insights) {
      case Insights.community:
        return Insights.subCommunity;
      case Insights.subCommunity:
        return Insights.site;

      case Insights.site:
        return Insights.space;
      case Insights.space:
        return insights;
    }
  }

// =============================================================================================

  String getDrillDownFilterKey(Insights? insights) {
    switch (insights) {
      case Insights.community:
        return "community";
      case Insights.subCommunity:
        return "siteGroup";
      case Insights.site:
        return "site";
      default:
        return '';
    }
  }

// =============================================================================================

  String getDrillDownEquipmentConsolidationFilterKey(Insights? insights) {
    switch (insights) {
      case Insights.community:
        return "community";
      case Insights.subCommunity:
        return "subCommunity";
      case Insights.site:
        return "building";
      default:
        return '';
    }
  }

  Level getLevel(Insights? insights) {
    switch (insights) {
      case Insights.community:
        return Level.community;

      case Insights.subCommunity:
        return Level.subCommunity;

      case Insights.site:
        return Level.site;

      case Insights.space:
        return Level.space;

      default:
        return Level.community;
    }
  }
}
