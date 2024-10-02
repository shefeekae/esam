// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_bloc.dart';

class ThemeState {

   ThemMode mode;  
   
  ThemeState({
    required this.mode,
  });

 }

 class ThemeInitial extends ThemeState {
  ThemeInitial({required super.mode});
}
