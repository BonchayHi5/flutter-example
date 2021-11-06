import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
