import 'position.dart';
import 'text_block_theme.dart';

class TextBlock {
  TextBlock({
    required this.text,
    this.id,
    this.position = const Position(0, 0),
    this.drawWidth = 100,
    this.themeOverride = const TextBlockTheme(),
  });

  final String? id;
  final String text;
  final Position position;
  final double drawWidth;
  final TextBlockTheme themeOverride;

  TextBlock copyWith({
    String? id,
    String? text,
    Position? position,
    double? drawWidth,
    TextBlockTheme? themeOverride,
  }) {
    return TextBlock(
      id: id ?? this.id,
      text: text ?? this.text,
      position: position ?? this.position,
      drawWidth: drawWidth ?? this.drawWidth,
      themeOverride: themeOverride ?? this.themeOverride,
    );
  }
}
