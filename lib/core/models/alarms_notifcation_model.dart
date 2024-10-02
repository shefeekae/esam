class AlarmNotifcationModel {
  String? name;
  String? type;
  String? group;
  String? criticality;
  String? sourceId;
  String? sourceType;
  String? sourceTypeName;
  String? sourceName;
  String? sourceDomain;
  String? sourceTagPath;
  int? eventTime;
  int? eventDay;
  dynamic resolvedTime;
  dynamic duration;
  String? activeMessage;
  dynamic resolveMessage;
  bool? active;
  bool? recurring;
  bool? resolved;
  String? eventId;
  bool? acknowledged;
  String? clientDomain;
  String? clientName;
  String? eventDomain;
  String? location;
  bool? actionRequired;
  bool? actioned;
  String? suspectData;
  dynamic workOrderId;
  dynamic workOrderNo;
  String? assetCode;
  SuspectMap? suspectMap;
  bool? timeWaiting;
  String? configurationId;
  int? delay;
  dynamic annotations;
  dynamic tagids;
  String? title;
  String? notificationType;

  AlarmNotifcationModel(
      {this.name,
      this.type,
      this.group,
      this.criticality,
      this.sourceId,
      this.sourceType,
      this.sourceTypeName,
      this.sourceName,
      this.sourceDomain,
      this.sourceTagPath,
      this.eventTime,
      this.eventDay,
      this.resolvedTime,
      this.duration,
      this.activeMessage,
      this.resolveMessage,
      this.active,
      this.recurring,
      this.resolved,
      this.eventId,
      this.acknowledged,
      this.clientDomain,
      this.clientName,
      this.eventDomain,
      this.location,
      this.actionRequired,
      this.actioned,
      this.suspectData,
      this.workOrderId,
      this.workOrderNo,
      this.assetCode,
      this.suspectMap,
      this.timeWaiting,
      this.configurationId,
      this.delay,
      this.annotations,
      this.tagids,
      this.title,
      this.notificationType});

  AlarmNotifcationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    group = json['group'];
    criticality = json['criticality'];
    sourceId = json['sourceId'];
    sourceType = json['sourceType'];
    sourceTypeName = json['sourceTypeName'];
    sourceName = json['sourceName'];
    sourceDomain = json['sourceDomain'];
    sourceTagPath = json['sourceTagPath'];
    eventTime = json['eventTime'];
    eventDay = json['eventDay'];
    resolvedTime = json['resolvedTime'];
    duration = json['duration'];
    activeMessage = json['activeMessage'];
    resolveMessage = json['resolveMessage'];
    active = json['active'];
    recurring = json['recurring'];
    resolved = json['resolved'];
    eventId = json['eventId'];
    acknowledged = json['acknowledged'];
    clientDomain = json['clientDomain'];
    clientName = json['clientName'];
    eventDomain = json['eventDomain'];
    location = json['location'];
    actionRequired = json['actionRequired'];
    actioned = json['actioned'];
    suspectData = json['suspectData'];
    workOrderId = json['workOrderId'];
    workOrderNo = json['workOrderNo'];
    assetCode = json['assetCode'];
    suspectMap = json['suspectMap'] != null
        ? new SuspectMap.fromJson(json['suspectMap'])
        : null;
    timeWaiting = json['timeWaiting'];
    configurationId = json['configurationId'];
    delay = json['delay'];
    annotations = json['annotations'];
    tagids = json['tagids'];
    title = json['title'];
    notificationType = json['notificationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['group'] = this.group;
    data['criticality'] = this.criticality;
    data['sourceId'] = this.sourceId;
    data['sourceType'] = this.sourceType;
    data['sourceTypeName'] = this.sourceTypeName;
    data['sourceName'] = this.sourceName;
    data['sourceDomain'] = this.sourceDomain;
    data['sourceTagPath'] = this.sourceTagPath;
    data['eventTime'] = this.eventTime;
    data['eventDay'] = this.eventDay;
    data['resolvedTime'] = this.resolvedTime;
    data['duration'] = this.duration;
    data['activeMessage'] = this.activeMessage;
    data['resolveMessage'] = this.resolveMessage;
    data['active'] = this.active;
    data['recurring'] = this.recurring;
    data['resolved'] = this.resolved;
    data['eventId'] = this.eventId;
    data['acknowledged'] = this.acknowledged;
    data['clientDomain'] = this.clientDomain;
    data['clientName'] = this.clientName;
    data['eventDomain'] = this.eventDomain;
    data['location'] = this.location;
    data['actionRequired'] = this.actionRequired;
    data['actioned'] = this.actioned;
    data['suspectData'] = this.suspectData;
    data['workOrderId'] = this.workOrderId;
    data['workOrderNo'] = this.workOrderNo;
    data['assetCode'] = this.assetCode;
    if (this.suspectMap != null) {
      data['suspectMap'] = this.suspectMap!.toJson();
    }
    data['timeWaiting'] = this.timeWaiting;
    data['configurationId'] = this.configurationId;
    data['delay'] = this.delay;
    data['annotations'] = this.annotations;
    data['tagids'] = this.tagids;
    data['title'] = this.title;
    data['notificationType'] = this.notificationType;
    return data;
  }
}

class SuspectMap {
  int? temperature;
  dynamic fanHighCommand;
  String? fanLowStatus;
  dynamic fanLowCommand;
  dynamic powerOnOffCommand;
  dynamic fanMediumCommand;
  String? compressor2Status;
  String? fanHighStatus;
  String? compressor1Status;
  int? temperatureSetpoint;
  int? humidity;
  String? fanMediumStatus;
  String? powerOnOff;

  SuspectMap(
      {this.temperature,
      this.fanHighCommand,
      this.fanLowStatus,
      this.fanLowCommand,
      this.powerOnOffCommand,
      this.fanMediumCommand,
      this.compressor2Status,
      this.fanHighStatus,
      this.compressor1Status,
      this.temperatureSetpoint,
      this.humidity,
      this.fanMediumStatus,
      this.powerOnOff});

  SuspectMap.fromJson(Map<String, dynamic> json) {
    temperature = json['Temperature'];
    fanHighCommand = json['FanHighCommand'];
    fanLowStatus = json['FanLowStatus'];
    fanLowCommand = json['FanLowCommand'];
    powerOnOffCommand = json['PowerOnOffCommand'];
    fanMediumCommand = json['FanMediumCommand'];
    compressor2Status = json['Compressor2Status'];
    fanHighStatus = json['FanHighStatus'];
    compressor1Status = json['Compressor1Status'];
    temperatureSetpoint = json['TemperatureSetpoint'];
    humidity = json['Humidity'];
    fanMediumStatus = json['FanMediumStatus'];
    powerOnOff = json['PowerOnOff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Temperature'] = this.temperature;
    data['FanHighCommand'] = this.fanHighCommand;
    data['FanLowStatus'] = this.fanLowStatus;
    data['FanLowCommand'] = this.fanLowCommand;
    data['PowerOnOffCommand'] = this.powerOnOffCommand;
    data['FanMediumCommand'] = this.fanMediumCommand;
    data['Compressor2Status'] = this.compressor2Status;
    data['FanHighStatus'] = this.fanHighStatus;
    data['Compressor1Status'] = this.compressor1Status;
    data['TemperatureSetpoint'] = this.temperatureSetpoint;
    data['Humidity'] = this.humidity;
    data['FanMediumStatus'] = this.fanMediumStatus;
    data['PowerOnOff'] = this.powerOnOff;
    return data;
  }
}
