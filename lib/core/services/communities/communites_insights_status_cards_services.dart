import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/shared/functions/converters.dart';

import '../../models/communities/community_energy_insights_model.dart';
import '../../models/communities/community_insights_status_card_model.dart';

class CommunityInsightsStatusServices {
  //  =================================================================================

  CommunityInsightsStatusCardModel compareValues({
    required String name,
    required Map<String, dynamic> period,
    required Map<String, dynamic> comparePeriod,
    required String key,
    required String symbol,
  }) {
    num periodValue = period[key] ?? 0;
    num comparePeriodValue = comparePeriod[key] ?? 0;

    int compareYear = comparePeriod['year'] ?? 0;

    double percentageChange = periodValue == 0
        ? 0
        : periodValue > comparePeriodValue
            ? ((periodValue - comparePeriodValue) / comparePeriodValue) * 100
            : ((comparePeriodValue - periodValue) / comparePeriodValue) * 100;

    String value =
        "${Converter().formatNumber(periodValue.toDouble())} $symbol";
    String compareYearValue =
        "${Converter().formatNumber(comparePeriodValue.toDouble())} $symbol";

    String percentageValue =
        percentageChange == 0 ? "0" : percentageChange.toStringAsFixed(2);

    if (periodValue > comparePeriodValue) {
      return CommunityInsightsStatusCardModel(
        name: name,
        value: value,
        compareYear: compareYear.toString(),
        compareYearValue: compareYearValue,
        increased: true,
        percentage: "$percentageValue%",
      );

      // return 'Increased by ${percentageChange.toStringAsFixed(2)}%';
    }
    return CommunityInsightsStatusCardModel(
      name: name,
      value: value,
      compareYear: compareYear.toString(),
      compareYearValue: compareYearValue,
      increased: false,
      percentage: "$percentageValue%",
    );
  }

  // ==================================================================================

  List<CommunityInsightsStatusCardModel> getStatusCardList(
    Map<String, dynamic> data,
  ) {
    List<Map> list = [
      {
        "name": "Energy Cost",
        "key": "energyCost",
        "symbol": "AED",
      },
      {
        "name": "Energy Consumption",
        "key": "energyConsumption",
        "symbol": "Kwh",
      },
      {
        "name": "CHW Cost",
        "key": "chwCost",
        "symbol": "AED",
      },
      {
        "name": "CHW Consumption",
        "key": "chwConsumption",
        "symbol": "Kwh",
      },
      {
        "name": "Water Cost",
        "key": "waterCost",
        "symbol": "AED",
      },
      {
        "name": "Water Consumption",
        "key": "waterConsumption",
        "symbol": "IG",
      },
      {
        "name": "Treated Effluent Cost",
        "key": "tseCost",
        "symbol": "AED",
      },
      {
        "name": "Treated Effluent Consumption",
        "key": "tseConsumption",
        "symbol": "m³",
      },
    ];

    GetEnergyIntensityConsolidationModel getEnergyIntensityConsolidationModel =
        GetEnergyIntensityConsolidationModel.fromJson(data);

    Map<String, dynamic> comparePeriod = getEnergyIntensityConsolidationModel
            .getEnergyIntensityConsolidation?.comparePeriod
            ?.toJson() ??
        {};

    Map<String, dynamic> period = getEnergyIntensityConsolidationModel
            .getEnergyIntensityConsolidation?.period
            ?.toJson() ??
        {};

    String totalArea = "0";
    try {
      double value = double.parse(getEnergyIntensityConsolidationModel
              .getEnergyIntensityConsolidation?.entity?.data?.area ??
          '0');

      totalArea = Converter().formatNumber(value);
    } catch (_) {
      totalArea = "0";
    }

    var statusCardsList = list
        .map(
          (e) => compareValues(
            name: e['name'],
            period: period,
            comparePeriod: comparePeriod,
            key: e['key'],
            symbol: e['symbol'],
          ),
        )
        .toList();

    statusCardsList.add(CommunityInsightsStatusCardModel(
      name: "Total Area",
      value: "$totalArea sq.feet",
      compareYear: "",
      compareYearValue: "",
      increased: null,
      percentage: "",
    ));

    num currentYearConsumption = period['energyConsumption'] ?? 0;
    num previousYearConsumption = comparePeriod['energyConsumption'] ?? 0;

    double co2Emission = currentYearConsumption < previousYearConsumption
        ? (previousYearConsumption - currentYearConsumption) * 0.00059
        : (currentYearConsumption - previousYearConsumption) * 0.00059;

    double treeUsed = co2Emission / 4.657;

    statusCardsList.add(CommunityInsightsStatusCardModel(
      name: currentYearConsumption > previousYearConsumption
          ? "CO2 Emission"
          : "CO2 Reduction",
      value: "${Converter().formatNumber(co2Emission)} Tonnes",
      compareYear: "",
      compareYearValue: currentYearConsumption > previousYearConsumption
          ? "Tree Used"
          : "Tree Saved",
      increased: null,
      percentage: treeUsed.round().toString(),
      color: Colors.blue,
    ));

    return statusCardsList;
  }

  // ================================================================================
  // GET INCREASE DICREASE COLOUR

  Map<String, Color> getIncreaseDecreaseColor({
    required bool? increased,
  }) {
    if (increased == null) {
      return {
        "bgColor": Colors.blue,
        "iconColor": Colors.white,
      };
    } else if (!increased) {
      return {
        "bgColor": const Color.fromRGBO(67, 142, 70, 1),
        "iconColor": const Color.fromRGBO(47, 255, 15, 1),
      };
    }

    return {
      "bgColor": const Color.fromRGBO(168, 0, 0, 1),
      "iconColor": const Color.fromRGBO(255, 0, 0, 1),
    };
  }
}
