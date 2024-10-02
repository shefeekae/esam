// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pagination_bloc.dart';

class PaginationState {
  bool isCompleted;
  List<EventLogs> paginatedEventLogs;
  int currentPage;

  PaginationState({
    required this.isCompleted,
    required this.paginatedEventLogs,
    required this.currentPage,
  });

  PaginationState copyWith({
    bool? isCompleted,
    List<EventLogs>? paginatedEventLogs,
    int? currentPage,
  }) {
    return PaginationState(
      isCompleted: isCompleted ?? this.isCompleted,
      paginatedEventLogs: paginatedEventLogs ?? this.paginatedEventLogs,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class PaginationInitial extends PaginationState {
  PaginationInitial({
    required super.isCompleted,
    required super.paginatedEventLogs,
    required super.currentPage,
  });
}
