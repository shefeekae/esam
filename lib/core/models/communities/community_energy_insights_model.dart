class GetEnergyIntensityConsolidationModel {
  GetEnergyIntensityConsolidation? getEnergyIntensityConsolidation;

  GetEnergyIntensityConsolidationModel({this.getEnergyIntensityConsolidation});

  GetEnergyIntensityConsolidationModel.fromJson(Map<String, dynamic> json) {
    getEnergyIntensityConsolidation =
        json['getEnergyIntensityConsolidation'] != null
            ? GetEnergyIntensityConsolidation.fromJson(
                json['getEnergyIntensityConsolidation'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getEnergyIntensityConsolidation != null) {
      data['getEnergyIntensityConsolidation'] =
          getEnergyIntensityConsolidation!.toJson();
    }
    return data;
  }
}

class GetEnergyIntensityConsolidation {
  Entity? entity;
  Period? period;
  ComparePeriod? comparePeriod;
  Variance? variance;

  GetEnergyIntensityConsolidation(
      {this.entity, this.period, this.comparePeriod, this.variance});

  GetEnergyIntensityConsolidation.fromJson(Map<String, dynamic> json) {
    entity = json['entity'] != null ? Entity.fromJson(json['entity']) : null;
    period = json['period'] != null ? Period.fromJson(json['period']) : null;
    comparePeriod = json['comparePeriod'] != null
        ? ComparePeriod.fromJson(json['comparePeriod'])
        : null;
    variance =
        json['variance'] != null ? Variance.fromJson(json['variance']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (entity != null) {
      data['entity'] = entity!.toJson();
    }
    if (period != null) {
      data['period'] = period!.toJson();
    }
    if (comparePeriod != null) {
      data['comparePeriod'] = comparePeriod!.toJson();
    }
    if (variance != null) {
      data['variance'] = variance!.toJson();
    }
    return data;
  }
}

class Entity {
  String? type;
  Data? data;

  Entity({this.type, this.data});

  Entity.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? area;
  String? identifier;
  String? clientId;
  String? offset;
  String? clientName;
  String? typeName;
  String? timeZone;
  String? profileImage;
  String? centrepoint;
  String? createdOn;
  String? homePage;
  String? defaultvalue;
  String? weatherSensor;
  String? createdBy;
  String? domain;
  String? location;
  String? status;

  Data(
      {this.area,
      this.identifier,
      this.clientId,
      this.offset,
      this.clientName,
      this.typeName,
      this.timeZone,
      this.profileImage,
      this.centrepoint,
      this.createdOn,
      this.homePage,
      this.defaultvalue,
      this.weatherSensor,
      this.createdBy,
      this.domain,
      this.location,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    identifier = json['identifier'];
    clientId = json['clientId'];
    offset = json['offset'];
    clientName = json['clientName'];
    typeName = json['typeName'];
    timeZone = json['timeZone'];
    profileImage = json['profileImage'];
    centrepoint = json['centrepoint'];
    createdOn = json['createdOn'];
    homePage = json['homePage'];
    defaultvalue = json['defaultvalue'];
    weatherSensor = json['weatherSensor'];
    createdBy = json['createdBy'];
    domain = json['domain'];
    location = json['location'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area'] = area;
    data['identifier'] = identifier;
    data['clientId'] = clientId;
    data['offset'] = offset;
    data['clientName'] = clientName;
    data['typeName'] = typeName;
    data['timeZone'] = timeZone;
    data['profileImage'] = profileImage;
    data['centrepoint'] = centrepoint;
    data['createdOn'] = createdOn;
    data['homePage'] = homePage;
    data['defaultvalue'] = defaultvalue;
    data['weatherSensor'] = weatherSensor;
    data['createdBy'] = createdBy;
    data['domain'] = domain;
    data['location'] = location;
    data['status'] = status;
    return data;
  }
}

class Period {
  int? year;
  num? energyUsageIntensity;
  num? energyConsumption;
  num? energyCostIntensity;
  num? energyCost;
  num? chwConsumption;
  num? chwCost;
  num? waterConsumption;
  num? waterCost;
  dynamic tseConsumption;
  dynamic tseCost;
  num? cost;
  num? costIntensity;

  Period(
      {this.year,
      this.energyUsageIntensity,
      this.energyConsumption,
      this.energyCostIntensity,
      this.energyCost,
      this.chwConsumption,
      this.chwCost,
      this.waterConsumption,
      this.waterCost,
      this.tseConsumption,
      this.tseCost,
      this.cost,
      this.costIntensity});

  Period.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    energyUsageIntensity = json['energyUsageIntensity'];
    energyConsumption = json['energyConsumption'];
    energyCostIntensity = json['energyCostIntensity'];
    energyCost = json['energyCost'];
    chwConsumption = json['chwConsumption'];
    chwCost = json['chwCost'];
    waterConsumption = json['waterConsumption'];
    waterCost = json['waterCost'];
    tseConsumption = json['tseConsumption'];
    tseCost = json['tseCost'];
    cost = json['cost'];
    costIntensity = json['costIntensity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['energyUsageIntensity'] = energyUsageIntensity;
    data['energyConsumption'] = energyConsumption;
    data['energyCostIntensity'] = energyCostIntensity;
    data['energyCost'] = energyCost;
    data['chwConsumption'] = chwConsumption;
    data['chwCost'] = chwCost;
    data['waterConsumption'] = waterConsumption;
    data['waterCost'] = waterCost;
    data['tseConsumption'] = tseConsumption;
    data['tseCost'] = tseCost;
    data['cost'] = cost;
    data['costIntensity'] = costIntensity;
    return data;
  }
}

class ComparePeriod {
  int? year;
  num? energyUsageIntensity;
  num? energyConsumption;
  num? energyCostIntensity;
  num? energyCost;
  num? chwConsumption;
  num? chwCost;
  num? waterConsumption;
  num? waterCost;
  dynamic tseConsumption;
  dynamic tseCost;
  num? cost;
  num? costIntensity;

  ComparePeriod(
      {this.year,
      this.energyUsageIntensity,
      this.energyConsumption,
      this.energyCostIntensity,
      this.energyCost,
      this.chwConsumption,
      this.chwCost,
      this.waterConsumption,
      this.waterCost,
      this.tseConsumption,
      this.tseCost,
      this.cost,
      this.costIntensity});

  ComparePeriod.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    energyUsageIntensity = json['energyUsageIntensity'];
    energyConsumption = json['energyConsumption'];
    energyCostIntensity = json['energyCostIntensity'];
    energyCost = json['energyCost'];
    chwConsumption = json['chwConsumption'];
    chwCost = json['chwCost'];
    waterConsumption = json['waterConsumption'];
    waterCost = json['waterCost'];
    tseConsumption = json['tseConsumption'];
    tseCost = json['tseCost'];
    cost = json['cost'];
    costIntensity = json['costIntensity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['energyUsageIntensity'] = energyUsageIntensity;
    data['energyConsumption'] = energyConsumption;
    data['energyCostIntensity'] = energyCostIntensity;
    data['energyCost'] = energyCost;
    data['chwConsumption'] = chwConsumption;
    data['chwCost'] = chwCost;
    data['waterConsumption'] = waterConsumption;
    data['waterCost'] = waterCost;
    data['tseConsumption'] = tseConsumption;
    data['tseCost'] = tseCost;
    data['cost'] = cost;
    data['costIntensity'] = costIntensity;
    return data;
  }
}

class Variance {
  dynamic year;
  num? energyUsageIntensity;
  num? energyConsumption;
  num? energyCostIntensity;
  num? energyCost;
  num? chwConsumption;
  num? chwCost;
  num? waterConsumption;
  num? waterCost;
  num? tseConsumption;
  num? tseCost;
  num? cost;
  num? costIntensity;

  Variance(
      {this.year,
      this.energyUsageIntensity,
      this.energyConsumption,
      this.energyCostIntensity,
      this.energyCost,
      this.chwConsumption,
      this.chwCost,
      this.waterConsumption,
      this.waterCost,
      this.tseConsumption,
      this.tseCost,
      this.cost,
      this.costIntensity});

  Variance.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    energyUsageIntensity = json['energyUsageIntensity'];
    energyConsumption = json['energyConsumption'];
    energyCostIntensity = json['energyCostIntensity'];
    energyCost = json['energyCost'];
    chwConsumption = json['chwConsumption'];
    chwCost = json['chwCost'];
    waterConsumption = json['waterConsumption'];
    waterCost = json['waterCost'];
    tseConsumption = json['tseConsumption'];
    tseCost = json['tseCost'];
    cost = json['cost'];
    costIntensity = json['costIntensity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['energyUsageIntensity'] = energyUsageIntensity;
    data['energyConsumption'] = energyConsumption;
    data['energyCostIntensity'] = energyCostIntensity;
    data['energyCost'] = energyCost;
    data['chwConsumption'] = chwConsumption;
    data['chwCost'] = chwCost;
    data['waterConsumption'] = waterConsumption;
    data['waterCost'] = waterCost;
    data['tseConsumption'] = tseConsumption;
    data['tseCost'] = tseCost;
    data['cost'] = cost;
    data['costIntensity'] = costIntensity;
    return data;
  }
}
