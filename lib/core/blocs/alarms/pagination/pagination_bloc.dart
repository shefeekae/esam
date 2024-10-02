import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';

part 'pagination_event.dart';
part 'pagination_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  PaginationBloc()
      : super(PaginationInitial(
          isCompleted: false,
          paginatedEventLogs: [],
          currentPage: 1,
        )) {
    on<UpdateFetchMoreEvent>((event, emit) {
      // TODO: implement event handler
      emit(PaginationState(
        isCompleted: event.isCompleted,
        paginatedEventLogs: state.paginatedEventLogs,
        currentPage: event.currentPage,
      ));
    });

    on<UpdateResultDataEvent>((event, emit) {
      emit(PaginationState(
        isCompleted: state.isCompleted,
        paginatedEventLogs: event.logDetails,
        currentPage: state.currentPage,
      ));
    });
  }
}
