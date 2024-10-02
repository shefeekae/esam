import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/schemas/communities_schema.dart';
import 'package:nectar_assets/core/schemas/site_schema.dart';
import 'package:nectar_assets/core/schemas/sub_communities_schema.dart';

class SubCommunityHeirarchyPerdictionListServices {
  // ===================================================
  // GET prediction list title

  String getTitle(Insights insights) {
    switch (insights) {
      case Insights.community:
        return "Sub Communities";
      case Insights.subCommunity:
        return "Sites";
      default:
        return "";
    }
  }

//  =====================================================
// Prediction List Query Method

  String getQueryMethod(Insights insights) {
    switch (insights) {
      case Insights.community:
        return CommunitySchemas.getCommunityForecast;
      case Insights.subCommunity:
        return SubCommunitySchema.getSubCommunityForecast;
      case Insights.site:
        return SiteSchema.getSiteForecast;

      default:
        return "";
    }
  }

// ========================================================

  String getSearchDataPayloadType(Insights insights) {
    switch (insights) {
      case Insights.community:
        return "SubCommunity";
      case Insights.subCommunity:
        return "Site";
      default:
        return "";
    }
  }
}
