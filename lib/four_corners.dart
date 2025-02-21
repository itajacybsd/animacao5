import 'package:flutter/material.dart';

class FourCorners extends StatefulWidget {
  const FourCorners({super.key});

  @override
  State<FourCorners> createState() => _FourCornersState();
}

class _FourCornersState extends State<FourCorners>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _alignLineAnimation;
  late Animation<double> _alignColumnAnimation;
  late Animation<double> _stepsAnimation;

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

    _alignColumnAnimation = Tween<double>(
      begin: startColumn,
      end: endColumn,
    ).animate(_animationController);

    _alignLineAnimation = Tween<double>(
      begin: startLine,
      end: endLine,
    ).animate(_animationController);

    _stepsAnimation = Tween<double>(
      begin: 1,
      end: 4,
    ).animate(_animationController);

    //! https://api.flutter.dev/flutter/animation/TweenSequence-class.html

    final Animation<double> animation =
        TweenSequence<double>(<TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: 5.0,
              end: 10.0,
            ).chain(CurveTween(curve: Curves.ease)),
            weight: 40.0,
          ),
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(10.0),
            weight: 20.0,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: 10.0,
              end: 5.0,
            ).chain(CurveTween(curve: Curves.ease)),
            weight: 40.0,
          ),
        ]).animate(_animationController);
  }

  void listener() {
    if (_stepsAnimation == 1.0) {
      startColumn = 1;
      endColumn = 1;
      startLine = 1;
      endLine = -1;
    } else if (_stepsAnimation == 2.0) {
      startColumn = 1;
      endColumn = -1;
      startLine = -1;
      endLine = -1;
    } else if (_stepsAnimation == 3.0) {
      startColumn = -1;
      endColumn = -1;
      startLine = -1;
      endLine = 1;
    } else if (_stepsAnimation == 4.0) {
      startColumn = -1;
      endColumn = 1;
      startLine = 1;
      endLine = 1;
    }
    print(_stepsAnimation.value);
    setState(() {
      print('startColumn + $startColumn');
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
        alignment: Alignment(
          _alignColumnAnimation.value,
          _alignLineAnimation.value,
        ),
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

//!
