import 'dart:math';

import 'package:flutter/material.dart';

class RotatingCardComponent extends StatefulWidget {
  Widget frontCard;
  Widget backCard;
  RotatingCardComponent(this.frontCard, this.backCard, {super.key});

  @override
  State<RotatingCardComponent> createState() => _RotatingCardComponentState();
}

class _RotatingCardComponentState extends State<RotatingCardComponent>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isFront = true;
  double rotation = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(rotation / 180 * pi),
      alignment: Alignment.center,
      child: isFront
          ? _frontCard()
          : Transform(
              transform: Matrix4.identity()..rotateY(pi),
              alignment: Alignment.center,
              child: _backCard(),
            ),
    );
  }

  _frontCard() {
    return widget.frontCard;
  }

  _backCard() {
    return widget.backCard;
  }

  _onEndAnimation() {
    controller.reset();

    setState(() {
      isFront = true;
      rotation = 0;
    });
  }

  _onRotate() {
    animation = Tween<double>(begin: rotation, end: rotation >= 180 ? 0 : 360)
        .animate(controller)
      ..addListener(
        () {
          setState(
            () {
              rotation = animation.value;
              _setSide();
            },
          );
        },
      );
    controller.forward();
  }

  _setSide() => isFront = (rotation <= 90 || rotation >= 270);
}
