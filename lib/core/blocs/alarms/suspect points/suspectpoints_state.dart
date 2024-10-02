// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'suspectpoints_bloc.dart';

class SuspectpointsState {
  List<SuspectPointsModel> susectPointsList;
  List<SuspectPointsModel> pointsLiveList;
  String lastCommunicatedDateTime;

  SuspectpointsState({
    required this.susectPointsList,
    required this.pointsLiveList,
    required this.lastCommunicatedDateTime,
  });
}

class SuspectpointsInitial extends SuspectpointsState {
  SuspectpointsInitial({
    required super.susectPointsList,
    required super.pointsLiveList,
    required super.lastCommunicatedDateTime,
  });
}
