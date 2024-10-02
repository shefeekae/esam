import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/suspect_points_model.dart';

part 'suspectpoints_event.dart';
part 'suspectpoints_state.dart';

class SuspectpointsBloc extends Bloc<SuspectpointsEvent, SuspectpointsState> {
  SuspectpointsBloc()
      : super(SuspectpointsInitial(susectPointsList: [], pointsLiveList: [],lastCommunicatedDateTime: "")) {
    on<AddSuspectPointsEvent>((event, emit) {
      // TODO: implement event handler
      emit(SuspectpointsState(
        susectPointsList: event.list,
        pointsLiveList: event.livePointsList,
        lastCommunicatedDateTime: event.lastCommunicated,
      ));
    });
  }
}
