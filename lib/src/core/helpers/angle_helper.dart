import 'dart:math';

/// Helper to convert degrees to radians.
extension ToRadians on double {
  /// Helper to convert degrees to radians.
  double get radians => (this * pi) / 180.0;
}
