import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const LightThemeState()) {
    on<ToggleTheme>((event, emit) {
      // To toggle the theme between light and dark
      if (state is LightThemeState) {
        emit(const DarkThemeState());
      } else {
        emit(const LightThemeState());
      }
    });
  }
}
