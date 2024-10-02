class DiagnosisAndReportModel {
  List<GetEventDetailDiagnosis>? getEventDetailDiagnosis;

  DiagnosisAndReportModel({this.getEventDetailDiagnosis});

  DiagnosisAndReportModel.fromJson(Map<String, dynamic> json) {
    if (json['getEventDetailDiagnosis'] != null) {
      getEventDetailDiagnosis = <GetEventDetailDiagnosis>[];
      json['getEventDetailDiagnosis'].forEach((v) {
        getEventDetailDiagnosis!.add(GetEventDetailDiagnosis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getEventDetailDiagnosis != null) {
      data['getEventDetailDiagnosis'] =
          getEventDetailDiagnosis!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetEventDetailDiagnosis {
  String? diagnosticsId;
  String? eventId;
  String? sourceId;
  String? eventName;
  String? sourceType;
  int? eventTime;
  String? suggestion;
  Report? report;
  String? reason;
  int? insertionTime;

  GetEventDetailDiagnosis(
      {this.diagnosticsId,
      this.eventId,
      this.sourceId,
      this.eventName,
      this.sourceType,
      this.eventTime,
      this.suggestion,
      this.report,
      this.reason,
      this.insertionTime});

  GetEventDetailDiagnosis.fromJson(Map<String, dynamic> json) {
    diagnosticsId = json['diagnosticsId'];
    eventId = json['eventId'];
    sourceId = json['sourceId'];
    eventName = json['eventName'];
    sourceType = json['sourceType'];
    eventTime = json['eventTime'];
    suggestion = json['suggestion'];
    report = json['report'] != null ? Report.fromJson(json['report']) : null;
    reason = json['reason'];
    insertionTime = json['insertionTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['diagnosticsId'] = diagnosticsId;
    data['eventId'] = eventId;
    data['sourceId'] = sourceId;
    data['eventName'] = eventName;
    data['sourceType'] = sourceType;
    data['eventTime'] = eventTime;
    data['suggestion'] = suggestion;
    if (report != null) {
      data['report'] = report!.toJson();
    }
    data['reason'] = reason;
    data['insertionTime'] = insertionTime;
    return data;
  }
}

class Report {
  String? id;
  String? configurationName;
  String? sourceType;
  String? source;
  String? configId;
  String? status;
  String? reason;
  String? suggestion;
  List<Routines>? routines;

  Report(
      {this.id,
      this.configurationName,
      this.sourceType,
      this.source,
      this.configId,
      this.status,
      this.reason,
      this.suggestion,
      this.routines});

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    configurationName = json['configurationName'];
    sourceType = json['sourceType'];
    source = json['source'];
    configId = json['configId'];
    status = json['status'];
    reason = json['reason'];
    suggestion = json['suggestion'];
    if (json['routines'] != null) {
      routines = <Routines>[];
      json['routines'].forEach((v) {
        routines!.add(Routines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['configurationName'] = configurationName;
    data['sourceType'] = sourceType;
    data['source'] = source;
    data['configId'] = configId;
    data['status'] = status;
    data['reason'] = reason;
    data['suggestion'] = suggestion;
    if (routines != null) {
      data['routines'] = routines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Routines {
  String? id;
  String? name;
  bool? runOnConnection;
  String? condition;
  String? status;
  bool? success;
  List<Reports>? reports;
  List? suspects;
  int? precedence;
  String? description;
  bool? executionStatus;

  Routines(
      {this.id,
      this.name,
      this.runOnConnection,
      this.condition,
      this.status,
      this.success,
      this.reports,
      this.suspects,
      this.precedence,
      this.description,
      this.executionStatus});

  Routines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    runOnConnection = json['runOnConnection'];
    condition = json['condition'];
    status = json['status'];
    success = json['success'];
    if (json['reports'] != null) {
      reports = <Reports>[];
      json['reports'].forEach((v) {
        reports!.add(Reports.fromJson(v));
      });
    }
    suspects = json['suspects'];
    precedence = json['precedence'];
    description = json['description'];
    executionStatus = json['executionStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['runOnConnection'] = runOnConnection;
    data['condition'] = condition;
    data['status'] = status;
    data['success'] = success;
    if (reports != null) {
      data['reports'] = reports!.map((v) => v.toJson()).toList();
    }
    data['suspects'] = suspects;
    data['precedence'] = precedence;
    data['description'] = description;
    data['executionStatus'] = executionStatus;
    return data;
  }
}

class Reports {
  String? id;
  List? reason;
  List? suggestion;
  List? tools;
  List? skills;
  String? action;
  String? reportNature;
  String? actionPoint;
  String? writebackValue;

  Reports(
      {this.id,
      this.reason,
      this.suggestion,
      this.tools,
      this.skills,
      this.action,
      this.reportNature,
      this.actionPoint,
      this.writebackValue});

  Reports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    suggestion = json['suggestion'];
    tools = json['tools'];
    skills = json['skills'];
    action = json['action'];
    reportNature = json['reportNature'];
    actionPoint = json['actionPoint'];
    writebackValue = json['writebackValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reason'] = reason;
    data['suggestion'] = suggestion;
    data['tools'] = tools;
    data['skills'] = skills;
    data['action'] = action;
    data['reportNature'] = reportNature;
    data['actionPoint'] = actionPoint;
    data['writebackValue'] = writebackValue;
    return data;
  }
}

// Map<String, dynamic> diagnosisAndReportData = {
//   "getEventDetailDiagnosis": [
//     {
//       "diagnosticsId": "17f87089-df03-4b5f-ad43-2856091fa88d",
//       "eventId": "b9a76515-5449-315f-967f-737a3d9a709b",
//       "sourceId": "995ebabe-f99f-4133-8a29-d7527b4cff19",
//       "eventName": "Low Return Air Temperature",
//       "sourceType": "FanCoilUnit",
//       "eventTime": 1704895192720,
//       "suggestion": "Manually Change the fan speed to low ",
//       "report": {
//         "id": "04af7751-807e-4c4c-a243-3dce72a33997",
//         "configurationName": "Low Return Air Temperature",
//         "sourceType": "FanCoilUnit",
//         "source": "FanCoilUnit",
//         "configId": "d9851317-024e-436e-8343-c706318fa950",
//         "status": "ACTIVE",
//         "reason": "Fan Speed is not maintained in Low",
//         "suggestion": "Manually Change the fan speed to low ",
//         "routines": [
//           {
//             "id": "4930ed08-f050-4cbf-9540-ded5722e08df",
//             "name": "Modulating valve position verification",
//             "runOnConnection": false,
//             "condition": "%24%7BModulatingValvePosition%20%3D%3D%200%7D",
//             "status": "ACTIVE",
//             "success": false,
//             "reports": [
//               {
//                 "id": "76e20098-d480-4694-8800-ab01e698412d",
//                 "reason": ["Valve is not fully closed", "Valve may be stuck"],
//                 "suggestion": ["Check the valve position"],
//                 "tools": ["Multimeter", "Screw Driver"],
//                 "skills": ["HVAC Technician", "BMS Technician"],
//                 "action": "SITE_VERIFICATION",
//                 "actionPoint": "Valve Command",
//                 "writebackValue": "0",
//                 "reportNature": "FAILURE"
//               },
//               {
//                 "id": "05564b25-3023-4905-8185-b9ac39512a80",
//                 "reason": ["Modulating Valve is Closed"],
//                 "suggestion": [
//                   "Automatic Fault Diagnosis found no issues",
//                   "Site Verification is required",
//                   "Ensure Temperature Sensor is placed in Correct location",
//                   "Ensure Actuator is not stuck ",
//                   "Ensure cooling valve is not stuck"
//                 ],
//                 "tools": ["Multimeter", "Screwdriver", "Torch"],
//                 "skills": ["HVAC Technician"],
//                 "action": "SITE_VERIFICATION",
//                 "reportNature": "SUCCESS"
//               }
//             ],
//             "suspects": ["Modulating Valve Position"],
//             "precedence": 5,
//             "description": "Modulating valve position verification"
//           },
//           {
//             "id": "2ea6b1b2-7e02-4e42-a087-de5973661538",
//             "name": "Unit status verification",
//             "runOnConnection": false,
//             "condition": "%24%7BOnOffCommand%20%3D%3D%20%27On%27%7D",
//             "status": "ACTIVE",
//             "success": true,
//             "reports": [
//               {
//                 "id": "9b56b849-967e-4332-a2bf-0b560380acb2",
//                 "reason": ["Unit is not Running in Auto Mode"],
//                 "suggestion": ["Reset the Application Mode to Auto"],
//                 "tools": [],
//                 "skills": ["BMS Technician"],
//                 "action": "WRITEBACK",
//                 "actionPoint": "Fan Speed Command",
//                 "writebackValue": "Auto",
//                 "reportNature": "FAILURE"
//               },
//               {
//                 "id": "7b9c19dd-a89b-46af-b5fa-27e12a998efb",
//                 "reason": ["Unit is Operating in Auto Mode "],
//                 "suggestion": [],
//                 "tools": [],
//                 "skills": [],
//                 "action": "NO_ACTION_REQUIRED",
//                 "reportNature": "SUCCESS"
//               }
//             ],
//             "suspects": ["On Off Command"],
//             "precedence": 2,
//             "description": "Application Mode Verification",
//             "executionStatus": true
//           },
//           {
//             "id": "978d1d31-ec61-43a3-9109-da88a26e34be",
//             "name": "Return Temperature Sensor verification",
//             "runOnConnection": false,
//             "condition":
//                 "%24%7BReturnTemperature%20%3E%2010%20%26%26%20ReturnTemperature%20%3C%2040%7D",
//             "status": "ACTIVE",
//             "success": true,
//             "reports": [
//               {
//                 "id": "92b55e00-2517-4d81-bbe5-ce7e1750178c",
//                 "reason": [
//                   "Temperature Sensor is OK",
//                   "No abnormal spikes in Temperature sensor readings"
//                 ],
//                 "suggestion": [],
//                 "tools": [],
//                 "skills": [],
//                 "action": "NO_ACTION_REQUIRED",
//                 "reportNature": "SUCCESS"
//               },
//               {
//                 "id": "c982f1fa-d450-4c6f-b196-23164eeff8e7",
//                 "reason": [
//                   "Return Temperature Valve is out of the Global Range"
//                 ],
//                 "suggestion": [
//                   "Possible cause:",
//                   "1.\tSensor Drift",
//                   "2.\tSensor failure "
//                 ],
//                 "tools": ["Multimeter", "Screwdriver Set"],
//                 "skills": ["HVAC Technician"],
//                 "action": "SITE_VERIFICATION",
//                 "reportNature": "FAILURE"
//               }
//             ],
//             "suspects": ["Return Temperature"],
//             "precedence": 0,
//             "description": "Return Temperature Sensor verification",
//             "executionStatus": true
//           },
//           {
//             "id": "a87ed3ff-5af0-4193-99bc-0f38ae271262",
//             "name": "Return Temperature Set point Global Range Verification",
//             "runOnConnection": false,
//             "condition":
//                 "%24%7BReturnTemperatureSetpoint%20%3E%2016%20%26%26%20ReturnTemperatureSetpoint%20%3C%2028%7D",
//             "status": "ACTIVE",
//             "success": true,
//             "reports": [
//               {
//                 "id": "e86059a5-0323-4124-8926-a78873ef8155",
//                 "reason": [
//                   "Return temperature Setpoint is out of the Global Range 20 DegC - 28 DegC"
//                 ],
//                 "suggestion": [
//                   "Reset the Setpoint to a value between 20 DegC and 28 DegC"
//                 ],
//                 "tools": [],
//                 "skills": ["ESAM Operator"],
//                 "action": "WRITEBACK",
//                 "actionPoint": "Return Temperature Setpoint",
//                 "writebackValue": "24",
//                 "reportNature": "FAILURE"
//               },
//               {
//                 "id": "32462682-c475-4a2a-944b-8472acbb4ed4",
//                 "reason": [
//                   "Return Temperature Setpoint is maintained between 16 degC to 28 DegC"
//                 ],
//                 "suggestion": [],
//                 "tools": [],
//                 "skills": [],
//                 "action": "NO_ACTION_REQUIRED",
//                 "reportNature": "SUCCESS"
//               }
//             ],
//             "suspects": ["Return Temperature Setpoint"],
//             "precedence": 1,
//             "description":
//                 "Return Temperature Set point Global Range Verification",
//             "executionStatus": true
//           },
//           {
//             "id": "eaf9511e-554f-4b99-8199-7729e6f6a532",
//             "name": " Effective Fan Speed Verification",
//             "runOnConnection": false,
//             "condition": "%24%7BEffectiveFanIndication%20%3D%3D%20%27Low%27%7D",
//             "status": "ACTIVE",
//             "success": false,
//             "reports": [
//               {
//                 "id": "b02e951e-607a-4292-bcfc-828dc1e51f0d",
//                 "reason": ["Fan Speed is maintained at low"],
//                 "suggestion": [],
//                 "tools": [],
//                 "skills": [],
//                 "action": "NO_ACTION_REQUIRED",
//                 "reportNature": "SUCCESS"
//               },
//               {
//                 "id": "812fec01-0a07-4388-8599-d352d48ab076",
//                 "reason": ["Fan Speed is not maintained in Low"],
//                 "suggestion": ["Manually Change the fan speed to low "],
//                 "tools": [],
//                 "skills": ["BMS Technician"],
//                 "action": "SITE_VERIFICATION",
//                 "actionPoint": "Supervisory Fan Speed",
//                 "writebackValue": "Low",
//                 "reportNature": "FAILURE"
//               }
//             ],
//             "suspects": ["Effective Fan Indication"],
//             "precedence": 3,
//             "description": " Effective Fan Speed Verification",
//             "executionStatus": false
//           }
//         ]
//       },
//       "reason": "Fan Speed is not maintained in Low",
//       "insertionTime": 1704895202471
//     }
//   ]
// };
