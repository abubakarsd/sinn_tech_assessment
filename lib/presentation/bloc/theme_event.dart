import 'package:equatable/equatable.dart';

// The base class for all theme events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

// Event to toggle the theme between light and dark
class ToggleTheme extends ThemeEvent {}