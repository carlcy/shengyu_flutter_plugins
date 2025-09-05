
extension ListExtensions<T> on List<T>? {
  int get safeLength => this == null ? 0 : this!.length;

  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullAndEmpty => this != null && this!.isNotEmpty;

  T? get safeFirst => this.safeLength > 0 ? this!.first : null;

  T? firstWhereOrNull(bool Function(T) test) {
    if (isNullOrEmpty) return null;

    for (final element in this!) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  /// Validate given List is not null and returns blank list if null.
  /// This should not be used to clear list
  List<T> validate() {
    if (this == null) {
      return [];
    } else {
      return this!.toList();
    }
  }

  /// Generate map but gives index for it
  Iterable<E> mapIndexed<E>(E Function(T element, int index) toElement) {
    var index = 0;
    return this.validate().map<E>((e) {
      return toElement(e, index ++);
    });
  }

  /// Generate forEach but gives index for each element
  void forEachIndexed(void Function(T element, int index) action) {
    var index = 0;
    for (var element in this!) {
      action(element!, index++);
    }
  }
}