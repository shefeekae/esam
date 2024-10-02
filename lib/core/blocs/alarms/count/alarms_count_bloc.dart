import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'alarms_count_event.dart';
part 'alarms_count_state.dart';

class AlarmsCountBloc extends Bloc<AlarmsCountEvent, AlarmsCountState> {
  AlarmsCountBloc() : super(AlarmsCountInitial(count: '')) {
    on<ChangeAlarmsCountEvent>((event, emit) {
      // TODO: implement event handler
      emit(AlarmsCountState(count: event.count));
    });
  }
}
