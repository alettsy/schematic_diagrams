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

  test('Re-assigning with new ID is acceptable', () {
    final list = ProtectedList<_Item>()
      ..add(_Item(id: 'A', value: 22))
      ..add(_Item(id: 'B', value: 66));

    list[1] = _Item(id: 'C', value: 34);
    expect(list[1].id, 'C');
    expect(list[1].value, 34);
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

  test('removeAt removes at index if found', () {
    final list = ProtectedList<_Item>()
      ..add(_Item(id: 'A', value: 22))
      ..add(_Item(id: 'B', value: 66));

    expect(list.removeAt(1).id, 'B');
    expect(list.length, 1);
  });

  test('removeAt throws error if index not found', () {
    final list = ProtectedList<_Item>()
      ..add(_Item(id: 'A', value: 22))
      ..add(_Item(id: 'B', value: 66));

    expect(() => list.removeAt(10), throwsA(isA<ArgumentError>()));
    expect(list.length, 2);
  });

  test('remove removes if object is found', () {
    final list = ProtectedList<_Item>()
      ..add(_Item(id: 'A', value: 22))
      ..add(_Item(id: 'B', value: 66));

    expect(list.remove(_Item(id: 'A', value: 22)), isTrue);
    expect(list.length, 1);
  });

  test('remove returns false if object is not found', () {
    final list = ProtectedList<_Item>()
      ..add(_Item(id: 'A', value: 22))
      ..add(_Item(id: 'B', value: 66));

    expect(list.remove(_Item(id: 'C', value: 22)), isFalse);
    expect(list.length, 2);
  });

  test('removeLast removes last item', () {
    final list = ProtectedList<_Item>()
      ..add(_Item(id: 'A', value: 22))
      ..add(_Item(id: 'B', value: 66));

    expect(list.removeLast().id, 'B');
    expect(list.length, 1);
  });

  test('removeLast throws error if list is empty', () {
    final list = ProtectedList<_Item>();
    expect(list.removeLast, throwsA(isA<ArgumentError>()));
  });

  test('removeWhere removes items that match', () {
    final list = ProtectedList<_Item>()
      ..add(_Item(id: 'A', value: 22))
      ..add(_Item(id: 'B', value: 66))
      ..removeWhere((i) => i.value > 50);

    expect(list.length, 1);
    expect(list.first.id, 'A');
  });

  test('removeWhere does nothing if no items match', () {
    final list = ProtectedList<_Item>()
      ..add(_Item(id: 'A', value: 22))
      ..add(_Item(id: 'B', value: 66))
      ..removeWhere((i) => i.value > 100);

    expect(list.length, 2);
  });

  test('addAll throws error if one ID is already used', () {
    final list = ProtectedList<_Item>()..add(_Item(id: 'A', value: 22));

    final toAdd = [_Item(id: 'A', value: 66), _Item(id: 'B', value: 77)];

    expect(list.length, 1);

    expect(() => list.addAll(toAdd), throwsA(isA<ArgumentError>()));

    expect(list.length, 1);
  });

  test('addAll adds items if no matching IDs are found', () {
    final list = ProtectedList<_Item>()..add(_Item(id: 'A', value: 22));

    final toAdd = [_Item(id: 'B', value: 66), _Item(id: 'C', value: 77)];

    expect(list.length, 1);

    list.addAll(toAdd);

    expect(list.length, 3);
  });

  test('removeRange is not supported', () {
    final list = ProtectedList<_Item>()..add(_Item(id: 'A', value: 22));
    expect(() => list.removeRange(1, 4), throwsA(isA<UnsupportedError>()));
  });
}

class _Item implements IdBased {
  _Item({required this.id, required this.value});

  @override
  final String id;
  final double value;
}
