import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:nectar_assets/core/models/category_menu/category_item_model.dart';
import 'package:nectar_assets/core/services/category_menu/category_menu_services.dart';
import 'package:secure_storage/secure_storage.dart';
import '../../models/permissions/permissions_list_model.dart';

class UserPermissionServices {
// ==============================================
// Get permission categories menu list

  List<CategoryItem> getPermissionCategoriesMenuList() {
    return CategoryMenuServices()
        .categoriesList
        .where((element) => checkingPermission(
              featureGroup: element.featureGroup,
              feature: element.feature ?? "",
              permission: element.permission ?? "",
            ))
        .toList();
  }

//  ==========================================================
// Checking the user permission.

  bool checkingPermission({
    required String featureGroup,
    String feature = "",
    String permission = "",
  }) {
    List<PermissionsModel> permissionsList =
        permissionlistModelfromJson(userPermissionsList);

    PermissionsModel? permissionsModel = permissionsList
        .singleWhereOrNull((element) => element.name == featureGroup);

    if (permissionsModel != null) {
      if (feature.isEmpty && permission.isEmpty) {
        return checkingAccessCode(permissionsModel.accessCode ?? "");
      }

      if (permission.isEmpty) {
        Features? featureModel = permissionsModel.features
            ?.singleWhereOrNull((element) => element.name == feature);

        if (featureModel != null) {
          return checkingAccessCode(featureModel.accessCode ?? "");
        }
        return false;
      }

      Features? featureModel = permissionsModel.features
          ?.singleWhereOrNull((element) => element.name == feature);

      Permissions? permissionData =
          featureModel?.permissions?.singleWhereOrNull(
        (element) => element.name == permission,
      );

      if (permissionData != null) {
        return checkingAccessCode(permissionData.accessCode ?? "");
      }
    }
    return false;
  }

  // ============================================================================
  // Checking Access Code

  bool checkingAccessCode(String accessCode) {
    String? data = SharedPrefrencesServices().getData(key: "userPermissions");

    if (data != null) {
      Map<String, dynamic> map = jsonDecode(data);

      List featureGroupCodes = map['featureGroupCodes'] ?? [];
      List featureCodes = map['featureCodes'] ?? [];
      List permissionCodes = map['permissionCodes'] ?? [];

      List<String> loginAccessCodes = [
        ...featureGroupCodes,
        ...featureCodes,
        ...permissionCodes
      ];
      return loginAccessCodes.any((element) => element == accessCode);
    }

    return false;
  }
}

