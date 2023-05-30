import 'package:flutter/widgets.dart';
import 'package:wear/wear.dart';

/// Shape of a Wear device
enum WearShape { square, round }

/// Builds a child for a [WatchShape]
typedef WatchShapeBuilder = Widget Function(
    BuildContext context, WearShape shape, Widget? child);

/// Builder widget for watch shapes
@immutable
class WatchShape extends StatefulWidget {
  const WatchShape({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final WatchShapeBuilder builder;
  final Widget? child;

  /// Call [WatchShape.of(context)] to retrieve the shape further down
  /// in the widget hierarchy.
  static WearShape of(BuildContext context) {
    // ignore: deprecated_member_use_from_same_package
    return _InheritedShape.of(context).shape;
  }

  @override
  State<WatchShape> createState() => _WatchShapeState();
}

class _WatchShapeState extends State<WatchShape> {
  late WearShape _shape;

  @override
  void initState() {
    super.initState();
    // Default to round until the platform returns the shape
    // round being the most common form factor for WearOS
    _shape = WearShape.round;
    Wear.instance.getShape().then((String shape) {
      if (mounted) {
        setState(() =>
            _shape = (shape == 'round' ? WearShape.round : WearShape.square));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use_from_same_package
    return _InheritedShape(
      shape: _shape,
      child: Builder(
        builder: (BuildContext context) {
          return widget.builder(context, _shape, widget.child);
        },
      ),
    );
  }
}

/// An inherited widget that holds the shape of the Watch
@Deprecated(
    "Add WatchShape instead and use WatchShape.of(context) to get the shape value.")
class _InheritedShape extends InheritedWidget {
  const _InheritedShape({
    Key? key,
    required this.shape,
    required Widget child,
  }) : super(key: key, child: child);

  final WearShape shape;

  static _InheritedShape of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_InheritedShape>()!;
  }

  @override
  bool updateShouldNotify(_InheritedShape old) => shape != old.shape;
}
