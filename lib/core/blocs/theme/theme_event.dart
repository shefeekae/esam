// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_bloc.dart';

@immutable
class ThemeEvent {}

class ChangeThemeModeEvent extends ThemeEvent {
  final ThemMode themMode;
  ChangeThemeModeEvent({
    required this.themMode,
  });
  
}

class UpdateTheme extends ThemeEvent {
  
}
