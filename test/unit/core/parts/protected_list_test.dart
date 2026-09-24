import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/src/core/core.dart';
import 'package:schematic_diagrams/src/internal/base/id_based.dart';

void main() {
  test('throws error duplicate ID found on initialization', () {
    expect(() {
      ProtectedList<_Item>([
        _Item(id: 'A', value: 22),
        _Item(id: 'A', value: 34),
      ]);
    }, throwsA(isA<ArgumentError>()));
  });

  test('throws error duplicate ID found on protected conversion', () {
    expect(() {
      [_Item(id: 'A', value: 22), _Item(id: 'A', value: 34)].protected;
    }, throwsA(isA<ArgumentError>()));
  });

  test('throws error if duplicate ID tries to get added', () {
    final list = ProtectedList<_Item>()..add(_Item(id: 'A', value: 22));

    expect(
      () => list.add(_Item(id: 'A', value: 34)),
      throwsA(isA<ArgumentError>()),
    );
  });

  test('Re-assigning with the same ID is acceptable', () {
    final list = ProtectedList<_Item>()..add(_Item(id: 'A', value: 22));

    expect(
      () => list[0] = _Item(id: 'A', value: 34),
      isNot(throwsA(isA<ArgumentError>())),
    );
    expect(list[0].value, 34);
  });

  test('Re-assigning with duplicate ID throws error', () {
    final list = ProtectedList<_Item>()
      ..add(_Item(id: 'A', value: 22))
      ..add(_Item(id: 'B', value: 66));

    expect(
      () => list[1] = _Item(id: 'A', value: 34),
      throwsA(isA<ArgumentError>()),
    );
  });

  test('Removing non-existent item returns false', () {
    final list = ProtectedList<_Item>()..add(_Item(id: 'A', value: 22));

    expect(list.removeById('B'), isFalse);
    expect(list.length, 1);
  });

  test('Removing item frees up ID', () {
    final list = ProtectedList<_Item>()
      ..add(_Item(id: 'A', value: 22))
      ..add(_Item(id: 'B', value: 66));

    expect(list.removeById('B'), isTrue);
    expect(list.length, 1);

    expect(
      () => list.add(_Item(id: 'B', value: 66)),
      isNot(throwsA(isA<ArgumentError>())),
    );
    expect(list.length, 2);
  });
}

class _Item implements IdBased {
  _Item({required this.id, required this.value});

  @override
  final String id;
  final double value;
}
