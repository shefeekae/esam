String getAlarmsPath(List sourceTagPathList) {
  List path = sourceTagPathList.where((element) {
    String parentType = element['parentType'] ?? "";

    return parentType == "Community" ||
        parentType == "SiteGroup" ||
        parentType == "Site" ||
        parentType == "Space" ||
        parentType == "Equipment";
  }).toList();

  return path.map((e) => e['name']).toList().join(" - ");
}
