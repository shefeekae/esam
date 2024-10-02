class UtilitiesDataModel {
  GetUtilitiesData? getUtilitiesData;

  UtilitiesDataModel({this.getUtilitiesData});

  UtilitiesDataModel.fromJson(Map<String, dynamic> json) {
    getUtilitiesData = json['getUtilitiesData'] != null
        ? GetUtilitiesData.fromJson(json['getUtilitiesData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getUtilitiesData != null) {
      data['getUtilitiesData'] = getUtilitiesData!.toJson();
    }
    return data;
  }
}

class GetUtilitiesData {
  LatestUpdate? latestUpdate;
  List<Values>? values;

  GetUtilitiesData({this.latestUpdate, this.values});

  GetUtilitiesData.fromJson(Map<String, dynamic> json) {
    latestUpdate = json['latestUpdate'] != null
        ? LatestUpdate.fromJson(json['latestUpdate'])
        : null;
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (latestUpdate != null) {
      data['latestUpdate'] = latestUpdate!.toJson();
    }
    if (values != null) {
      data['values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LatestUpdate {
  int? year;
  int? month;

  LatestUpdate({this.year, this.month});

  LatestUpdate.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    return data;
  }
}

class Values {
  String? name;
  String? month;
  dynamic lVPMeterCurrent;
  dynamic lVPMeterPrevious;
  dynamic lVPMeterCurrentCost;
  dynamic lVPMeterPreviousCost;
  dynamic lVPSubMeterCurrent;
  dynamic lVPSubMeterPrevious;
  dynamic lVPSubMeterCurrentCost;
  dynamic lVPSubMeterPreviousCost;
  dynamic dCPBTUMeterCurrent;
  dynamic dCPBTUMeterPrevious;
  dynamic dCPBTUMeterCurrentCost;
  dynamic dCPBTUMeterPreviousCost;
  dynamic waterMeterCurrent;
  dynamic waterMeterPrevious;
  dynamic waterMeterCurrentCost;
  dynamic waterMeterPreviousCost;
  dynamic tSEMeterCurrent;
  dynamic tSEMeterPrevious;
  dynamic tSEMeterCurrentCost;
  dynamic tSEMeterPreviousCost;

  Values(
      {this.name,
      this.month,
      this.lVPMeterCurrent,
      this.lVPMeterPrevious,
      this.lVPMeterCurrentCost,
      this.lVPMeterPreviousCost,
      this.lVPSubMeterCurrent,
      this.lVPSubMeterPrevious,
      this.lVPSubMeterCurrentCost,
      this.lVPSubMeterPreviousCost,
      this.dCPBTUMeterCurrent,
      this.dCPBTUMeterPrevious,
      this.dCPBTUMeterCurrentCost,
      this.dCPBTUMeterPreviousCost,
      this.waterMeterCurrent,
      this.waterMeterPrevious,
      this.waterMeterCurrentCost,
      this.waterMeterPreviousCost,
      this.tSEMeterCurrent,
      this.tSEMeterPrevious,
      this.tSEMeterCurrentCost,
      this.tSEMeterPreviousCost});

  Values.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    month = json['month'];
    lVPMeterCurrent = json['LVPMeterCurrent'];
    lVPMeterPrevious = json['LVPMeterPrevious'];
    lVPMeterCurrentCost = json['LVPMeterCurrentCost'];
    lVPMeterPreviousCost = json['LVPMeterPreviousCost'];
    lVPSubMeterCurrent = json['LVPSubMeterCurrent'];
    lVPSubMeterPrevious = json['LVPSubMeterPrevious'];
    lVPSubMeterCurrentCost = json['LVPSubMeterCurrentCost'];
    lVPSubMeterPreviousCost = json['LVPSubMeterPreviousCost'];
    dCPBTUMeterCurrent = json['DCPBTUMeterCurrent'];
    dCPBTUMeterPrevious = json['DCPBTUMeterPrevious'];
    dCPBTUMeterCurrentCost = json['DCPBTUMeterCurrentCost'];
    dCPBTUMeterPreviousCost = json['DCPBTUMeterPreviousCost'];
    waterMeterCurrent = json['WaterMeterCurrent'];
    waterMeterPrevious = json['WaterMeterPrevious'];
    waterMeterCurrentCost = json['WaterMeterCurrentCost'];
    waterMeterPreviousCost = json['WaterMeterPreviousCost'];
    tSEMeterCurrent = json['TSEMeterCurrent'];
    tSEMeterPrevious = json['TSEMeterPrevious'];
    tSEMeterCurrentCost = json['TSEMeterCurrentCost'];
    tSEMeterPreviousCost = json['TSEMeterPreviousCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['month'] = month;
    data['LVPMeterCurrent'] = lVPMeterCurrent;
    data['LVPMeterPrevious'] = lVPMeterPrevious;
    data['LVPMeterCurrentCost'] = lVPMeterCurrentCost;
    data['LVPMeterPreviousCost'] = lVPMeterPreviousCost;
    data['LVPSubMeterCurrent'] = lVPSubMeterCurrent;
    data['LVPSubMeterPrevious'] = lVPSubMeterPrevious;
    data['LVPSubMeterCurrentCost'] = lVPSubMeterCurrentCost;
    data['LVPSubMeterPreviousCost'] = lVPSubMeterPreviousCost;
    data['DCPBTUMeterCurrent'] = dCPBTUMeterCurrent;
    data['DCPBTUMeterPrevious'] = dCPBTUMeterPrevious;
    data['DCPBTUMeterCurrentCost'] = dCPBTUMeterCurrentCost;
    data['DCPBTUMeterPreviousCost'] = dCPBTUMeterPreviousCost;
    data['WaterMeterCurrent'] = waterMeterCurrent;
    data['WaterMeterPrevious'] = waterMeterPrevious;
    data['WaterMeterCurrentCost'] = waterMeterCurrentCost;
    data['WaterMeterPreviousCost'] = waterMeterPreviousCost;
    data['TSEMeterCurrent'] = tSEMeterCurrent;
    data['TSEMeterPrevious'] = tSEMeterPrevious;
    data['TSEMeterCurrentCost'] = tSEMeterCurrentCost;
    data['TSEMeterPreviousCost'] = tSEMeterPreviousCost;
    return data;
  }
}
