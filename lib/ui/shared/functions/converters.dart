class Converter {
  String largeLetterToSmall(String value) {
    return value.contains("@")
        ? '${value.split("@")[0][0].toUpperCase()}${value.split("@")[1][0].toUpperCase()}'
        : value.contains(" ")
            ? '${value.split(" ")[0][0].toUpperCase()}${value.split(" ")[1][0].toUpperCase()}'
            : '${value[0].toUpperCase()}${value.length == 1 ? "" : value[1].toUpperCase()}';
  }

  DateTime convertDoubleToDateTime(double value) {
    return DateTime.fromMillisecondsSinceEpoch(value.toInt());
  }

  String formatNumber(double value) {
    if (value >= 1000000000) {
      // Convert to billions
      return '${(value / 1000000000).toStringAsFixed(2)}B';
    } else if (value >= 1000000) {
      // Convert to millions
      return '${(value / 1000000).toStringAsFixed(2)}M';
    } else if (value >= 1000) {
      // Convert to thousands
      return '${(value / 1000).toStringAsFixed(2)}K';
    } else {
      return value.toStringAsFixed(2).replaceAll(RegExp(r'\.0*$'), '');
    }
  }
}
