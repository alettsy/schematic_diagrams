import 'package:flutter/foundation.dart';

import 'position.dart';

@immutable
class Port {
  const Port({required this.id, this.position = const Position(0, 0)});

  final String id;
  final Position position;
}
