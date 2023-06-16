import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
          fontSize: 32, fontFamily: 'Knewave', color: Color(0xFFFFFFFF)),
      headlineLarge: TextStyle(
          fontSize: 48, fontFamily: 'Knewave', color: Color(0xFFFFFFFF)),
      bodySmall: TextStyle(
          fontSize: 16, fontFamily: 'Kavoon', color: Color(0xFFFFFFFF)),
      bodyMedium: TextStyle(
          fontSize: 20, fontFamily: 'Kavoon', color: Color(0xFFFFFFFF)),
      bodyLarge: TextStyle(
          fontSize: 24, fontFamily: 'Kavoon', color: Color(0xFFFFFFFF)),
    ),
  );
}

BoxDecoration background() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFFFA800),
        Color(0xFFB94DBB),
      ],
      stops: [0.0, 0.7344],
    ),
  );
}
