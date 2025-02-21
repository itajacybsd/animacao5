import 'package:animacao5/four_corners.dart';
import 'package:animacao5/playground.dart';
import 'package:flutter/material.dart';

class MyAppPlay extends StatelessWidget {
  const MyAppPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/fourCorners': (_) => FourCorners()},
      home: Playground(),
    );
  }
}
