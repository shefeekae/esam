// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'appbar_count_bloc.dart';

@immutable
abstract class AppbarCountEvent {}

// ignore: must_be_immutable
class ChangeAppBarCountEvent extends AppbarCountEvent {
  String count;
  ChangeAppBarCountEvent({
    required this.count,
  });
}
