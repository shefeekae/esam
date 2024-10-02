class CommunitySchemas {
  static const String listAllCommunities = '''
query listAllCommunities(\$domain: String!, \$parentFlag: Boolean) {
  listAllCommunities(domain: \$domain, parentFlag: \$parentFlag) {
    type
    data
  }
}
''';

  static const String getEnergyIntensityConsolidation = '''
query getEnergyIntensityConsolidation(\$data: EnergyIntensityConsolidationInput) {
  getEnergyIntensityConsolidation(data: \$data) {
    entity {
      type
      data
    }
    period {
      year
      energyUsageIntensity
      energyConsumption
      energyCostIntensity
      energyCost
      chwConsumption
      chwCost
      waterConsumption
      waterCost
      tseConsumption
      tseCost
      cost
      costIntensity
    }
    comparePeriod {
      year
      energyUsageIntensity
      energyConsumption
      energyCostIntensity
      energyCost
      chwConsumption
      chwCost
      waterConsumption
      waterCost
      tseConsumption
      tseCost
      cost
      costIntensity
    }
    variance {
      year
      energyUsageIntensity
      energyConsumption
      energyCostIntensity
      energyCost
      chwConsumption
      chwCost
      waterConsumption
      waterCost
      tseConsumption
      tseCost
      cost
      costIntensity
    }
  }
}
''';

  static const String getEnergyConsumptionNew = '''
query getEnergyConsumptionNew(\$consumptionData: EnergyConsumptionInput!) {
  getEnergyConsumptionNew(consumptionData: \$consumptionData)
}
''';

  static const String getCommunityForecast = '''
query getCommunityForecast(\$id: String!, \$startDate: Float, \$endDate: Float) {
  getCommunityForecast(id: \$id, startDate: \$startDate, endDate: \$endDate)
}
''';
}
