// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'segmated_buttons_bloc.dart';

@immutable
abstract class SegmatedButtonsEvent {}

// ignore: must_be_immutable
class ChangeSegmatButtonGroupValue extends SegmatedButtonsEvent {
  String value;
  ChangeSegmatButtonGroupValue({
    required this.value,
  });
  
}
