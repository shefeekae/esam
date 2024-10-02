// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'suspectpoints_bloc.dart';

@immutable
abstract class SuspectpointsEvent {}

// ignore: must_be_immutable
class AddSuspectPointsEvent extends SuspectpointsEvent {
  List<SuspectPointsModel> list;
  List<SuspectPointsModel> livePointsList;
  String lastCommunicated;

  AddSuspectPointsEvent({
    required this.list,
    required this.livePointsList,
    required this.lastCommunicated,
  });
}
