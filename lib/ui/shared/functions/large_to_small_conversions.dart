import 'package:numeral/numeral.dart';

String largeToSmallCoversionValue(double value) {
  
  return Numeral(value).format(fractionDigits: 1);
}
