// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'alarms_count_bloc.dart';

@immutable
abstract class AlarmsCountEvent {}

// ignore: must_be_immutable
class ChangeAlarmsCountEvent extends AlarmsCountEvent {
  String count;
  ChangeAlarmsCountEvent({
    required this.count,
  });
  
}
