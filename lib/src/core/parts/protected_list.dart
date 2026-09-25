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

    if (previousId != value.id && _usedIds.contains(value.id)) {
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
  bool remove(Object? element) {
    throw UnsupportedError('Not supported');
  }

  @override
  T removeAt(int index) {
    throw UnsupportedError('Not supported');
  }

  @override
  T removeLast() {
    throw UnsupportedError('Not supported');
  }

  @override
  void removeWhere(bool Function(T element) test) {
    throw UnsupportedError('Not supported');
  }

  @override
  void removeRange(int start, int end) {
    throw UnsupportedError('Not supported');
  }

  @override
  void addAll(Iterable<T> iterable) {
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
