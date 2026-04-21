import 'package:flutter/material.dart';

@immutable
class SchematicTheme {
  const SchematicTheme({
    this.backgroundColor = Colors.grey,
    this.borderColor = Colors.black,
    this.borderWidth = 2,
    this.borderRadius,
  });

  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final BorderRadiusGeometry? borderRadius;
}
