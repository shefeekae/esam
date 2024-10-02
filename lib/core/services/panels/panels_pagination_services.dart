import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/core/models/panels/fire_panels_list_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:secure_storage/secure_storage.dart';
import '../graphql_services.dart';

class PanelsPaginationServices {
  final UserDataSingleton userData = UserDataSingleton();

  Future<void> getPanelsList({
    required PagingController pagingController,
    required int pageKey,
  }) async {
    var result = await GraphqlServices().performQuery(
      query: AssetSchema.getFirePanels,
      variables: {
        "data": {
          "domain": userData.domain,
          "offset": pageKey,
          "order": "asc",
          "sortField": "displayName",
          "pageSize": 10,
        }
      },
    );

    if (result.hasException) {
      pagingController.error = result.exception;
      return;
    }

    var firePanelModel = FirePanelModel.fromJson(result.data ?? {});

    // var firePanelModel = FirePanelModel.fromJson(panelData);

    GetFirePanels? getFirePanels = firePanelModel.getFirePanels;

    int? totalCount = getFirePanels?.totalAssetsCount;

    var firePanels = getFirePanels?.assets ?? [];

    if (totalCount == null) {
      pagingController.appendLastPage(firePanels);
      return;
    }

    var totalItems = pagingController.itemList ?? [];

    int totalValuesCount = totalItems.length + firePanels.length;

    if (totalValuesCount == totalCount) {
      pagingController.appendLastPage(firePanels);
    } else if (firePanels.isEmpty) {
      pagingController.appendLastPage([]);
    } else {
      pagingController.appendPage(
        firePanels,
        pageKey + 1,
      );
    }
  }
}

