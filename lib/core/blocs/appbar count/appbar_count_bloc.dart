import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'appbar_count_event.dart';
part 'appbar_count_state.dart';

class AppbarCountBloc extends Bloc<AppbarCountEvent, AppbarCountState> {
  AppbarCountBloc() : super(AppbarCountInitial(count: "")) {
    on<ChangeAppBarCountEvent>((event, emit) {
      // TODO: implement event handler
      emit(AppbarCountState(count: event.count));
    });
  }
}
