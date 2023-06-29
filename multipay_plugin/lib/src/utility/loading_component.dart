// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  // ignore: annotate_overrides
  final Key? key;
  final Color color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;

  const Loading({
    this.key,
    this.color = Colors.grey,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 2000),
  })  : assert(
            !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
                !(itemBuilder == null && color == null),
            'You should specify either a itemBuilder or a color'),
        super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SpinKitChasingDotsState createState() => _SpinKitChasingDotsState();
}

class _SpinKitChasingDotsState extends State<Loading>
    with TickerProviderStateMixin {
  late AnimationController _scaleCtrl, _rotateCtrl;
  late Animation<double> _scale, _rotate;

  @override
  void initState() {
    super.initState();

    _scaleCtrl = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() => setState(() {}))
      ..repeat(reverse: true);
    _scale = Tween(begin: -1.0, end: 1.0)
        .animate(CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeInOut));

    _rotateCtrl = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() => setState(() {}))
      ..repeat();
    _rotate = Tween(begin: 0.0, end: 360.0)
        .animate(CurvedAnimation(parent: _rotateCtrl, curve: Curves.linear));
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    _rotateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Transform.rotate(
          angle: _rotate.value * 0.0174533,
          child: Stack(
            children: <Widget>[
              Positioned(top: 0.0, child: _circle(1.0 - _scale.value.abs(), 0)),
              Positioned(bottom: 0.0, child: _circle(_scale.value.abs(), 1)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circle(double scale, int index) {
    return Transform.scale(
      scale: scale,
      child: SizedBox.fromSize(
        size: Size.square(widget.size * 0.6),
        child: widget.itemBuilder != null
            ? widget.itemBuilder!(context, index)
            : DecoratedBox(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: widget.color)),
      ),
    );
  }
}

Widget loadingComponent(bool isVisible,
    {Color color = Colors.blue,
    double size = 50,
    EdgeInsetsGeometry? padding}) {
  return Visibility(
    visible: isVisible,
    child: Container(
      padding: padding ?? const EdgeInsets.all(0),
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Loading(
        color: color,
        size: size,
      ),
    ),
  );
}
