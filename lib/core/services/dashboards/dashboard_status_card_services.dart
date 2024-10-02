import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/models/dashboard/utilities_stat_card_model.dart';
import 'package:nectar_assets/core/models/dashboard/utitlities_data_model.dart';
import 'package:nectar_assets/ui/shared/functions/converters.dart';

class DashboardStatusCardServices {
  List<UtilitiesStatusCardModel> getStatusCardList(
    Map<String, dynamic> data,
    int currentYear,
    int previousYear,
    Level level,
  ) {
    UtilitiesDataModel utilitiesData = UtilitiesDataModel.fromJson(data);

    List<Values> valueList = utilitiesData.getUtilitiesData?.values ?? [];

    List<UtilitiesStatusCardModel> statusCardList = getAllUtilitiesCostAndCount(
        currentYear.toString(), previousYear.toString(), valueList, {
      "level": (level == Level.community ||
              level == Level.subCommunity ||
              level == Level.site)
          ? "LVPMeter"
          : "innerSubMeter"
    });

    return statusCardList;
  }

  List<UtilitiesStatusCardModel> getAllUtilitiesCostAndCount(
      String currentYear,
      String previousYear,
      List<Values> utilitiesData,
      Map<String, dynamic>? query) {
    List<UtilitiesStatusCardModel> list = [];

    double totalCurrentEnergyConsumption = utilitiesData.fold(0, (prev, cur) {
      if (query?['level'] == "innerSubMeter") {
        return cur.lVPSubMeterCurrent != null
            ? prev + double.parse(cur.lVPSubMeterCurrent.toString())
            : prev;
      } else {
        return cur.lVPMeterCurrent != null
            ? prev + double.parse(cur.lVPMeterCurrent.toString())
            : prev;
      }
    });

    double totalPreviousEnergyConsumption = utilitiesData.fold(0, (prev, cur) {
      if (query?['level'] == "innerSubMeter") {
        return cur.lVPSubMeterPrevious != null
            ? prev + double.parse(cur.lVPSubMeterPrevious.toString())
            : prev;
      } else {
        return cur.lVPMeterPrevious != null
            ? prev + double.parse(cur.lVPMeterPrevious.toString())
            : prev;
      }
    });

    double totalCurrentEnergyCost = utilitiesData.fold(0, (prev, cur) {
      if (query?['level'] == "innerSubMeter") {
        return cur.lVPSubMeterCurrentCost != null
            ? prev + double.parse(cur.lVPSubMeterCurrentCost.toString())
            : prev;
      } else {
        return cur.lVPMeterCurrentCost != null
            ? prev + double.parse(cur.lVPMeterCurrentCost.toString())
            : prev;
      }
    });

    double totalPreviousEnergyCost = utilitiesData.fold(0, (prev, cur) {
      if (query?['level'] == "innerSubMeter") {
        return cur.lVPSubMeterPreviousCost != null
            ? prev + double.parse(cur.lVPSubMeterPreviousCost.toString())
            : prev;
      } else {
        return cur.lVPMeterPreviousCost != null
            ? prev + double.parse(cur.lVPMeterPreviousCost.toString())
            : prev;
      }
    });

    double totalCurrentWaterCost = utilitiesData.fold(
        0,
        (prev, cur) => cur.waterMeterCurrentCost != null
            ? prev + double.parse(cur.waterMeterCurrentCost.toString())
            : prev);

    double totalPreviousWaterCost = utilitiesData.fold(
        0,
        (prev, cur) => cur.waterMeterPreviousCost != null
            ? prev + double.parse(cur.waterMeterPreviousCost.toString())
            : prev);

    double totalCurrentWaterConsumption = utilitiesData.fold(
        0,
        (prev, cur) => cur.waterMeterCurrent != null
            ? prev + double.parse(cur.waterMeterCurrent.toString())
            : prev);

    double totalPreviousWaterConsumption = utilitiesData.fold(
        0,
        (prev, cur) => cur.waterMeterPrevious != null
            ? prev + double.parse(cur.waterMeterPrevious.toString())
            : prev);

    double totalCurrentBTUCost = utilitiesData.fold(
        0,
        (prev, cur) => cur.dCPBTUMeterCurrentCost != null
            ? prev + double.parse(cur.dCPBTUMeterCurrentCost.toString())
            : prev);

    double totalCurrentBTUConsumption = utilitiesData.fold(
        0,
        (prev, cur) => cur.dCPBTUMeterCurrent != null
            ? prev + double.parse(cur.dCPBTUMeterCurrent.toString())
            : prev);

    double totalPreviousBTUCost = utilitiesData.fold(
        0,
        (prev, cur) => cur.dCPBTUMeterPreviousCost != null
            ? prev + double.parse(cur.dCPBTUMeterPreviousCost.toString())
            : prev);
    double totalPreviousBTUConsumption = utilitiesData.fold(
        0,
        (prev, cur) => cur.dCPBTUMeterPrevious != null
            ? prev + double.parse(cur.dCPBTUMeterPrevious.toString())
            : prev);

    double totalCurrentTSECost = utilitiesData.fold(
        0,
        (prev, cur) => cur.tSEMeterCurrentCost != null
            ? prev + double.parse(cur.tSEMeterCurrentCost.toString())
            : prev);

    double totalCurrentTSEConsumption = utilitiesData.fold(
        0,
        (prev, cur) => cur.tSEMeterCurrent != null
            ? prev + double.parse(cur.tSEMeterCurrent.toString())
            : prev);

    double totalPreviousTSECost = utilitiesData.fold(
        0,
        (prev, cur) => cur.tSEMeterPreviousCost != null
            ? prev + double.parse(cur.tSEMeterPreviousCost.toString())
            : prev);

    double totalPreviousTSEConsumption = utilitiesData.fold(
        0,
        (prev, cur) => cur.tSEMeterPrevious != null
            ? prev + double.parse(cur.tSEMeterPrevious.toString())
            : prev);

    double totalCurrentCost = totalCurrentEnergyCost +
        totalCurrentWaterCost +
        totalCurrentBTUCost +
        totalCurrentTSECost;
    double totalPreviousCost = totalPreviousEnergyCost +
        totalPreviousWaterCost +
        totalPreviousBTUCost +
        totalPreviousTSECost;

    // double totalConsumption = totalCurrentEnergyConsumption

    // double totalEnergySavings =
    //     totalCurrentEnergyConsumption - totalPreviousEnergyConsumption;

    double totalCostSavings = totalCurrentCost > totalPreviousCost
        ? totalCurrentCost - totalPreviousCost
        : totalPreviousCost - totalCurrentCost;

    double totalEnergyCostSavings =
        totalCurrentEnergyCost > totalPreviousEnergyCost
            ? totalCurrentEnergyCost - totalPreviousEnergyCost
            : totalPreviousEnergyCost - totalCurrentEnergyCost;

    double totalEnergyConsumptionSavings =
        totalCurrentEnergyConsumption > totalPreviousEnergyConsumption
            ? totalCurrentEnergyConsumption - totalPreviousEnergyConsumption
            : totalPreviousEnergyConsumption - totalCurrentEnergyConsumption;

    double totalWaterConsumptionSavings =
        totalCurrentWaterConsumption > totalPreviousWaterConsumption
            ? totalCurrentWaterConsumption - totalPreviousWaterConsumption
            : totalPreviousWaterConsumption - totalCurrentWaterConsumption;

    double totalWaterCostSavings =
        totalCurrentWaterCost > totalPreviousWaterCost
            ? totalCurrentWaterCost - totalPreviousWaterCost
            : totalPreviousWaterCost - totalCurrentWaterCost;

    double totalChilledWaterConsumptionSavings =
        totalCurrentBTUConsumption > totalPreviousBTUConsumption
            ? totalCurrentBTUConsumption - totalPreviousBTUConsumption
            : totalPreviousBTUConsumption - totalCurrentBTUConsumption;

    double totalChilledWaterCostSavings =
        totalCurrentBTUCost > totalPreviousBTUCost
            ? totalCurrentBTUCost - totalPreviousBTUCost
            : totalPreviousBTUCost - totalCurrentBTUCost;

    double totalTSEConsumptionSavings =
        totalCurrentTSEConsumption > totalPreviousTSEConsumption
            ? totalCurrentTSEConsumption - totalPreviousTSEConsumption
            : totalPreviousTSEConsumption - totalCurrentTSEConsumption;

    double totalTSECostSavings = totalCurrentTSECost > totalPreviousTSECost
        ? totalCurrentTSECost - totalPreviousTSECost
        : totalPreviousTSECost - totalCurrentTSECost;

    /////===========================================================================
    ///Percent
    double totalCostSavingsPercent = calculatePercentage(
      totalValue: totalCostSavings,
      previousYearValue: totalPreviousCost,
    );
    // totalCostSavings < totalPreviousCost
    //     ? (totalCostSavings.abs() / totalPreviousCost) * 100
    //     : (totalPreviousCost.abs() / totalCostSavings) * 100;

    double electricityCostPercent = calculatePercentage(
      totalValue: totalEnergyCostSavings,
      previousYearValue: totalPreviousEnergyCost,
    );

    // totalEnergyCostSavings < totalPreviousEnergyCost
    //     ? (totalEnergyCostSavings.abs() / totalPreviousEnergyCost) * 100
    //     : (totalPreviousEnergyCost.abs() / totalEnergyCostSavings) * 100;

    double electricityConsumptionPercent = calculatePercentage(
      totalValue: totalEnergyConsumptionSavings,
      previousYearValue: totalPreviousEnergyConsumption,
    );

    // (totalEnergyConsumptionSavings.abs() / totalPreviousEnergyConsumption) *
    //     100;

    double waterConsumptionPercent = calculatePercentage(
      totalValue: totalWaterConsumptionSavings,
      previousYearValue: totalPreviousWaterConsumption,
    );
    // (totalWaterConsumptionSavings.abs() / totalPreviousWaterConsumption) *
    //     100;

    double waterCostPercent = calculatePercentage(
      totalValue: totalWaterCostSavings,
      previousYearValue: totalPreviousWaterCost,
    );

    // (totalWaterCostSavings.abs() / totalPreviousWaterCost) * 100;

    double chilledWaterConsumptionPercent = calculatePercentage(
      totalValue: totalChilledWaterConsumptionSavings,
      previousYearValue: totalPreviousBTUConsumption,
    );
    // (totalChilledWaterConsumptionSavings.abs() /
    //         totalPreviousBTUConsumption) *
    //     100;

    double chilledWaterCostPercent = calculatePercentage(
      totalValue: totalChilledWaterCostSavings,
      previousYearValue: totalPreviousBTUCost,
    );
    // (totalChilledWaterCostSavings.abs() / totalPreviousBTUCost) * 100;

    double tSEConsumptionPercent = calculatePercentage(
      totalValue: totalTSEConsumptionSavings,
      previousYearValue: totalPreviousTSEConsumption,
    );
    // (totalTSEConsumptionSavings.abs() / totalPreviousTSEConsumption) * 100;

    double tSECostPercent = calculatePercentage(
      totalValue: totalTSECostSavings,
      previousYearValue: totalPreviousTSECost,
    );

    // (totalTSECostSavings.abs() / totalPreviousTSECost) * 100;

    ///===============================================================================
    ///
    // double totalCO2 = (totalEnergySavings * 0.59) / 1000;
    // int treesCount = treesCountWithCO2(totalCO2);

    double co2Emission =
        totalCurrentEnergyConsumption < totalPreviousEnergyConsumption
            ? (totalPreviousEnergyConsumption - totalCurrentEnergyConsumption) *
                0.00059
            : (totalCurrentEnergyConsumption - totalPreviousEnergyConsumption) *
                0.00059;

    double treeUsed = co2Emission / 4.657;

    list.addAll([
      UtilitiesStatusCardModel(
          name: "Total Cost Variance",
          unit: "AED",
          currentValue: Converter().formatNumber(totalCurrentCost),
          previousValue: Converter().formatNumber(totalPreviousCost),
          currentYear: currentYear,
          previousYear: previousYear,
          compareValue: totalCurrentCost > totalPreviousCost
              ? Converter().formatNumber((totalCurrentCost - totalPreviousCost))
              : Converter()
                  .formatNumber((totalPreviousCost - totalCurrentCost)),
          increased: totalPreviousCost < totalCurrentCost ? true : false,
          percentage: "(${totalCostSavingsPercent.toStringAsFixed(2)}%)"),

      UtilitiesStatusCardModel(
        name: totalCurrentEnergyConsumption > totalPreviousEnergyConsumption
            ? "CO2 Emission"
            : "CO2 Reduction",
        unit: "Tonnes",
        currentValue: "Compared to year $previousYear",
        previousValue:
            totalCurrentEnergyConsumption > totalPreviousEnergyConsumption
                ? "${treeUsed.toInt()} Tree Used"
                : "${treeUsed.toInt()} Tree Saved",
        currentYear: "",
        previousYear: "",
        compareValue: "${Converter().formatNumber(co2Emission)} Tonnes",
        increased: null,
        percentage: "",
      ),

      //
      UtilitiesStatusCardModel(
          name: "Electricity Consumption Variance",
          unit: "Kwh",
          compareValue:
              totalCurrentEnergyConsumption > totalPreviousEnergyConsumption
                  ? Converter().formatNumber((totalCurrentEnergyConsumption -
                      totalPreviousEnergyConsumption))
                  : Converter().formatNumber((totalPreviousEnergyConsumption -
                      totalCurrentEnergyConsumption)),
          currentValue: Converter().formatNumber(totalCurrentEnergyConsumption),
          previousValue:
              Converter().formatNumber(totalPreviousEnergyConsumption),
          currentYear: currentYear,
          previousYear: previousYear,
          increased:
              totalPreviousEnergyConsumption < totalCurrentEnergyConsumption
                  ? true
                  : false,
          percentage: "(${electricityConsumptionPercent.toStringAsFixed(2)}%)"),

      //
      UtilitiesStatusCardModel(
          name: "Electricity Cost Variance",
          unit: "AED",
          compareValue: totalCurrentEnergyCost > totalPreviousEnergyCost
              ? Converter().formatNumber(
                  (totalCurrentEnergyCost - totalPreviousEnergyCost))
              : Converter().formatNumber(
                  (totalPreviousEnergyCost - totalCurrentEnergyCost)),
          currentValue: Converter().formatNumber(totalCurrentEnergyCost),
          previousValue: Converter().formatNumber(totalPreviousEnergyCost),
          currentYear: currentYear,
          previousYear: previousYear,
          increased:
              totalPreviousEnergyCost < totalCurrentEnergyCost ? true : false,
          percentage: "(${electricityCostPercent.toStringAsFixed(2)}%)"),

      //
      UtilitiesStatusCardModel(
          name: "Water Consumption Variance",
          unit: "IG",
          compareValue: totalCurrentWaterConsumption >
                  totalPreviousWaterConsumption
              ? Converter().formatNumber((totalCurrentWaterConsumption -
                  totalPreviousWaterConsumption))
              : Converter().formatNumber((totalPreviousWaterConsumption -
                  totalCurrentWaterConsumption)),
          currentValue: Converter().formatNumber(totalCurrentWaterConsumption),
          previousValue:
              Converter().formatNumber(totalPreviousWaterConsumption),
          currentYear: currentYear,
          previousYear: previousYear,
          increased:
              totalPreviousWaterConsumption < totalCurrentWaterConsumption
                  ? true
                  : false,
          percentage: "(${waterConsumptionPercent.toStringAsFixed(2)}%)"),

      //
      UtilitiesStatusCardModel(
          name: "Water Cost Variance",
          unit: "AED",
          compareValue: totalCurrentWaterCost > totalPreviousWaterCost
              ? Converter().formatNumber(
                  (totalCurrentWaterCost - totalPreviousWaterCost))
              : Converter().formatNumber(
                  (totalPreviousWaterCost - totalCurrentWaterCost)),
          currentValue: Converter().formatNumber(totalCurrentWaterCost),
          previousValue: Converter().formatNumber(totalPreviousWaterCost),
          currentYear: currentYear,
          previousYear: previousYear,
          increased:
              totalPreviousWaterCost < totalCurrentWaterCost ? true : false,
          percentage: "(${waterCostPercent.toStringAsFixed(2)}%)"),

      //
      UtilitiesStatusCardModel(
          name: "Chilled Water Consumption Variance",
          unit: "RTH",
          compareValue: totalCurrentBTUConsumption > totalPreviousBTUConsumption
              ? Converter().formatNumber(
                  (totalCurrentBTUConsumption - totalPreviousBTUConsumption))
              : Converter().formatNumber(
                  (totalPreviousBTUConsumption - totalCurrentBTUConsumption)),
          currentValue: Converter().formatNumber(totalCurrentBTUConsumption),
          previousValue: Converter().formatNumber(totalPreviousBTUConsumption),
          currentYear: currentYear,
          previousYear: previousYear,
          increased: totalPreviousBTUConsumption < totalCurrentBTUConsumption
              ? true
              : false,
          percentage:
              "(${chilledWaterConsumptionPercent.toStringAsFixed(2)}%)"),

      //
      UtilitiesStatusCardModel(
          name: "Chilled Water Cost Variance",
          unit: "AED",
          compareValue: totalCurrentBTUCost > totalPreviousBTUCost
              ? Converter()
                  .formatNumber((totalCurrentBTUCost - totalPreviousBTUCost))
              : Converter()
                  .formatNumber((totalPreviousBTUCost - totalCurrentBTUCost)),
          currentValue: Converter().formatNumber(totalCurrentBTUCost),
          previousValue: Converter().formatNumber(totalPreviousBTUCost),
          currentYear: currentYear,
          previousYear: previousYear,
          increased: totalPreviousBTUCost < totalCurrentBTUCost ? true : false,
          percentage: "(${chilledWaterCostPercent.toStringAsFixed(2)}%)"),

      //
      UtilitiesStatusCardModel(
          name: "Treated Effluent Consumption Variance",
          unit: "m³",
          compareValue: totalCurrentTSEConsumption > totalPreviousTSEConsumption
              ? Converter().formatNumber(
                  (totalCurrentTSEConsumption - totalPreviousTSEConsumption))
              : Converter().formatNumber(
                  (totalPreviousTSEConsumption - totalCurrentTSEConsumption)),
          currentValue: Converter().formatNumber(totalCurrentTSEConsumption),
          previousValue: Converter().formatNumber(totalPreviousTSEConsumption),
          currentYear: currentYear,
          previousYear: previousYear,
          increased: totalPreviousTSEConsumption < totalCurrentTSEConsumption
              ? true
              : false,
          percentage: "(${tSEConsumptionPercent.toStringAsFixed(2)}%)"),

      //
      UtilitiesStatusCardModel(
          name: "Treated Effluent Cost Variance",
          unit: "AED",
          compareValue: totalCurrentTSECost > totalPreviousTSECost
              ? Converter()
                  .formatNumber((totalCurrentTSECost - totalPreviousTSECost))
              : Converter()
                  .formatNumber((totalPreviousTSECost - totalCurrentTSECost)),
          currentValue: Converter().formatNumber(totalCurrentTSECost),
          previousValue: Converter().formatNumber(totalPreviousTSECost),
          currentYear: currentYear,
          previousYear: previousYear,
          increased: totalPreviousTSECost < totalCurrentTSECost ? true : false,
          percentage: "(${tSECostPercent.toStringAsFixed(2)}%)"),
    ]);

    return list;

    // return {
    //   'totalCurrentWaterCost': totalCurrentWaterCost,
    //   "totalPreviousWaterCost": totalPreviousWaterCost,
    //   'totalCurrentCost': totalCurrentCost,
    //   'totalPreviousCost': totalPreviousCost,
    //   'totalEnergySavings': totalEnergySavings,
    //   'totalCostSavings': totalCostSavings,
    //   'totalCostSavingsPercent': totalCostSavingsPercent,
    //   'totalCO2': totalCO2,
    //   'treesCount': treesCount,
    // };
  }

  int treesCountWithCO2(double totalCO2) {
    // Implement the logic to calculate the number of trees based on CO2
    // This function is not provided in the original JavaScript code.
    // You can replace it with your specific implementation.
    // For example, return totalCO2.toInt() / 10;
    return 0;
  }

  double calculatePercentage({
    required double totalValue,
    required double previousYearValue,
  }) {
    double percentage = totalValue < previousYearValue
        ? (totalValue.abs() / previousYearValue) * 100
        : (previousYearValue.abs() / totalValue) * 100;

    return percentage;
  }
}
