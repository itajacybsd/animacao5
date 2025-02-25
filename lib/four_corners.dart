import 'dart:math';

import 'package:flutter/material.dart';

class FourCorners extends StatefulWidget {
  const FourCorners({super.key});

  @override
  State<FourCorners> createState() => _FourCornersState();
}

class _FourCornersState extends State<FourCorners>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Alignment> _alignmentAnimation;
  late Animation<double> _borderAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _animationController.addListener(listener);

    //! https://api.flutter.dev/flutter/animation/TweenSequence-class.html

    _alignmentAnimation =
        TweenSequence<Alignment>(<TweenSequenceItem<Alignment>>[
          TweenSequenceItem<Alignment>(
            tween: Tween<Alignment>(
              begin: Alignment.bottomRight,
              end: Alignment.topRight,
            ).chain(CurveTween(curve: Curves.ease)),
            weight: 25.0,
          ),
          TweenSequenceItem<Alignment>(
            tween: Tween<Alignment>(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
            ).chain(CurveTween(curve: Curves.ease)),
            weight: 25.0,
          ),
          TweenSequenceItem<Alignment>(
            tween: Tween<Alignment>(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
            ).chain(CurveTween(curve: Curves.ease)),
            weight: 25.0,
          ),
          TweenSequenceItem<Alignment>(
            tween: Tween<Alignment>(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
            ).chain(CurveTween(curve: Curves.ease)),
            weight: 25.0,
          ),
        ]).animate(_animationController);

    _borderAnimation = Tween<double>(
      begin: 0,
      end: 35,
    ).animate(_animationController);

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 3.1415,
    ).animate(_animationController);

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_animationController);
  }

  void listener() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.removeListener(listener);
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('4 Cantos'))),
      body: Align(
        alignment: _alignmentAnimation.value,
        child: GestureDetector(
          onTap: () {
            _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward();
          },
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: Container(
              margin: EdgeInsets.all(16),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: BorderRadius.circular(_borderAnimation.value),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
