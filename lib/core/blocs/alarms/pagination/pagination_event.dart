part of 'pagination_bloc.dart';

@immutable
abstract class PaginationEvent {}

class UpdateFetchMoreEvent extends PaginationEvent {
  final bool isCompleted;
  final int currentPage;

  UpdateFetchMoreEvent({
    this.isCompleted = false,
    this.currentPage = 0,
  });
}

class UpdateResultDataEvent extends PaginationEvent {
  final List<EventLogs> logDetails;

  UpdateResultDataEvent({
    required this.logDetails,
  });
}
