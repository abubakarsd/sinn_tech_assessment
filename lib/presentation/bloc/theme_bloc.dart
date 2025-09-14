import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  // The initial state is the light theme
  ThemeBloc() : super(const LightThemeState()) {
    on<ToggleTheme>((event, emit) {
      // Toggle the theme between light and dark
      if (state is LightThemeState) {
        emit(const DarkThemeState());
      } else {
        emit(const LightThemeState());
      }
    });
  }
}