List<Map<String, dynamic>> userPermissionsList = [
  {
    "name": "spaceManagement",
    "accessCode": "vTAB",
    "features": [
      {
        "name": "spaceGroup",
        "accessCode": "msbG",
        "permissions": [
          {"name": "list", "accessCode": "HURG"},
          {"name": "delete", "accessCode": "VQVz"},
          {"name": "create", "accessCode": "xpAu"},
          {"name": "update", "accessCode": "IQtp"},
          {"name": "view", "accessCode": "xNNb"}
        ]
      },
      {
        "name": "spaces",
        "accessCode": "dJIk",
        "permissions": [
          {"name": "delete", "accessCode": "ZsRe"},
          {"name": "view", "accessCode": "iRkn"},
          {"name": "create", "accessCode": "PrFh"},
          {"name": "list", "accessCode": "BPCL"},
          {"name": "update", "accessCode": "JFgs"},
          {"name": "dashboard", "accessCode": "iFdQ"}
        ]
      },
      {
        "name": "spaceType",
        "accessCode": "xMxn",
        "permissions": [
          {"name": "delete", "accessCode": "UqXV"},
          {"name": "list", "accessCode": "TIBF"},
          {"name": "create", "accessCode": "hTpc"},
          {"name": "view", "accessCode": "iIeR"},
          {"name": "update", "accessCode": "YPor"}
        ]
      }
    ]
  },
  {
    "name": "assetManagement",
    "accessCode": "cBVp",
    "features": [
      {
        "name": "assetGroup",
        "accessCode": "lEeY",
        "permissions": [
          {"name": "create", "accessCode": "VBbL"},
          {"name": "list", "accessCode": "qYkb"},
          {"name": "update", "accessCode": "BHYW"},
          {"name": "delete", "accessCode": "QCaS"},
          {"name": "view", "accessCode": "roOF"}
        ]
      },
      {
        "name": "assetType",
        "accessCode": "lidI",
        "permissions": [
          {"name": "create", "accessCode": "SKxQ"},
          {"name": "delete", "accessCode": "wMWu"},
          {"name": "list", "accessCode": "VmIV"},
          {"name": "view", "accessCode": "AfdX"},
          {"name": "update", "accessCode": "ejww"}
        ]
      },
      {
        "name": "parameterConfig",
        "accessCode": "FRAt",
        "permissions": [
          {"name": "create", "accessCode": "yNaF"},
          {"name": "delete", "accessCode": "WHEr"},
          {"name": "list", "accessCode": "nzPk"},
          {"name": "view", "accessCode": "gmkB"},
          {"name": "update", "accessCode": "ZXon"}
        ]
      },
      {
        "name": "templating",
        "accessCode": "BCFQ",
        "permissions": [
          {"name": "create", "accessCode": "KJaW"},
          {"name": "delete", "accessCode": "hVVi"},
          {"name": "list", "accessCode": "lxRL"},
          {"name": "view", "accessCode": "TFYx"},
          {"name": "update", "accessCode": "fyjE"}
        ]
      },
      {
        "name": "dashboard",
        "accessCode": "RDll",
        "permissions": [
          {"name": "view", "accessCode": "SgRd"},
          {"name": "insights", "accessCode": "TLJC"},
          {"name": "insightsNew", "accessCode": "JVBF"},
          {"name": "workOrders", "accessCode": "sQPu"},
          {"name": "notes", "accessCode": "OxLw"},
          {"name": "historian", "accessCode": "oZSG"},
          {"name": "live", "accessCode": "JocK"},
          {"name": "timeline", "accessCode": "PzRT"},
          {"name": "maintenance", "accessCode": "kPyF"},
          {"name": "attachHistory", "accessCode": "JBfd"},
          {"name": "connectedAssets", "accessCode": "FhDF"}
        ]
      },
      {
        "name": "system",
        "accessCode": "qQuD",
        "permissions": [
          {"name": "create", "accessCode": "hEDZ"},
          {"name": "update", "accessCode": "DhrA"},
          {"name": "list", "accessCode": "qNVK"},
          {"name": "delete", "accessCode": "hLon"},
          {"name": "view", "accessCode": "JbQV"}
        ]
      },
      {
        "name": "points",
        "accessCode": "IxaQ",
        "permissions": [
          {"name": "view", "accessCode": "VNwt"},
          {"name": "list", "accessCode": "oOHK"},
          {"name": "update", "accessCode": "NZob"},
          {"name": "delete", "accessCode": "GpyD"},
          {"name": "create", "accessCode": "dSYs"}
        ]
      },
      {
        "name": "assetList",
        "accessCode": "eocH",
        "permissions": [
          {"name": "create", "accessCode": "vbwr"},
          {"name": "view", "accessCode": "Bqvw"},
          {"name": "list", "accessCode": "iQzz"},
          {"name": "delete", "accessCode": "ykfD"},
          {"name": "update", "accessCode": "dskl"},
          {"name": "qrExport", "accessCode": "Uvyr"}
        ]
      },
      {
        "name": "simCards",
        "accessCode": "UAlw",
        "permissions": [
          {"name": "create", "accessCode": "xgbB"},
          {"name": "view", "accessCode": "pDzm"},
          {"name": "list", "accessCode": "rQzr"},
          {"name": "delete", "accessCode": "CEgj"},
          {"name": "update", "accessCode": "VIBB"}
        ]
      },
      {
        "name": "sensors",
        "accessCode": "MaIq",
        "permissions": [
          {"name": "create", "accessCode": "ipcr"},
          {"name": "view", "accessCode": "uzWn"},
          {"name": "list", "accessCode": "xOaQ"},
          {"name": "delete", "accessCode": "mxYf"},
          {"name": "update", "accessCode": "BDZO"}
        ]
      },
      {
        "name": "generateReport",
        "accessCode": "wCCw",
        "permissions": [
          {"name": "view", "accessCode": "rSkX"}
        ]
      },
      {
        "name": "updateAssetSettings",
        "accessCode": "jBnJ",
        "permissions": [
          {"name": "update", "accessCode": "vYzK"}
        ]
      },
      {
        "name": "assetTags",
        "accessCode": "XqeV",
        "permissions": [
          {"name": "create", "accessCode": "JWIc"},
          {"name": "update", "accessCode": "HvNC"},
          {"name": "list", "accessCode": "rQEz"},
          {"name": "delete", "accessCode": "ckXX"},
          {"name": "view", "accessCode": "xZpk"}
        ]
      },
      {
        "name": "assetNotes",
        "accessCode": "vIIQ",
        "permissions": [
          {"name": "view", "accessCode": "ZtcD"},
          {"name": "create", "accessCode": "aULc"}
        ]
      }
    ]
  },
  {
    "name": "contactManagemnt",
    "accessCode": "BPpW",
    "features": [
      {
        "name": "contact",
        "accessCode": "zCMg",
        "permissions": [
          {"name": "view", "accessCode": "aIsk"},
          {"name": "list", "accessCode": "yFEk"},
          {"name": "delete", "accessCode": "lUXF"},
          {"name": "create", "accessCode": "KYWn"},
          {"name": "update", "accessCode": "YeVl"}
        ]
      }
    ]
  },
  {
    "name": "irm",
    "accessCode": "qHXE",
    "features": [
      {
        "name": "lake",
        "accessCode": "uMUB",
        "permissions": [
          {"name": "view", "accessCode": "mhlY"}
        ]
      },
      {
        "name": "swimmingPool",
        "accessCode": "NENT",
        "permissions": [
          {"name": "view", "accessCode": "kFJu"}
        ]
      },
      {
        "name": "pumpingStations",
        "accessCode": "aqEP",
        "permissions": [
          {"name": "view", "accessCode": "IzaU"}
        ]
      }
    ]
  },
  {
    "name": "graphics",
    "accessCode": "FglZ",
    "features": [
      {
        "name": "graphics",
        "accessCode": "fuya",
        "permissions": [
          {"name": "create", "accessCode": "RPxL"},
          {"name": "view", "accessCode": "bEuM"}
        ]
      },
      {
        "name": "graphicsV2",
        "accessCode": "hyuF",
        "permissions": [
          {"name": "create", "accessCode": "gEWn"},
          {"name": "view", "accessCode": "qGan"},
          {"name": "delete", "accessCode": "Ejtu"}
        ]
      },
      {
        "name": "graphics3D",
        "accessCode": "rPZK",
        "permissions": [
          {"name": "create", "accessCode": "jOqh"},
          {"name": "view", "accessCode": "fSeh"},
          {"name": "delete", "accessCode": "qtbf"}
        ]
      }
    ]
  },
  {
    "name": "serviceManagement",
    "accessCode": "TrzE",
    "features": [
      {
        "name": "serviceTemplate",
        "accessCode": "snqs",
        "permissions": [
          {"name": "view", "accessCode": "nXVN"},
          {"name": "list", "accessCode": "cmsA"},
          {"name": "update", "accessCode": "NiYz"},
          {"name": "create", "accessCode": "DNDo"},
          {"name": "delete", "accessCode": "Ntwm"}
        ]
      },
      {
        "name": "serviceItem",
        "accessCode": "yIal",
        "permissions": [
          {"name": "delete", "accessCode": "Ihji"},
          {"name": "update", "accessCode": "LfKP"},
          {"name": "list", "accessCode": "Vycm"},
          {"name": "create", "accessCode": "xzml"},
          {"name": "view", "accessCode": "rjFS"}
        ]
      },
      {
        "name": "servicePart",
        "accessCode": "NgyO",
        "permissions": [
          {"name": "delete", "accessCode": "qdRx"},
          {"name": "update", "accessCode": "NUlz"},
          {"name": "list", "accessCode": "HTBH"},
          {"name": "create", "accessCode": "atKZ"},
          {"name": "view", "accessCode": "IoQf"},
          {"name": "export", "accessCode": "TNRM"},
          {"name": "partsHistory", "accessCode": "EPlu"}
        ]
      },
      {
        "name": "serviceLogs",
        "accessCode": "qzFb",
        "permissions": [
          {"name": "view", "accessCode": "xngF"},
          {"name": "acknowldgeService", "accessCode": "wIWo"}
        ]
      },
      {
        "name": "serviceComponent",
        "accessCode": "JEcA",
        "permissions": [
          {"name": "view", "accessCode": "WELz"},
          {"name": "update", "accessCode": "LMIw"},
          {"name": "list", "accessCode": "aojV"},
          {"name": "delete", "accessCode": "KUal"},
          {"name": "create", "accessCode": "gkdX"}
        ]
      },
      {
        "name": "notificationTemplate",
        "accessCode": "EQiO",
        "permissions": [
          {"name": "view", "accessCode": "mGrN"},
          {"name": "create", "accessCode": "HrHJ"},
          {"name": "update", "accessCode": "evvi"},
          {"name": "list", "accessCode": "zYNB"},
          {"name": "delete", "accessCode": "Wfdp"}
        ]
      },
      {
        "name": "attachService",
        "accessCode": "urlT",
        "permissions": [
          {"name": "view", "accessCode": "YEjm"},
          {"name": "attach", "accessCode": "muOf"}
        ]
      }
    ]
  },
  {
    "name": "geofenceManagement",
    "accessCode": "FKZf",
    "features": [
      {
        "name": "geofence",
        "accessCode": "ZCiI",
        "permissions": [
          {"name": "delete", "accessCode": "hcHP"},
          {"name": "view", "accessCode": "REft"},
          {"name": "list", "accessCode": "asjI"},
          {"name": "update", "accessCode": "zEXP"},
          {"name": "create", "accessCode": "Afol"}
        ]
      },
      {
        "name": "configuration",
        "accessCode": "vfcz",
        "permissions": [
          {"name": "delete", "accessCode": "IiCI"},
          {"name": "view", "accessCode": "BYjk"},
          {"name": "list", "accessCode": "xhcS"},
          {"name": "update", "accessCode": "EPhX"},
          {"name": "create", "accessCode": "CBMb"}
        ]
      }
    ]
  },
  {
    "name": "alarmManagement",
    "accessCode": "Hier",
    "features": [
      {
        "name": "insights",
        "accessCode": "sGAu",
        "permissions": [
          {"name": "view", "accessCode": "ftUq"}
        ]
      },
      {
        "name": "list",
        "accessCode": "caRK",
        "permissions": [
          {"name": "acknowledge", "accessCode": "GxfC"},
          {"name": "view", "accessCode": "ngqR"},
          {"name": "syncWO", "accessCode": "CDRJ"},
          {"name": "list", "accessCode": "qzHG"},
          {"name": "Comment", "accessCode": "STKQ"}
        ]
      },
      {
        "name": "tags",
        "accessCode": "nFkA",
        "permissions": [
          {"name": "delete", "accessCode": "XTNZ"},
          {"name": "list", "accessCode": "iiAE"},
          {"name": "update", "accessCode": "mNJv"},
          {"name": "view", "accessCode": "gmtn"},
          {"name": "create", "accessCode": "XxbO"}
        ]
      }
    ]
  },
  {
    "name": "userManagement",
    "accessCode": "WsIl",
    "features": [
      {
        "name": "user",
        "accessCode": "fsLv",
        "permissions": [
          {"name": "delete", "accessCode": "BBog"},
          {"name": "list", "accessCode": "vSPc"},
          {"name": "update", "accessCode": "WjDD"},
          {"name": "view", "accessCode": "CoXG"},
          {"name": "create", "accessCode": "JhRx"}
        ]
      },
      {
        "name": "role",
        "accessCode": "ByoE",
        "permissions": [
          {"name": "list", "accessCode": "vpLL"},
          {"name": "update", "accessCode": "ihys"},
          {"name": "delete", "accessCode": "LNIi"},
          {"name": "view", "accessCode": "ntEj"},
          {"name": "create", "accessCode": "hRmR"}
        ]
      },
      {
        "name": "permission",
        "accessCode": "TueL",
        "permissions": [
          {"name": "view", "accessCode": "TMyJ"}
        ]
      }
    ]
  },
  {
    "name": "jobManagement",
    "accessCode": "nASx",
    "features": [
      {
        "name": "job",
        "accessCode": "PCPy",
        "permissions": [
          {"name": "update", "accessCode": "OafW"},
          {"name": "create", "accessCode": "DvYQ"},
          {"name": "list", "accessCode": "Iqiw"},
          {"name": "delete", "accessCode": "TZYh"},
          {"name": "view", "accessCode": "zwNc"},
          {"name": "export", "accessCode": "MTTc"},
          {"name": "jobCard", "accessCode": "jcOy"},
          {"name": "viewComment", "accessCode": "zHbf"},
          {"name": "addComment", "accessCode": "gciA"},
          {"name": "assignJob", "accessCode": "cAkG"},
          {"name": "assignMembers", "accessCode": "QtwY"},
          {"name": "startJob", "accessCode": "TfTP"},
          {"name": "holdJob", "accessCode": "zlCb"},
          {"name": "cancelJob", "accessCode": "vCKX"},
          {"name": "completeJob", "accessCode": "dWcp"},
          {"name": "closeJob", "accessCode": "CCKh"}
        ]
      },
      {
        "name": "jobInsights",
        "accessCode": "hJMf",
        "permissions": [
          {"name": "view", "accessCode": "rFiB"}
        ]
      },
      {
        "name": "checklistTemplates",
        "accessCode": "JPuz",
        "permissions": [
          {"name": "view", "accessCode": "caPl"},
          {"name": "update", "accessCode": "ejvk"},
          {"name": "create", "accessCode": "daJN"},
          {"name": "list", "accessCode": "vpfJ"},
          {"name": "delete", "accessCode": "WrKI"}
        ]
      }
    ]
  },
  {
    "name": "home",
    "accessCode": "YvHR",
    "features": [
      {
        "name": "home",
        "accessCode": "MSQU",
        "permissions": [
          {"name": "view", "accessCode": "uEDV"}
        ]
      }
    ]
  },
  {
    "name": "dcp",
    "accessCode": "kZDx",
    "features": [
      {
        "name": "ambientTemperature",
        "accessCode": "AUci",
        "permissions": [
          {"name": "view", "accessCode": "fuEB"}
        ]
      },
      {
        "name": "lowDeltaT",
        "accessCode": "zHCc",
        "permissions": [
          {"name": "view", "accessCode": "XtXo"}
        ]
      },
      {
        "name": "chilledWaterConsumption",
        "accessCode": "okEX",
        "permissions": [
          {"name": "view", "accessCode": "FYii"}
        ]
      },
      {
        "name": "chwInsights",
        "accessCode": "Jtkp",
        "permissions": [
          {"name": "view", "accessCode": "YzFj"}
        ]
      },
      {
        "name": "loadDistribution",
        "accessCode": "zsDs",
        "permissions": [
          {"name": "view", "accessCode": "NXRX"}
        ]
      },
      {
        "name": "averageDeltaT",
        "accessCode": "uaXa",
        "permissions": [
          {"name": "view", "accessCode": "JaWn"}
        ]
      }
    ]
  },
  {
    "name": "documentManagement",
    "accessCode": "wiKA",
    "features": [
      {
        "name": "document",
        "accessCode": "DQLA",
        "permissions": [
          {"name": "update", "accessCode": "XzQJ"},
          {"name": "view", "accessCode": "Zces"},
          {"name": "delete", "accessCode": "DfYf"},
          {"name": "list", "accessCode": "kSgq"},
          {"name": "create", "accessCode": "okkX"},
          {"name": "export", "accessCode": "ejBv"}
        ]
      }
    ]
  },
  {
    "name": "fileManagement",
    "accessCode": "MeFP",
    "features": [
      {
        "name": "assetDashboard",
        "accessCode": "MhzR",
        "permissions": [
          {"name": "view", "accessCode": "rKQV"}
        ]
      },
      {
        "name": "document",
        "accessCode": "GYpX",
        "permissions": [
          {"name": "update", "accessCode": "uPwZ"},
          {"name": "view", "accessCode": "zaWY"},
          {"name": "delete", "accessCode": "TItn"},
          {"name": "list", "accessCode": "KxeB"},
          {"name": "create", "accessCode": "NGVi"},
          {"name": "export", "accessCode": "zhzG"}
        ]
      },
      {
        "name": "systemFiles",
        "accessCode": "pkJV",
        "permissions": [
          {"name": "view", "accessCode": "MiyR"},
          {"name": "delete", "accessCode": "iyew"},
          {"name": "download", "accessCode": "kyUv"}
        ]
      },
      {
        "name": "otherFiles",
        "accessCode": "Omla",
        "permissions": [
          {"name": "view", "accessCode": "DOJP"},
          {"name": "delete", "accessCode": "HNYK"},
          {"name": "download", "accessCode": "tbLQ"},
          {"name": "create", "accessCode": "NUfO"}
        ]
      }
    ]
  },
  {
    "name": "dashboard",
    "accessCode": "YxkW",
    "features": [
      {
        "name": "utilities",
        "accessCode": "MMXp",
        "permissions": [
          {"name": "view", "accessCode": "kCfF"}
        ]
      },
      {
        "name": "energyIntensity",
        "accessCode": "sFNe",
        "permissions": [
          {"name": "view", "accessCode": "Qmvp"}
        ]
      },
      {
        "name": "energyReport",
        "accessCode": "pDKE",
        "permissions": [
          {"name": "view", "accessCode": "xFcw"}
        ]
      },
      {
        "name": "alarm",
        "accessCode": "GDQC",
        "permissions": [
          {"name": "view", "accessCode": "tyYc"}
        ]
      },
      {
        "name": "spaceAnalysis",
        "accessCode": "LmPd",
        "permissions": [
          {"name": "view", "accessCode": "fctC"}
        ]
      },
      {
        "name": "custom",
        "accessCode": "ExcG",
        "permissions": [
          {"name": "list", "accessCode": "LjtE"},
          {"name": "view", "accessCode": "YAhx"},
          {"name": "create", "accessCode": "Fvcc"},
          {"name": "update", "accessCode": "sODW"},
          {"name": "delete", "accessCode": "OYQq"}
        ]
      },
      {
        "name": "dataset",
        "accessCode": "NbJj",
        "permissions": [
          {"name": "list", "accessCode": "QBLA"},
          {"name": "view", "accessCode": "mAvT"},
          {"name": "create", "accessCode": "bKiN"},
          {"name": "update", "accessCode": "OPuA"},
          {"name": "delete", "accessCode": "veZF"}
        ]
      }
    ]
  },
  {
    "name": "airQuality",
    "accessCode": "BkGL",
    "features": [
      {
        "name": "dashboard",
        "accessCode": "RstZ",
        "permissions": [
          {"name": "view", "accessCode": "MVfC"}
        ]
      }
    ]
  },
  {
    "name": "gasMeter",
    "accessCode": "HwXx",
    "features": [
      {
        "name": "dashboard",
        "accessCode": "byNB",
        "permissions": [
          {"name": "view", "accessCode": "DmGw"}
        ]
      }
    ]
  },
  {
    "name": "eventConfiguration",
    "accessCode": "wVHZ",
    "features": [
      {
        "name": "assetEventConfiguration",
        "accessCode": "UejX",
        "permissions": [
          {"name": "list", "accessCode": "WnIF"},
          {"name": "create", "accessCode": "NBuM"},
          {"name": "update", "accessCode": "gjVV"},
          {"name": "delete", "accessCode": "kWue"},
          {"name": "view", "accessCode": "AVnj"},
          {"name": "configTypeSelection", "accessCode": "kxAG"}
        ]
      },
      {
        "name": "assetGroupEventConfiguration",
        "accessCode": "zoUw",
        "permissions": [
          {"name": "delete", "accessCode": "stas"},
          {"name": "view", "accessCode": "uuMf"},
          {"name": "list", "accessCode": "zYCR"},
          {"name": "create", "accessCode": "FUnc"},
          {"name": "update", "accessCode": "gLry"}
        ]
      },
      {
        "name": "assetTypeEventConfiguration",
        "accessCode": "rlnQ",
        "permissions": [
          {"name": "list", "accessCode": "eBvR"},
          {"name": "update", "accessCode": "nZeC"},
          {"name": "create", "accessCode": "FphV"},
          {"name": "view", "accessCode": "xdAB"},
          {"name": "delete", "accessCode": "Ynqq"}
        ]
      },
      {
        "name": "diagnosis",
        "accessCode": "jYqd",
        "permissions": [
          {"name": "view", "accessCode": "maOV"},
          {"name": "create", "accessCode": "NETo"},
          {"name": "update", "accessCode": "feWF"},
          {"name": "delete", "accessCode": "WSwo"}
        ]
      },
      {
        "name": "mitigation",
        "accessCode": "cHJA",
        "permissions": [
          {"name": "view", "accessCode": "WGsP"},
          {"name": "create", "accessCode": "YcmC"},
          {"name": "update", "accessCode": "VhVo"},
          {"name": "delete", "accessCode": "UObH"}
        ]
      },
      {
        "name": "notificationAndEscalation",
        "accessCode": "NyGa",
        "permissions": [
          {"name": "view", "accessCode": "dAZV"},
          {"name": "create", "accessCode": "fJGI"},
          {"name": "update", "accessCode": "CNUW"},
          {"name": "delete", "accessCode": "Jayw"}
        ]
      }
    ]
  },
  {
    "name": "notificationCenter",
    "accessCode": "jUOw",
    "features": [
      {
        "name": "notifications",
        "accessCode": "aMtv",
        "permissions": [
          {"name": "view", "accessCode": "ZBdK"}
        ]
      }
    ]
  },
  {
    "name": "clientManagement",
    "accessCode": "gIjb",
    "features": [
      {
        "name": "clients",
        "accessCode": "OpaS",
        "permissions": [
          {"name": "update", "accessCode": "BpTS"},
          {"name": "view", "accessCode": "nIaC"},
          {"name": "delete", "accessCode": "saEy"},
          {"name": "list", "accessCode": "NRum"},
          {"name": "create", "accessCode": "GgwN"},
          {"name": "attachAsset", "accessCode": "rnCX"},
          {"name": "dashboard", "accessCode": "ixTg"}
        ]
      }
    ]
  },
  {
    "name": "btuMeterManagement",
    "accessCode": "zHnE",
    "features": [
      {
        "name": "btuMeter",
        "accessCode": "zGeZ",
        "permissions": [
          {"name": "view", "accessCode": "oOeA"}
        ]
      }
    ]
  },
  {
    "name": "chillerManagement",
    "accessCode": "PYdG",
    "features": [
      {
        "name": "chiller",
        "accessCode": "VHuC",
        "permissions": [
          {"name": "view", "accessCode": "YGfU"}
        ]
      }
    ]
  },
  {
    "name": "applicationAccess",
    "accessCode": "hMtS",
    "features": [
      {
        "name": "login",
        "accessCode": "iRhq",
        "permissions": [
          {"name": "web", "accessCode": "nhod"},
          {"name": "mobile", "accessCode": "buuK"}
        ]
      }
    ]
  },
  {
    "name": "siteGroupManagement",
    "accessCode": "zVuB",
    "features": [
      {
        "name": "siteGroup",
        "accessCode": "gZMa",
        "permissions": [
          {"name": "update", "accessCode": "mEZj"},
          {"name": "view", "accessCode": "DoOd"},
          {"name": "delete", "accessCode": "vVPJ"},
          {"name": "list", "accessCode": "xMLG"},
          {"name": "create", "accessCode": "TyKC"},
          {"name": "dashboard", "accessCode": "CWfC"}
        ]
      }
    ]
  },
  {
    "name": "vendorManagement",
    "accessCode": "NRpi",
    "features": [
      {
        "name": "vendors",
        "accessCode": "qWaS",
        "permissions": [
          {"name": "update", "accessCode": "RSZr"},
          {"name": "view", "accessCode": "ZZyL"},
          {"name": "delete", "accessCode": "nYxP"},
          {"name": "list", "accessCode": "qRgI"},
          {"name": "create", "accessCode": "LGaK"}
        ]
      },
      {
        "name": "equipmentAccessGroups",
        "accessCode": "JCec",
        "permissions": [
          {"name": "update", "accessCode": "NCyb"},
          {"name": "view", "accessCode": "dXWC"},
          {"name": "delete", "accessCode": "zhcI"},
          {"name": "list", "accessCode": "IHAY"},
          {"name": "create", "accessCode": "AejH"}
        ]
      },
      {
        "name": "users",
        "accessCode": "UMvA",
        "permissions": [
          {"name": "update", "accessCode": "jyqt"},
          {"name": "view", "accessCode": "yFFh"},
          {"name": "delete", "accessCode": "Nqij"},
          {"name": "list", "accessCode": "rTkF"},
          {"name": "create", "accessCode": "GDRF"}
        ]
      },
      {
        "name": "thirdPartyIntegration",
        "accessCode": "eevf",
        "permissions": [
          {"name": "list", "accessCode": "SYwv"},
          {"name": "view", "accessCode": "Ptxv"},
          {"name": "create", "accessCode": "JjIx"},
          {"name": "update", "accessCode": "iupU"},
          {"name": "delete", "accessCode": "ANNz"},
          {"name": "excelUpload", "accessCode": "tqdJ"}
        ]
      }
    ]
  },
  {
    "name": "siteManagement",
    "accessCode": "nRPN",
    "features": [
      {
        "name": "site",
        "accessCode": "dySz",
        "permissions": [
          {"name": "update", "accessCode": "Amxx"},
          {"name": "view", "accessCode": "cbch"},
          {"name": "delete", "accessCode": "tHMw"},
          {"name": "list", "accessCode": "rths"},
          {"name": "create", "accessCode": "FJNz"},
          {"name": "dashboard", "accessCode": "ButW"},
          {"name": "notConnectedCount", "accessCode": "Iawd"}
        ]
      }
    ]
  },
  {
    "name": "auditLogManagement",
    "accessCode": "rWnw",
    "features": [
      {
        "name": "auditLog",
        "accessCode": "GQhN",
        "permissions": [
          {"name": "list", "accessCode": "srZP"}
        ]
      }
    ]
  },
  {
    "name": "writebackManagement",
    "accessCode": "RtRQ",
    "features": [
      {
        "name": "writeback",
        "accessCode": "PaGU",
        "permissions": [
          {"name": "list", "accessCode": "Dcbq"},
          {"name": "create", "accessCode": "jvvU"},
          {"name": "view", "accessCode": "CSiT"},
          {"name": "revert", "accessCode": "tyvf"}
        ]
      }
    ]
  },
  {
    "name": "pointComparisonManagement",
    "accessCode": "uteM",
    "features": [
      {
        "name": "pointComparison",
        "accessCode": "MAsv",
        "permissions": [
          {"name": "view", "accessCode": "hJxk"}
        ]
      }
    ]
  },
  {
    "name": "manualDataCorrection",
    "accessCode": "oDgj",
    "features": [
      {
        "name": "manualEntry",
        "accessCode": "mXXg",
        "permissions": [
          {"name": "view", "accessCode": "Hgly"}
        ]
      },
      {
        "name": "bulkUpload",
        "accessCode": "EAJZ",
        "permissions": [
          {"name": "view", "accessCode": "YBbJ"}
        ]
      }
    ]
  },
  {
    "name": "assetReports",
    "accessCode": "tMnK",
    "features": [
      {
        "name": "generateReport",
        "accessCode": "ncbu",
        "permissions": [
          {"name": "generate", "accessCode": "qgGt"}
        ]
      }
    ]
  },
  {
    "name": "functionalAreas",
    "accessCode": "duuS",
    "features": [
      {
        "name": "etsRooms",
        "accessCode": "lRdo",
        "permissions": [
          {"name": "view", "accessCode": "dwJy"}
        ]
      },
      {
        "name": "chillers",
        "accessCode": "CgZd",
        "permissions": [
          {"name": "view", "accessCode": "mkUs"}
        ]
      },
      {
        "name": "swimmingPool",
        "accessCode": "BTaB",
        "permissions": [
          {"name": "view", "accessCode": "Zvxl"}
        ]
      },
      {
        "name": "pumpingStations",
        "accessCode": "LzuS",
        "permissions": [
          {"name": "view", "accessCode": "Diuj"}
        ]
      },
      {
        "name": "lake",
        "accessCode": "BTaB",
        "permissions": [
          {"name": "view", "accessCode": "Zvxl"}
        ]
      }
    ]
  },
  {
    "name": "metering",
    "accessCode": "Tnnu",
    "features": [
      {
        "name": "btuMeters",
        "accessCode": "aPJv",
        "permissions": [
          {"name": "view", "accessCode": "Fzcj"}
        ]
      }
    ]
  },
  {
    "name": "wasteManagement",
    "accessCode": "yBEx",
    "features": [
      {
        "name": "dashboard",
        "accessCode": "StUO",
        "permissions": [
          {"name": "view", "accessCode": "LDri"}
        ]
      },
      {
        "name": "bins",
        "accessCode": "IjJp",
        "permissions": [
          {"name": "list", "accessCode": "eNGD"},
          {"name": "view", "accessCode": "aFWm"},
          {"name": "create", "accessCode": "Ngaw"},
          {"name": "update", "accessCode": "Nvfs"},
          {"name": "delete", "accessCode": "tBbB"}
        ]
      }
    ]
  },
  {
    "name": "validator",
    "accessCode": "DMPw",
    "features": [
      {
        "name": "validator",
        "accessCode": "XtAx",
        "permissions": [
          {"name": "view", "accessCode": "XpOn"}
        ]
      }
    ]
  },
  {
    "name": "virtualMachines",
    "accessCode": "RDsM",
    "features": [
      {
        "name": "dashboard",
        "accessCode": "OcXm",
        "permissions": [
          {"name": "view", "accessCode": "oFSa"}
        ]
      }
    ]
  },
  {
    "name": "digitalTwinManagement",
    "accessCode": "ibqU",
    "features": [
      {
        "name": "digitalTwin",
        "accessCode": "Nyln",
        "permissions": [
          {"name": "list", "accessCode": "envr"},
          {"name": "create", "accessCode": "iFOz"},
          {"name": "view", "accessCode": "izua"},
          {"name": "update", "accessCode": "lqQX"},
          {"name": "delete", "accessCode": "SqAV"},
          {"name": "start", "accessCode": "sQZc"},
          {"name": "report", "accessCode": "ClYa"}
        ]
      }
    ]
  },
  {
    "name": "hotelManagement",
    "accessCode": "jTKY",
    "features": [
      {
        "name": "insights",
        "accessCode": "CXrs",
        "permissions": [
          {"name": "view", "accessCode": "DpIs"}
        ]
      },
      {
        "name": "reviews",
        "accessCode": "FwAS",
        "permissions": [
          {"name": "view", "accessCode": "wrfm"}
        ]
      }
    ]
  },
  {
    "name": "fireAlarmManagement",
    "accessCode": "YZXC",
    "features": [
      {
        "name": "dashboard",
        "accessCode": "URex",
        "permissions": [
          {"name": "view", "accessCode": "OWaE"}
        ]
      }
    ]
  },
  {
    "name": "smartCityManagement",
    "accessCode": "KRfT",
    "features": [
      {
        "name": "dashboard",
        "accessCode": "mhSR",
        "permissions": [
          {"name": "view", "accessCode": "YGby"}
        ]
      }
    ]
  },
  {
    "name": "billingManagement",
    "accessCode": "YwDk",
    "features": [
      {
        "name": "templates",
        "accessCode": "ZRpl",
        "permissions": [
          {"name": "list", "accessCode": "RzKT"},
          {"name": "view", "accessCode": "oifw"},
          {"name": "create", "accessCode": "TZXw"},
          {"name": "update", "accessCode": "JcsO"},
          {"name": "delete", "accessCode": "xFym"}
        ]
      },
      {
        "name": "schedules",
        "accessCode": "IcLk",
        "permissions": [
          {"name": "list", "accessCode": "LjzL"},
          {"name": "view", "accessCode": "GhrK"},
          {"name": "create", "accessCode": "pMjm"},
          {"name": "update", "accessCode": "wcjQ"},
          {"name": "delete", "accessCode": "wDLz"}
        ]
      },
      {
        "name": "tenants",
        "accessCode": "CiWj",
        "permissions": [
          {"name": "list", "accessCode": "hsQp"},
          {"name": "view", "accessCode": "VZfA"},
          {"name": "create", "accessCode": "YBDa"},
          {"name": "update", "accessCode": "WEWL"},
          {"name": "delete", "accessCode": "YSlY"}
        ]
      },
      {
        "name": "premises",
        "accessCode": "ViPD",
        "permissions": [
          {"name": "list", "accessCode": "ZEOT"},
          {"name": "view", "accessCode": "swmR"},
          {"name": "create", "accessCode": "Xwkb"},
          {"name": "update", "accessCode": "WXrh"},
          {"name": "delete", "accessCode": "hDPl"}
        ]
      },
      {
        "name": "billGroups",
        "accessCode": "iqan",
        "permissions": [
          {"name": "list", "accessCode": "zlYj"},
          {"name": "view", "accessCode": "pexG"},
          {"name": "create", "accessCode": "mxVf"},
          {"name": "update", "accessCode": "coDL"},
          {"name": "delete", "accessCode": "SpLo"}
        ]
      },
      {
        "name": "billGroupReports",
        "accessCode": "Nsjs",
        "permissions": [
          {"name": "list", "accessCode": "bJaI"},
          {"name": "view", "accessCode": "wHhK"},
          {"name": "create", "accessCode": "KpAD"},
          {"name": "update", "accessCode": "gGlk"},
          {"name": "delete", "accessCode": "xOoA"}
        ]
      },
      {
        "name": "communication",
        "accessCode": "rCXl",
        "permissions": [
          {"name": "sms", "accessCode": "lUGd"},
          {"name": "email", "accessCode": "LFVs"}
        ]
      }
    ]
  },
  {
    "name": "scheduler",
    "accessCode": "cuLq",
    "features": [
      {
        "name": "scheduler",
        "accessCode": "jZHT",
        "permissions": [
          {"name": "view", "accessCode": "sxtI"},
          {"name": "create", "accessCode": "MGfX"},
          {"name": "update", "accessCode": "Mjjp"},
          {"name": "delete", "accessCode": "hdNe"},
          {"name": "list", "accessCode": "RbdW"}
        ]
      }
    ]
  },
  {
    "name": "rosterManagement",
    "accessCode": "fvsI",
    "features": [
      {
        "name": "roster",
        "accessCode": "ppsc",
        "permissions": [
          {"name": "list", "accessCode": "DnWK"},
          {"name": "create", "accessCode": "MYhf"},
          {"name": "copy", "accessCode": "MYhf"},
          {"name": "update", "accessCode": "mOAn"},
          {"name": "delete", "accessCode": "FMUA"}
        ]
      },
      {
        "name": "shift",
        "accessCode": "HTWY",
        "permissions": [
          {"name": "list", "accessCode": "Kmph"},
          {"name": "view", "accessCode": "QZzf"},
          {"name": "create", "accessCode": "aUuc"},
          {"name": "update", "accessCode": "TUCZ"},
          {"name": "delete", "accessCode": "zgaX"}
        ]
      },
      {
        "name": "logs",
        "accessCode": "osTU",
        "permissions": [
          {"name": "list", "accessCode": "Tyld"}
        ]
      }
    ]
  },
  {
    "name": "chwEnergyAnalysis",
    "accessCode": "EWVL",
    "features": [
      {
        "name": "chwEnergyAnalysis",
        "accessCode": "Sict",
        "permissions": [
          {"name": "view", "accessCode": "LnbI"}
        ]
      }
    ]
  },
  {
    "name": "staticAssets",
    "accessCode": "ohZD",
    "features": [
      {
        "name": "list",
        "accessCode": "lnIX",
        "permissions": [
          {"name": "list", "accessCode": "YmPN"},
          {"name": "view", "accessCode": "IfrY"},
          {"name": "create", "accessCode": "fyRe"},
          {"name": "update", "accessCode": "EmJf"},
          {"name": "delete", "accessCode": "pNME"},
          {"name": "codeExport", "accessCode": "ddYx"}
        ]
      }
    ]
  },
  {
    "name": "serviceRequestManagement",
    "accessCode": "EVSi",
    "features": [
      {
        "name": "serviceRequests",
        "accessCode": "EJsU",
        "permissions": [
          {"name": "list", "accessCode": "Ucde"},
          {"name": "view", "accessCode": "sAFO"},
          {"name": "create", "accessCode": "WNJJ"},
          {"name": "update", "accessCode": "giVy"},
          {"name": "delete", "accessCode": "ALlX"},
          {"name": "export", "accessCode": "YAzz"},
          {"name": "close", "accessCode": "pRKj"},
          {"name": "assign", "accessCode": "Fgkr"},
          {"name": "rate", "accessCode": "TKHe"}
        ]
      },
      {
        "name": "tenantCustomers",
        "accessCode": "LPdv",
        "permissions": [
          {"name": "list", "accessCode": "uynq"},
          {"name": "view", "accessCode": "VsDD"},
          {"name": "create", "accessCode": "VOpJ"},
          {"name": "update", "accessCode": "MJKz"},
          {"name": "delete", "accessCode": "PVJT"},
          {"name": "export", "accessCode": "KQen"}
        ]
      }
    ]
  },
  {
    "name": "firePanelManagement",
    "accessCode": "crsh",
    "features": [
      {
        "name": "dashboard",
        "accessCode": "PfTQ",
        "permissions": [
          {"name": "view", "accessCode": "STzv"}
        ]
      }
    ]
  },
  {
    "name": "berthManagement",
    "accessCode": "LVcw",
    "features": [
      {
        "name": "tenants",
        "accessCode": "FTkz",
        "permissions": [
          {"name": "list", "accessCode": "bsol"},
          {"name": "view", "accessCode": "drlt"},
          {"name": "create", "accessCode": "UBtD"},
          {"name": "update", "accessCode": "pArw"},
          {"name": "delete", "accessCode": "YTAf"}
        ]
      },
      {
        "name": "premises",
        "accessCode": "aBHQ",
        "permissions": [
          {"name": "list", "accessCode": "CMGK"},
          {"name": "view", "accessCode": "XTAJ"},
          {"name": "create", "accessCode": "KFuN"},
          {"name": "update", "accessCode": "icnI"},
          {"name": "delete", "accessCode": "ERoC"}
        ]
      },
      {
        "name": "live",
        "accessCode": "jnfT",
        "permissions": [
          {"name": "list", "accessCode": "SjGn"},
          {"name": "update", "accessCode": "nFdB"},
          {"name": "writeback", "accessCode": "bYFP"}
        ]
      },
      {
        "name": "history",
        "accessCode": "kwbF",
        "permissions": [
          {"name": "list", "accessCode": "qbKk"}
        ]
      }
    ]
  },
  {
    "name": "subTenantManagement",
    "accessCode": "GUbJ",
    "features": [
      {
        "name": "subTenant",
        "accessCode": "ZcAr",
        "permissions": [
          {"name": "list", "accessCode": "pKRk"},
          {"name": "view", "accessCode": "mhJP"},
          {"name": "create", "accessCode": "ctxK"},
          {"name": "update", "accessCode": "ozmL"},
          {"name": "delete", "accessCode": "OeOm"}
        ]
      }
    ]
  }
];
