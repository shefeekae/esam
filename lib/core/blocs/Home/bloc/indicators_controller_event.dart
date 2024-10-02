// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'indicators_controller_bloc.dart';

class IndicatorsControllerEvent {}

class ChangeValueIndicators extends IndicatorsControllerEvent {
  int pageViewValue;
  String key;

  ChangeValueIndicators({
    required this.pageViewValue,
    required this.key,
  });
}
