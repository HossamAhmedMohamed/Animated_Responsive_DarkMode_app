// ignore_for_file: await_only_futures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static final ThemeData _lightTheme = ThemeData.light();
  static final ThemeData _darkTheme = ThemeData.dark();

  ThemeCubit() : super(ThemeState(_lightTheme));

  void toggleTheme(bool isDark) {
    final themeData = isDark ? _darkTheme : _lightTheme;
    emit(ThemeState(themeData));

    _saveTheme(isDark);
  }

  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
  }

  static Future<bool> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getBool('isDark') ?? false;
  }

  Future<void> setInitialTheme() async {
    final isDark = await _loadTheme();
    final themeData = isDark ? _darkTheme : _lightTheme;
    emit(ThemeState(themeData));
  }
}
