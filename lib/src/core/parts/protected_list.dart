import 'dart:collection';

import 'package:schematic_diagrams/src/internal/base/id_based.dart';

/// List that is protected by the IDs of the elements, so now duplicates
/// can slip through the cracks.
///
/// Ensures that each item has a unique ID.
class ProtectedList<T extends IdBased> extends ListBase<T> {
  /// Create a [ProtectedList] with optional [initialValues].
  ///
  /// All values must have unique IDs.
  ProtectedList([List<T>? initialValues]) {
    if (initialValues == null) return;

    for (final value in initialValues) {
      if (_usedIds.contains(value.id)) {
        throw ArgumentError('Duplicate ID found: ${value.id}');
      }

      _usedIds.add(value.id);
    }

    _list.addAll(initialValues);
  }

  final _list = <T>[];
  final _usedIds = <String>{};

  @override
  T operator [](int index) => _list[index];

  @override
  void operator []=(int index, T value) {
    final previousId = _list[index].id;

    if (previousId == value.id) {
      _list[index] = value;
      return;
    }

    if (_usedIds.contains(value.id)) {
      throw ArgumentError('Duplicate ID found: ${value.id}');
    }

    _usedIds.remove(_list[index].id);
    _usedIds.add(value.id);
    _list[index] = value;
  }

  /// Remove an item by its ID.
  bool removeById(String id) {
    final index = _list.indexWhere((e) => e.id == id);

    if (index == -1) return false;

    _usedIds.remove(id);
    _list.removeAt(index);

    return true;
  }

  @override
  int get length => _list.length;

  @override
  set length(int newLength) {
    if (newLength < _list.length) {
      for (var i = _list.length - 1; i >= newLength; i--) {
        _usedIds.remove(_list[i].id);
      }
    }

    _list.length = newLength;
  }

  @override
  void add(T element) {
    if (_usedIds.contains(element.id)) {
      throw ArgumentError('Duplicate ID found: ${element.id}');
    }

    _usedIds.add(element.id);
    _list.add(element);
  }

  @override
  T removeAt(int index) {
    final removedItem = _list.removeAt(index);
    _usedIds.remove(removedItem.id);
    return removedItem;
  }

  @override
  bool remove(Object? element) {
    if (element is! T) return false;

    final foundIndex = _list.indexWhere((i) => i.id == element.id);

    if (foundIndex == -1) return false;

    _usedIds.remove(_list[foundIndex].id);
    _list.removeAt(foundIndex);
    return true;
  }

  @override
  T removeLast() {
    final last = _list.removeLast();
    _usedIds.remove(last.id);
    return last;
  }

  @override
  void addAll(Iterable<T> iterable) {
    final ids = iterable.map((i) => i.id);
    final idUsed = _usedIds.any(ids.contains);

    if (idUsed) {
      throw ArgumentError('Duplicate IDs found in addAll call');
    }

    _list.addAll(iterable);
    _usedIds.addAll(ids);
  }

  @override
  void removeWhere(bool Function(T element) test) {
    for (var i = _list.length - 1; i >= 0; i--) {
      final matches = test(_list[i]);

      if (!matches) continue;

      _usedIds.remove(_list[i]);
      _list.removeAt(i);
    }
  }

  @override
  void removeRange(int start, int end) {
    throw UnsupportedError('Not supported');
  }
}

/// Helper function to convert a standard list to a protected one without
/// needing to directly call ProtectedList().
extension ToProtected<T extends IdBased> on List<T> {
  /// Helper function to convert a standard list to a protected one without
  /// needing to directly call ProtectedList().
  ProtectedList<T> get protected {
    return ProtectedList(this);
  }
}
