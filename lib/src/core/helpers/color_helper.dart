import 'dart:ui';

extension HexColor on Color {
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
