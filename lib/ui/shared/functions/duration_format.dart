String formatDuration(Duration duration,{
  String hourSymbol = "h",
  String minutesSymbol = "m",
  String secondsSymbol = "s",
  
}) {
  String twoDigits(int n) => n.toString().padLeft(2, "");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  if (twoDigits(duration.inHours) == "0") {
    return "$twoDigitMinutes$minutesSymbol $twoDigitSeconds$secondsSymbol";
  }

  return "${twoDigits(duration.inHours)}$hourSymbol $twoDigitMinutes$minutesSymbol $twoDigitSeconds$secondsSymbol";
}
