import 'package:flutter/material.dart';

// Dark Cyan Color Palette
class AppColors {
  // Primary Dark Cyan shades
  static const Color darkCyan = Color(0xFF00838F);
  static const Color darkCyanLight = Color(0xFF4FB3BF);
  static const Color darkCyanDark = Color(0xFF005662);

  // Accent colors that complement Dark Cyan
  static const Color accent = Color(0xFF00BCD4); // Lighter cyan for highlights
  static const Color accentLight = Color(0xFF62EFFF);
  static const Color accentDark = Color(0xFF008BA3);

  // Semantic colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  // Neutral colors for light theme
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF212121);
  static const Color lightOnBackground = Color(0xFF424242);

  // Neutral colors for dark theme
  static const Color darkBackground = Color(0xFF0E1117);
  static const Color darkSurface = Color(0xFF1A1F2E);
  static const Color darkOnSurface = Color(0xFFE8EAED);
  static const Color darkOnBackground = Color(0xFFDEE1E6);
}

// Light Theme
final lightThemeData = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,

  // Color Scheme
  colorScheme: ColorScheme.light(
    primary: AppColors.darkCyan,
    onPrimary: Colors.white,
    secondary: AppColors.accent,
    onSecondary: Colors.white,
    tertiary: AppColors.darkCyanLight,
    onTertiary: Colors.white,

    background: AppColors.lightBackground,
    onBackground: AppColors.lightOnBackground,
    surface: AppColors.lightSurface,
    onSurface: AppColors.lightOnSurface,

    error: AppColors.error,
    onError: Colors.white,

    outline: Colors.grey.shade300,
    outlineVariant: Colors.grey.shade200,

    surfaceVariant: Colors.grey.shade50,
    onSurfaceVariant: Colors.grey.shade700,
  ),

  // Scaffold
  scaffoldBackgroundColor: AppColors.lightBackground,

  // AppBar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.lightBackground,
    foregroundColor: AppColors.lightOnBackground,
    elevation: 2,
    shadowColor: AppColors.darkCyan.withOpacity(0.3),
    titleTextStyle: const TextStyle(
      color: Colors.black87,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
    actionsIconTheme: const IconThemeData(color: Colors.black87),
  ),

  // Bottom Navigation Bar
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color.fromARGB(255, 240, 240, 240),
    selectedItemColor: AppColors.darkCyan,
    unselectedItemColor: Colors.grey.shade600,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
  ),

  // Floating Action Button
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.darkCyan,
    foregroundColor: Colors.white,
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  // Elevated Button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkCyan,
      foregroundColor: Colors.white,
      elevation: 3,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),

  // Outlined Button
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.darkCyan,
      side: const BorderSide(color: AppColors.darkCyan, width: 2),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  // Text Button
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.darkCyan,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  ),

  // Input Decoration
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.darkCyan, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error, width: 2),
    ),
    labelStyle: TextStyle(color: Colors.grey.shade700),
    hintStyle: TextStyle(color: Colors.grey.shade500),
  ),

  // Card Theme
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 4,
    shadowColor: AppColors.darkCyan.withOpacity(0.1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.all(8),
  ),

  // List Tile Theme
  listTileTheme: ListTileThemeData(
    tileColor: Colors.white,
    selectedTileColor: AppColors.darkCyan.withOpacity(0.1),
    iconColor: Colors.grey.shade600,
    selectedColor: AppColors.darkCyan,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),

  // Chip Theme
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey.shade100,
    selectedColor: AppColors.darkCyan.withOpacity(0.2),
    labelStyle: TextStyle(color: Colors.grey.shade800),
    secondaryLabelStyle: const TextStyle(color: AppColors.darkCyan),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  ),

  // Icon Theme
  iconTheme: IconThemeData(color: Colors.grey.shade700, size: 24),

  // Text Theme
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      color: AppColors.lightOnSurface,
      fontWeight: FontWeight.bold,
      fontSize: 32,
    ),
    headlineMedium: TextStyle(
      color: AppColors.lightOnSurface,
      fontWeight: FontWeight.w600,
      fontSize: 28,
    ),
    titleLarge: TextStyle(
      color: AppColors.lightOnSurface,
      fontWeight: FontWeight.w600,
      fontSize: 22,
    ),
    titleMedium: TextStyle(
      color: AppColors.lightOnBackground,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    bodyLarge: TextStyle(color: AppColors.lightOnSurface, fontSize: 16),
    bodyMedium: TextStyle(color: AppColors.lightOnBackground, fontSize: 14),
  ),

  // Progress Indicator
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.darkCyan,
    linearTrackColor: AppColors.darkCyanLight,
    circularTrackColor: AppColors.darkCyanLight,
  ),

  // Divider Theme
  dividerTheme: DividerThemeData(
    color: Colors.grey.shade300,
    thickness: 1,
    space: 1,
  ),
);

