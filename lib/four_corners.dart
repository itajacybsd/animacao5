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

  late double startLine;
  late double endLine;
  late double startColumn;
  late double endColumn;

  @override
  void initState() {
    super.initState();
    startColumn = 1;
    endColumn = 1;
    startLine = 1;
    endLine = -1;

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
  }

  void listener() {
    
    setState(() {
    });
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
          child: Container(
            margin: EdgeInsets.all(16),
            height: 70,
            width: 70,
            decoration: BoxDecoration(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}

