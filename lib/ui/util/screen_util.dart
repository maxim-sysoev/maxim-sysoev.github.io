import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

const _xSmall = 'xSmall';
const _small = 'small';
const _medium = 'medium';
const _large = 'large';
const _xLarge = 'xLarge';

///
abstract class ScreenUtil {
  const ScreenUtil._();

  static ScreenSize screenSize() {
    final window = ui.window;
    final width = (window.physicalSize ~/ window.devicePixelRatio).width;
    const sizes = <ScreenSize>[
      ScreenSize.xSmall,
      ScreenSize.small,
      ScreenSize.medium,
      ScreenSize.large,
      ScreenSize.xLarge,
    ];
    return sizes.firstWhereOrNull((s) => width >= s.min && width <= s.max) ?? ScreenSize.xLarge;
  }
}

/// behaviour on different screen sizes
@immutable
class ScreenSize {
  static const ScreenSize xSmall = ScreenSize._(_xSmall, 0, 599);
  static const ScreenSize small = ScreenSize._(_small, 600, 1023);
  static const ScreenSize medium = ScreenSize._(_medium, 1024, 1439);
  static const ScreenSize large = ScreenSize._(_large, 1440, 1919);
  static const ScreenSize xLarge = ScreenSize._(_xLarge, 1920, double.infinity);

  final num min;
  final num max;
  final String representation;

  @override
  int get hashCode => representation.hashCode;

  @literal
  const ScreenSize._(this.representation, this.min, this.max);

  @override
  String toString() => '< ScreenSize $representation $min..$max>';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScreenSize &&
          runtimeType == other.runtimeType &&
          representation == other.representation;

  T when<T>({
    required T Function() extraSmall,
    required T Function() small,
    required T Function() medium,
    required T Function() large,
    required T Function() extraLarge,
  }) {
    switch (representation) {
      case _xSmall:
        return extraSmall();
      case _small:
        return small();
      case _medium:
        return medium();
      case _large:
        return large();
      case _xLarge:
      default:
        return extraLarge();
    }
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? extraSmall,
    T Function()? small,
    T Function()? medium,
    T Function()? large,
    T Function()? extraLarge,
  }) {
    switch (representation) {
      case _xSmall:
        return extraSmall?.call() ?? orElse();
      case _small:
        return small?.call() ?? orElse();
      case _medium:
        return medium?.call() ?? orElse();
      case _large:
        return large?.call() ?? orElse();
      case _xLarge:
      default:
        return extraLarge?.call() ?? orElse();
    }
  }
}