// Dark Theme
final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,

  // Color Scheme
  colorScheme: ColorScheme.dark(
    primary: AppColors.accent,
    onPrimary: Colors.black,
    secondary: AppColors.darkCyanLight,
    onSecondary: Colors.black,
    tertiary: AppColors.accentLight,
    onTertiary: Colors.black,

    background: AppColors.darkBackground,
    onBackground: AppColors.darkOnBackground,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,

    error: AppColors.error,
    onError: Colors.white,

    outline: Colors.grey.shade600,
    outlineVariant: Colors.grey.shade700,

    surfaceVariant: Colors.grey.shade800,
    onSurfaceVariant: Colors.grey.shade300,
  ),

  // Scaffold
  scaffoldBackgroundColor: AppColors.darkBackground,

  // AppBar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.darkOnSurface,
    elevation: 2,
    shadowColor: Colors.black.withOpacity(0.5),
    titleTextStyle: TextStyle(
      color: AppColors.darkOnSurface,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(color: AppColors.darkOnSurface),
    actionsIconTheme: IconThemeData(color: AppColors.darkOnSurface),
  ),

  // Bottom Navigation Bar
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color.fromARGB(255, 27, 34, 53),
    selectedItemColor: AppColors.accent,
    unselectedItemColor: Colors.grey.shade500,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
  ),

  // Floating Action Button
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.accent,
    foregroundColor: Colors.black,
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  ),

  // Elevated Button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.black,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),

  // Outlined Button
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.accent,
      side: const BorderSide(color: AppColors.accent, width: 2),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    ),
  ),

  // Text Button
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.accent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  ),

  // Input Decoration
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade800,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade600),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade600),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.accent, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error, width: 2),
    ),
    labelStyle: TextStyle(color: Colors.grey.shade300),
    hintStyle: TextStyle(color: Colors.grey.shade500),
  ),

  // Card Theme
  cardTheme: CardThemeData(
    color: AppColors.darkSurface,
    elevation: 4,
    shadowColor: Colors.black.withOpacity(0.3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.all(8),
  ),

  // List Tile Theme
  listTileTheme: ListTileThemeData(
    tileColor: AppColors.darkSurface,
    selectedTileColor: AppColors.accent.withOpacity(0.2),
    iconColor: Colors.grey.shade400,
    selectedColor: AppColors.accent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),

  // Chip Theme
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey.shade700,
    selectedColor: AppColors.accent.withOpacity(0.3),
    labelStyle: TextStyle(color: Colors.grey.shade200),
    secondaryLabelStyle: const TextStyle(color: AppColors.accent),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  ),

  // Icon Theme
  iconTheme: IconThemeData(color: Colors.white70, size: 24),

  // Text Theme
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      color: AppColors.darkOnSurface,
      fontWeight: FontWeight.bold,
      fontSize: 32,
    ),
    headlineMedium: TextStyle(
      color: AppColors.darkOnSurface,
      fontWeight: FontWeight.w600,
      fontSize: 28,
    ),
    titleLarge: TextStyle(
      color: AppColors.darkOnSurface,
      fontWeight: FontWeight.w600,
      fontSize: 22,
    ),
    titleMedium: TextStyle(
      color: AppColors.darkOnBackground,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    bodyLarge: TextStyle(color: AppColors.darkOnSurface, fontSize: 16),
    bodyMedium: TextStyle(color: AppColors.darkOnBackground, fontSize: 14),
  ),

  // Progress Indicator
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.accent,
    linearTrackColor: AppColors.accentDark,
    circularTrackColor: AppColors.accentDark,
  ),

  // Divider Theme
  dividerTheme: DividerThemeData(
    color: Colors.grey.shade600,
    thickness: 1,
    space: 1,
  ),
);
