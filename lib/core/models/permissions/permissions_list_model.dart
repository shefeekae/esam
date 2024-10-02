List<PermissionsModel> permissionlistModelfromJson(List list) {
  return list.map((e) => PermissionsModel.fromJson(e)).toList();
}

class PermissionsModel {
  String? name;
  String? accessCode;
  List<Features>? features;

  PermissionsModel({this.name, this.accessCode, this.features});

  PermissionsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    accessCode = json['accessCode'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['accessCode'] = this.accessCode;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  String? name;
  String? accessCode;
  List<Permissions>? permissions;

  Features({this.name, this.accessCode, this.permissions});

  Features.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    accessCode = json['accessCode'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(new Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['accessCode'] = this.accessCode;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  String? name;
  String? accessCode;

  Permissions({this.name, this.accessCode});

  Permissions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    accessCode = json['accessCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['accessCode'] = this.accessCode;
    return data;
  }
}
