import 'package:flutter/material.dart';

const PRIMARY_COLOR = Color(0xFF338F6C);
const PRIMARY_COLOR_LIGHTER = Color(0xFF62AC90);
const PRIMARY_LIGHT_COLOR = Color(0xFFE7F9F1);
const PRIMARY_GRADIENT_COLOR_TOP_TO_BOTTOM = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF35916E), Color(0xFF7FD0B1)],
);
const PRIMARY_GRADIENT_COLOR_BOTTOM_TO_TOP = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF7FD0B1), Color(0xFF35916E)],
);
const SECONDARY_COLOR = Color(0xFFFEC144);
const TEXT_COLOR = Color(0xFF757575);
const TEXT_COLOR_LIGHT = Color(0xFFA7A7A7);
const TEXT_COLOR_DARK = Color(0xFF373D3F);

const cAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
