class IterableExtension {
  const IterableExtension._();
}

extension IterableX<T extends Object?> on Iterable<T> {
  Iterable<T> separated(T separator) {
    final iterable = <T>[];
    final last = length - 1;
    for (var i = 0; i < length; i++) {
      iterable.add(elementAt(i));
      if (i != last) iterable.add(separator);
    }
    return iterable;
  }
}