// Map<String, dynamic> panelData = {
//   "getFirePanels": {
//     "assets": [
//       {
//         "identifier": "8d5733d1-7f5c-4beb-8c31-aabb131d5e4c",
//         "clientDomain": "downtown",
//         "clientName": "Downtown Dubai",
//         "domain": "emaar",
//         "id":
//             "6ee2f1fc-d745-4280-b80d-32f0bb3fca0b-Burj Lofts Main Fire Panel MAIN PANEL MAIN FIRE PANEL",
//         "name":
//             "6ee2f1fc-d745-4280-b80d-32f0bb3fca0b-Burj Lofts Main Fire Panel MAIN PANEL MAIN FIRE PANEL",
//         "displayName": "Burj Lofts Main Fire Panel MAIN PANEL MAIN FIRE PANEL",
//         "type": "FACP",
//         "communicationStatus": "COMMUNICATING",
//         "criticalAlarm": false,
//         "lowAlarm": false,
//         "mediumAlarm": false,
//         "highAlarm": false,
//         "warningAlarm": false,
//         "serviceDue": false,
//         "documentExpire": false,
//         "createdOn": 1689178724409,
//         "dataTime": 1702430167335,
//         "points": [
//           {
//             "unit": "unitless",
//             "unitSymbol": "-",
//             "data": "Normal",
//             "pointName": "Silence Status",
//             "pointId": "8d5733d1-7f5c-4beb-8c31-aabb131d5e4c-Silence Status",
//             "dataType": "String",
//             "displayName":
//                 "8d5733d1-7f5c-4beb-8c31-aabb131d5e4c-Silence Status",
//             "type": "STRING",
//             "status": "ok",
//             "pointAccessType": "READONLY",
//             "precedence": "0",
//             "expression": ""
//           },
//           {
//             "unit": "unitless",
//             "unitSymbol": "-",
//             "data": "Normal",
//             "pointName": "Reset Status",
//             "pointId": "8d5733d1-7f5c-4beb-8c31-aabb131d5e4c-Reset Status",
//             "dataType": "String",
//             "displayName": "8d5733d1-7f5c-4beb-8c31-aabb131d5e4c-Reset Status",
//             "type": "STRING",
//             "status": "ok",
//             "pointAccessType": "READONLY",
//             "precedence": "0",
//             "expression": ""
//           },
//           {
//             "unit": "unitless",
//             "unitSymbol": "-",
//             "data": "Normal",
//             "pointName": "Restart status",
//             "pointId": "8d5733d1-7f5c-4beb-8c31-aabb131d5e4c-Restart status",
//             "dataType": "String",
//             "displayName":
//                 "8d5733d1-7f5c-4beb-8c31-aabb131d5e4c-Restart status",
//             "type": "STRING",
//             "status": "ok",
//             "pointAccessType": "READONLY",
//             "precedence": "0",
//             "expression": ""
//           },
//           {
//             "unit": "unitless",
//             "unitSymbol": "-",
//             "data": "Normal",
//             "pointName": "Common Alarm",
//             "pointId": "8d5733d1-7f5c-4beb-8c31-aabb131d5e4c-Common Alarm",
//             "dataType": "String",
//             "displayName": "8d5733d1-7f5c-4beb-8c31-aabb131d5e4c-Common Alarm",
//             "type": "STRING",
//             "status": "ok",
//             "pointAccessType": "READONLY",
//             "precedence": "0",
//             "expression": ""
//           },
//           {
//             "unit": "unitless",
//             "unitSymbol": "-",
//             "data": "Fault",
//             "pointName": "Common Fault",
//             "pointId": "8d5733d1-7f5c-4beb-8c31-aabb131d5e4c-Common Fault",
//             "dataType": "String",
//             "displayName": "8d5733d1-7f5c-4beb-8c31-aabb131d5e4c-Common Fault",
//             "type": "STRING",
//             "status": "ok",
//             "pointAccessType": "READONLY",
//             "precedence": "0",
//             "expression": ""
//           }
//         ],
//         "location": "POINT(55.269952 25.197636)",
//         "thingCode": "0103153",
//         "reason": "REALTIME_UPDATE",
//         "recent": true,
//         "sourceId": "136902967040980",
//         "underMaintenance": false,
//         "annotations": ["FAP", "BMS"],
//         "status": "ACTIVE",
//         "typeName": "Fire Alarm Control Panel",
//         "path": [
//           {
//             "name": "Downtown Dubai",
//             "entity": {
//               "type": "Community",
//               "data": {
//                 "identifier": "downtown",
//                 "domain": "emaar",
//                 "name": "Downtown Dubai",
//                 "parentType": "Community"
//               },
//               "identifier": "downtown",
//               "domain": "emaar"
//             }
//           },
//           {
//             "name": "The Lofts",
//             "entity": {
//               "type": "SubCommunity",
//               "data": {
//                 "identifier": "eafc116b-3adb-414a-812b-824112221a31",
//                 "domain": "emaar",
//                 "name": "The Lofts",
//                 "parentType": "SiteGroup"
//               },
//               "identifier": "eafc116b-3adb-414a-812b-824112221a31",
//               "domain": "emaar"
//             }
//           },
//           {
//             "name": "The Lofts East Tower",
//             "entity": {
//               "type": "ResidentialTower",
//               "data": {
//                 "identifier": "6ee2f1fc-d745-4280-b80d-32f0bb3fca0b",
//                 "domain": "emaar",
//                 "name": "The Lofts East Tower",
//                 "parentType": "Site"
//               },
//               "identifier": "6ee2f1fc-d745-4280-b80d-32f0bb3fca0b",
//               "domain": "emaar"
//             }
//           },
//           {
//             "name": "Burj Lofts Main Fire Panel MAIN PANEL MAIN FIRE PANEL",
//             "entity": {
//               "type": "FACP",
//               "data": {
//                 "identifier": "8d5733d1-7f5c-4beb-8c31-aabb131d5e4c",
//                 "domain": "emaar",
//                 "name": "Burj Lofts Main Fire Panel MAIN PANEL MAIN FIRE PANEL",
//                 "parentType": "Equipment"
//               },
//               "identifier": "8d5733d1-7f5c-4beb-8c31-aabb131d5e4c",
//               "domain": "emaar"
//             }
//           }
//         ],
//         "eventMap": {
//           "MSFD Damper Active": 213,
//           "Smoke Detector Dirty": 6,
//           "Zone Control Valve Active": 1,
//           "Head Missing": 77,
//           "Disabled": 52,
//           "Dirty": 41,
//           "WSO Active": 1,
//           "Common Fault": 828
//         },
//         "overtime": false
//       },
//       {
//         "identifier": "b1ccf324-823f-47cb-904c-3e9415f5e945",
//         "clientDomain": "marina",
//         "clientName": "Dubai Marina",
//         "domain": "emaar",
//         "id":
//             "385f1d81-d07c-4735-a2ba-7e653d883b1c-MTN1 Marina Towers Main FAS Panel MAIN PANEL",
//         "name":
//             "385f1d81-d07c-4735-a2ba-7e653d883b1c-MTN1 Marina Towers Main FAS Panel MAIN PANEL",
//         "displayName": "MTN1 Marina Towers Main FAS Panel MAIN PANEL",
//         "type": "FACP",
//         "communicationStatus": "COMMUNICATING",
//         "criticalAlarm": false,
//         "lowAlarm": false,
//         "mediumAlarm": false,
//         "highAlarm": false,
//         "warningAlarm": false,
//         "serviceDue": false,
//         "documentExpire": false,
//         "createdOn": 1699536844147,
//         "dataTime": 1707746823719,
//         "points": [
//           {
//             "unit": "unitless",
//             "unitSymbol": "-",
//             "data": "Normal",
//             "pointName": "Mains Status",
//             "pointId": "b1ccf324-823f-47cb-904c-3e9415f5e945-Mains Status",
//             "dataType": "String",
//             "displayName": "b1ccf324-823f-47cb-904c-3e9415f5e945-Mains Status",
//             "type": "STRING",
//             "status": "ok",
//             "pointAccessType": "READONLY",
//             "precedence": "0",
//             "expression": ""
//           },
//           {
//             "unit": "unitless",
//             "unitSymbol": "-",
//             "data": "Normal",
//             "pointName": "Silence Status",
//             "pointId": "b1ccf324-823f-47cb-904c-3e9415f5e945-Silence Status",
//             "dataType": "String",
//             "displayName":
//                 "b1ccf324-823f-47cb-904c-3e9415f5e945-Silence Status",
//             "type": "STRING",
//             "status": "ok",
//             "pointAccessType": "READONLY",
//             "precedence": "0",
//             "expression": ""
//           },
//           {
//             "unit": "unitless",
//             "unitSymbol": "-",
//             "data": "Normal",
//             "pointName": "Restart Status",
//             "pointId": "b1ccf324-823f-47cb-904c-3e9415f5e945-Restart Status",
//             "dataType": "String",
//             "displayName":
//                 "b1ccf324-823f-47cb-904c-3e9415f5e945-Restart Status",
//             "type": "STRING",
//             "status": "ok",
//             "pointAccessType": "READONLY",
//             "precedence": "0",
//             "expression": ""
//           },
//           {
//             "unit": "unitless",
//             "unitSymbol": "-",
//             "data": "Normal",
//             "pointName": "Communication Status",
//             "pointId":
//                 "b1ccf324-823f-47cb-904c-3e9415f5e945-Communication Status",
//             "dataType": "String",
//             "displayName":
//                 "b1ccf324-823f-47cb-904c-3e9415f5e945-Communication Status",
//             "type": "STRING",
//             "status": "ok",
//             "pointAccessType": "READONLY",
//             "precedence": "0",
//             "expression": ""
//           },
//           {
//             "unit": "unitless",
//             "unitSymbol": "-",
//             "data": "Fault",
//             "pointName": "Common Fault",
//             "pointId": "b1ccf324-823f-47cb-904c-3e9415f5e945-Common Fault",
//             "dataType": "String",
//             "displayName": "b1ccf324-823f-47cb-904c-3e9415f5e945-Common Fault",
//             "type": "STRING",
//             "status": "ok",
//             "pointAccessType": "READONLY",
//             "precedence": "0",
//             "expression": ""
//           },
//           {
//             "unit": "unitless",
//             "unitSymbol": "-",
//             "data": "Normal",
//             "pointName": "Reset Status",
//             "pointId": "b1ccf324-823f-47cb-904c-3e9415f5e945-Reset Status",
//             "dataType": "String",
//             "displayName": "b1ccf324-823f-47cb-904c-3e9415f5e945-Reset Status",
//             "type": "STRING",
//             "status": "ok",
//             "pointAccessType": "READONLY",
//             "precedence": "0",
//             "expression": ""
//           },
//           {
//             "unit": "unitless",
//             "unitSymbol": "-",
//             "data": "Normal",
//             "pointName": "Common Alarm",
//             "pointId": "b1ccf324-823f-47cb-904c-3e9415f5e945-Common Alarm",
//             "dataType": "String",
//             "displayName": "b1ccf324-823f-47cb-904c-3e9415f5e945-Common Alarm",
//             "type": "STRING",
//             "status": "ok",
//             "pointAccessType": "READONLY",
//             "precedence": "0",
//             "expression": ""
//           }
//         ],
//         "location": "POINT(55.14925 25.0853055555556)",
//         "reason": "REALTIME_UPDATE",
//         "recent": true,
//         "sourceId": "7c8334b6833c",
//         "underMaintenance": false,
//         "annotations": ["FAP", "BMS"],
//         "status": "ACTIVE",
//         "typeName": "Fire Alarm Control Panel",
//         "tags": ["Ground Floor", "BMS Room"],
//         "path": [
//           {
//             "name": "Dubai Marina",
//             "entity": {
//               "type": "Community",
//               "data": {
//                 "identifier": "marina",
//                 "domain": "emaar",
//                 "name": "Dubai Marina",
//                 "parentType": "Community"
//               },
//               "identifier": "marina",
//               "domain": "emaar"
//             }
//           },
//           {
//             "name": "Dubai Marina Towers",
//             "entity": {
//               "type": "SubCommunity",
//               "data": {
//                 "identifier": "91c60673-fde1-42ff-bd6a-0b7685f4c37d",
//                 "domain": "emaar",
//                 "name": "Dubai Marina Towers",
//                 "parentType": "SiteGroup"
//               },
//               "identifier": "91c60673-fde1-42ff-bd6a-0b7685f4c37d",
//               "domain": "emaar"
//             }
//           },
//           {
//             "name": "N1 Al Murjan Tower",
//             "entity": {
//               "type": "ResidentialTower",
//               "data": {
//                 "identifier": "385f1d81-d07c-4735-a2ba-7e653d883b1c",
//                 "domain": "emaar",
//                 "name": "N1 Al Murjan Tower",
//                 "parentType": "Site"
//               },
//               "identifier": "385f1d81-d07c-4735-a2ba-7e653d883b1c",
//               "domain": "emaar"
//             }
//           },
//           {
//             "name": "BMS Room",
//             "entity": {
//               "type": "Room",
//               "data": {
//                 "identifier": "97e213fa-1f01-46d5-9855-98e7ac385ec5",
//                 "domain": "emaar",
//                 "name": "BMS Room",
//                 "parentType": "Space"
//               },
//               "identifier": "97e213fa-1f01-46d5-9855-98e7ac385ec5",
//               "domain": "emaar"
//             }
//           },
//           {
//             "name": "Ground Floor",
//             "entity": {
//               "type": "Floor",
//               "data": {
//                 "identifier": "075c4482-857a-47f8-9d88-517cd64b1431",
//                 "domain": "emaar",
//                 "name": "Ground Floor",
//                 "parentType": "Space"
//               },
//               "identifier": "075c4482-857a-47f8-9d88-517cd64b1431",
//               "domain": "emaar"
//             }
//           },
//           {
//             "name": "MTN1 Marina Towers Main FAS Panel MAIN PANEL",
//             "entity": {
//               "type": "FACP",
//               "data": {
//                 "identifier": "b1ccf324-823f-47cb-904c-3e9415f5e945",
//                 "domain": "emaar",
//                 "name": "MTN1 Marina Towers Main FAS Panel MAIN PANEL",
//                 "parentType": "Equipment"
//               },
//               "identifier": "b1ccf324-823f-47cb-904c-3e9415f5e945",
//               "domain": "emaar"
//             }
//           }
//         ],
//         "eventMap": {
//           "RECURRING-Panel Silenced": 1,
//           "RECURRING-Panel Reset": 1,
//           "RECURRING-Fault Status": 1,
//           "Fault Status": 9,
//           "Common Fault": 35,
//           "RECURRING-Common Fault": 2
//         },
//         "overtime": false
//       }
//     ],
//     "totalAssetsCount": 2
//   }
// };
