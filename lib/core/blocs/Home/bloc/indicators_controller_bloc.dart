import 'package:bloc/bloc.dart';
part 'indicators_controller_event.dart';
part 'indicators_controller_state.dart';

class IndicatorsControllerBloc
    extends Bloc<IndicatorsControllerEvent, IndicatorsControllerState> {
  IndicatorsControllerBloc()
      : super(IndicatorsControllerInitial(map: {"machines": 0, "alarms": 0})) {
    on<ChangeValueIndicators>((event, emit) {
      state.map[event.key] = event.pageViewValue;

      // TODO: implement event handler
      emit(IndicatorsControllerState(map: state.map));
    });
  }
}
