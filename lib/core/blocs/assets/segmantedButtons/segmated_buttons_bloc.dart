import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'segmated_buttons_event.dart';
part 'segmated_buttons_state.dart';

class SegmatedButtonsBloc
    extends Bloc<SegmatedButtonsEvent, SegmatedButtonsState> {
  SegmatedButtonsBloc() : super(SegmatedButtonsInitial()) {
    on<ChangeSegmatButtonGroupValue>((event, emit) {
      // TODO: implement event handler
      emit(SegmatedButtonsState(groupvalue: event.value));
    });
  }
}
