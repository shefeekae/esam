class MitigationModel {
  FindMitigationReport? findMitigationReport;

  MitigationModel({this.findMitigationReport});

  MitigationModel.fromJson(Map<String, dynamic> json) {
    findMitigationReport = json['findMitigationReport'] != null
        ? FindMitigationReport.fromJson(json['findMitigationReport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findMitigationReport != null) {
      data['findMitigationReport'] = findMitigationReport!.toJson();
    }
    return data;
  }
}

class FindMitigationReport {
  String? id;
  List<Steps>? steps;

  FindMitigationReport({this.id, this.steps});

  FindMitigationReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(Steps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (steps != null) {
      data['steps'] = steps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Steps {
  String? mitigationStepId;
  String? title;
  String? name;
  String? remark;
  List<SuccessItems>? successItems;
  List<FailedItems>? failedItems;
  bool? executionStatus;
  bool? terminateOnFailure;
  int? executionTime;

  Steps(
      {this.mitigationStepId,
      this.title,
      this.name,
      this.remark,
      this.successItems,
      this.failedItems,
      this.executionStatus,
      this.terminateOnFailure,
      this.executionTime});

  Steps.fromJson(Map<String, dynamic> json) {
    mitigationStepId = json['mitigationStepId'];
    title = json['title'];
    name = json['name'];
    remark = json['remark'];
    if (json['successItems'] != null) {
      successItems = <SuccessItems>[];
      json['successItems'].forEach((v) {
        successItems!.add(SuccessItems.fromJson(v));
      });
    }
    if (json['failedItems'] != null) {
      failedItems = <FailedItems>[];
      json['failedItems'].forEach((v) {
        failedItems!.add(FailedItems.fromJson(v));
      });
    }
    executionStatus = json['executionStatus'];
    terminateOnFailure = json['terminateOnFailure'];
    executionTime = json['executionTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mitigationStepId'] = mitigationStepId;
    data['title'] = title;
    data['remark'] = remark;
    if (successItems != null) {
      data['successItems'] = successItems!.map((v) => v.toJson()).toList();
    }
    if (failedItems != null) {
      data['failedItems'] = failedItems!.map((v) => v.toJson()).toList();
    }
    data['executionStatus'] = executionStatus;
    data['terminateOnFailure'] = terminateOnFailure;
    data['executionTime'] = executionTime;
    return data;
  }
}

class SuccessItems {
  String? type;
  Data? data;
  String? identifier;
  String? domain;

  SuccessItems({this.type, this.data, this.identifier, this.domain});

  SuccessItems.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    identifier = json['identifier'];
    domain = json['domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['identifier'] = identifier;
    data['domain'] = domain;
    return data;
  }
}

class FailedItems {
  String? type;
  Data? data;
  String? identifier;
  String? domain;

  FailedItems({this.type, this.data, this.identifier, this.domain});

  FailedItems.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    identifier = json['identifier'];
    domain = json['domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['identifier'] = identifier;
    data['domain'] = domain;
    return data;
  }
}

class Data {
  String? domain;
  String? identifier;
  String? displayName;

  Data({this.domain, this.identifier, this.displayName});

  Data.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    identifier = json['identifier'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['domain'] = domain;
    data['identifier'] = identifier;
    data['displayName'] = displayName;
    return data;
  }
}

// Map<String, dynamic> findMitigationReportData = {
//   "findMitigationReport": {
//     "id": "dfe39bff-cef6-3d1b-9d54-aa5b48605966",
//     "steps": [
//       {
//         "mitigationStepId": "ecf5dc1a-e248-41da-8a5e-76366a0e23b4",
//         "title": null,
//         "name": "Check FAHU Response",
//         "remark": null,
//         "successItems": null,
//         "failedItems": null,
//         "executionStatus": false,
//         "terminateOnFailure": false,
//         "executionTime": 1704851249689
//       },
//       {
//         "mitigationStepId": "eb9297ad-1472-4aa5-81b6-25ffb4f32c1f",
//         "title": "Check Staircase Pressurization Fans",
//         "name": "Check Staircase Pressurization Fans",
//         "remark": "Staircase Pressurization Fans did not Activate",
//         "successItems": [],
//         "failedItems": [
//           {
//             "type": "SPF",
//             "data": {
//               "domain": "emaar",
//               "identifier": "5acd1d84-e474-41e3-9716-9b9ebfd59368",
//               "displayName": "E1 MMF SPF 01"
//             },
//             "identifier": "5acd1d84-e474-41e3-9716-9b9ebfd59368",
//             "domain": "emaar"
//           }
//         ],
//         "executionStatus": true,
//         "terminateOnFailure": false,
//         "executionTime": 1704855479163
//       },
//       {
//         "mitigationStepId": "8c5960de-c557-4534-a963-2babea315483",
//         "title": "Check Lift Pressurization Fans",
//         "name": "Check Lift Pressurization Fans",
//         "remark": "Lift Pressurization Fans did not activate",
//         "successItems": [],
//         "failedItems": [
//           {
//             "type": "LPF",
//             "data": {
//               "domain": "emaar",
//               "identifier": "952e49f0-e20b-4588-8e1f-022408b25883",
//               "displayName": "E1 MMF LPF 01"
//             },
//             "identifier": "952e49f0-e20b-4588-8e1f-022408b25883",
//             "domain": "emaar"
//           }
//         ],
//         "executionStatus": true,
//         "terminateOnFailure": false,
//         "executionTime": 1704855479163
//       },
//       {
//         "mitigationStepId": "9779975f-8242-4e57-a0b3-2546805bf7d7",
//         "title": "Check Elevators",
//         "name": "Check Elevators",
//         "remark":
//             "E1 2F Lift 04 : Common Fault : Normal\nE1 2F Lift 03 : Common Fault : Normal\nE1 MMF Lift 02 : Common Fault : Alarm\nE1 MMF Lift 01 : Common Fault : Alarm",
//         "successItems": [],
//         "failedItems": [],
//         "executionStatus": true,
//         "terminateOnFailure": false,
//         "executionTime": 1704855479163
//       },
//       {
//         "mitigationStepId": "289bfa76-264d-4b8a-aab3-bb1349252682",
//         "title": "Check Car Park Fan Response",
//         "name": "Check Car Park Fan Response",
//         "remark": "Car Park Fans High Speed did not activate",
//         "successItems": [],
//         "failedItems": [
//           {
//             "type": "CPEF",
//             "data": {
//               "domain": "emaar",
//               "identifier": "0a784dd8-ce30-4447-a297-f426a4254287",
//               "displayName": "E1 1F CPEF 04"
//             },
//             "identifier": "0a784dd8-ce30-4447-a297-f426a4254287",
//             "domain": "emaar"
//           },
//           {
//             "type": "CPEF",
//             "data": {
//               "domain": "emaar",
//               "identifier": "811a8c35-d14a-4dac-82f6-b137cd746996",
//               "displayName": "E1 B CPEF 01"
//             },
//             "identifier": "811a8c35-d14a-4dac-82f6-b137cd746996",
//             "domain": "emaar"
//           },
//           {
//             "type": "CPEF",
//             "data": {
//               "domain": "emaar",
//               "identifier": "181b45be-97d8-4d7b-a875-8c4f1b7791d9",
//               "displayName": "E1 LGF CPEF 02"
//             },
//             "identifier": "181b45be-97d8-4d7b-a875-8c4f1b7791d9",
//             "domain": "emaar"
//           },
//           {
//             "type": "CPEF",
//             "data": {
//               "domain": "emaar",
//               "identifier": "633086d6-6c30-49d5-89e6-dd2e2c018172",
//               "displayName": "E1 GF CPEF 03"
//             },
//             "identifier": "633086d6-6c30-49d5-89e6-dd2e2c018172",
//             "domain": "emaar"
//           }
//         ],
//         "executionStatus": true,
//         "terminateOnFailure": false,
//         "executionTime": 1704855479163
//       },
//       {
//         "mitigationStepId": "9b7362b9-2aef-42cd-9cc4-da3f123a5b4f",
//         "title": "Check RAHU Response",
//         "name": "Check RAHU Response",
//         "remark": "RAHUs are still running after 4 Minute of Fire Alarm",
//         "successItems": [],
//         "failedItems": [
//           {
//             "type": "RAHU",
//             "data": {
//               "domain": "emaar",
//               "identifier": "6cae7651-563e-4df4-929b-36f2c3b906be",
//               "displayName": "E1 1F RAHU 01"
//             },
//             "identifier": "6cae7651-563e-4df4-929b-36f2c3b906be",
//             "domain": "emaar"
//           },
//           {
//             "type": "RAHU",
//             "data": {
//               "domain": "emaar",
//               "identifier": "14c585ab-663b-4c72-b4f2-1ad3478ba524",
//               "displayName": "E1 2F RAHU 02"
//             },
//             "identifier": "14c585ab-663b-4c72-b4f2-1ad3478ba524",
//             "domain": "emaar"
//           }
//         ],
//         "executionStatus": true,
//         "terminateOnFailure": false,
//         "executionTime": 1704855479163
//       },
//       {
//         "mitigationStepId": "d9706d52-e8bf-4fcb-8de8-22eaa079597c",
//         "title": "Check PA System Response",
//         "name": "Check PA System Response",
//         "remark": null,
//         "successItems": [],
//         "failedItems": [],
//         "executionStatus": true,
//         "terminateOnFailure": false,
//         "executionTime": 1704855479163
//       },
//       {
//         "mitigationStepId": "3163c24f-1fde-4af0-a9c0-4993953c680e",
//         "title": "Check ACS Response ",
//         "name": "Check ACS Response ",
//         "remark":
//             "E1 B ACS 01 : Common Fault : Normal\nE1 B ACS 02 : Common Fault : Normal",
//         "successItems": [],
//         "failedItems": [],
//         "executionStatus": true,
//         "terminateOnFailure": false,
//         "executionTime": 1704855479163
//       },
//       {
//         "mitigationStepId": "9b38a81e-569c-4b24-8228-399aabe9064d",
//         "title": "Check LPG Response",
//         "name": "Check LPG Response",
//         "remark": null,
//         "successItems": [],
//         "failedItems": [],
//         "executionStatus": true,
//         "terminateOnFailure": false,
//         "executionTime": 1704855479163
//       }
//     ]
//   }
// };
