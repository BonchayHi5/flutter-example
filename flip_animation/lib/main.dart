import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FlipAnimationScreen(),
    );
  }
}

class FlipAnimationScreen extends StatefulWidget {
  const FlipAnimationScreen({Key? key}) : super(key: key);

  @override
  _FlipAnimationScreenState createState() => _FlipAnimationScreenState();
}

class _FlipAnimationScreenState extends State<FlipAnimationScreen> {
  late bool _flipXAxis;

  late bool _showFrontSide;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: RotatedBox(
            child: const Icon(Icons.flip),
            quarterTurns: _flipXAxis ? 0 : 1,
          ),
          onPressed: _changeRotationAxis,
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints.tight(const Size.square(200.0)),
          child: GestureDetector(
            onTap: _switchCard,
            child: AnimatedSwitcher(
              transitionBuilder: __transitionBuilder,
              layoutBuilder: (widget, list) =>
                  Stack(children: [widget!, ...list]),
              duration: const Duration(milliseconds: 800),
              switchInCurve: Curves.easeInBack,
              switchOutCurve: Curves.easeInBack.flipped,
              child: _showFrontSide ? _frontWidget() : _backWidget(),
            ),
          ),
        ),
      ),
    );
  }

  void _changeRotationAxis() {
    setState(() {
      _flipXAxis = !_flipXAxis;
    });
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  _frontWidget() {
    return _reuseLayout(const ValueKey(true), Colors.red, 'Front');
  }

  _backWidget() {
    return _reuseLayout(const ValueKey(false), Colors.black, 'Back');
  }

  _reuseLayout(Key key, Color bgdColor, String label) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: bgdColor,
      ),
      child: Center(
        child: Text(label.substring(0, 1),
            style: const TextStyle(fontSize: 80.0, color: Colors.white)),
      ),
    );
  }
}
