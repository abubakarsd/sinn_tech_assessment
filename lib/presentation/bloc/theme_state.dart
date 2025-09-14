import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// The base class for all theme states
abstract class ThemeState extends Equatable {
  final ThemeMode themeMode;
  const ThemeState({required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}

// State representing the light theme
class LightThemeState extends ThemeState {
  const LightThemeState() : super(themeMode: ThemeMode.light);
}

// State representing the dark theme
class DarkThemeState extends ThemeState {
  const DarkThemeState() : super(themeMode: ThemeMode.dark);
}
