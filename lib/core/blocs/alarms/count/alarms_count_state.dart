// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'alarms_count_bloc.dart';

class AlarmsCountState {
  String count;
  AlarmsCountState({
    required this.count,
  });
}

class AlarmsCountInitial extends AlarmsCountState {
  AlarmsCountInitial({required super.count});
}
