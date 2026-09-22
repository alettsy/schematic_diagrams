import 'dart:ui';

/// Helper to convert a [Color] into hexadecimal format.
extension HexColor on Color {
  /// Helper to convert a [Color] into hexadecimal format.
  String get hex {
    final rRadix = (r * 255)
        .clamp(0, 255)
        .round()
        .toRadixString(16)
        .padLeft(2, '0');
    final gRadix = (g * 255)
        .clamp(0, 255)
        .round()
        .toRadixString(16)
        .padLeft(2, '0');
    final bRadix = (b * 255)
        .clamp(0, 255)
        .round()
        .toRadixString(16)
        .padLeft(2, '0');
    final alpha = (a * 255)
        .clamp(0, 255)
        .round()
        .toRadixString(16)
        .padLeft(2, '0');

    return '#$rRadix$gRadix$bRadix$alpha';
  }
}
