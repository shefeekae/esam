import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'theme_event.dart';
part 'theme_state.dart';

enum ThemMode { light, dark }

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(mode: ThemMode.light)) {
    on<ChangeThemeModeEvent>((event, emit) {
      emit(ThemeState(mode: event.themMode));
    });

    on<UpdateTheme>((event, emit) {
      emit(ThemeState(mode: state.mode));
    });
  }
}
