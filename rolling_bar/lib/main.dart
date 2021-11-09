import 'package:flutter/material.dart';

import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const RollingRow(
          sizeList: ['S', 'M', 'L', 'XL', 'XXL'],
        ));
  }
}

class RollingRow extends StatefulWidget {
  final List<String> sizeList;
  final Duration duration;
  final Color ballColor;
  final Color labelColor;
  final Color barColor;
  final double barHeight;
  final double ballSize;

  const RollingRow({
    Key? key,
    required this.sizeList,
    this.duration = const Duration(milliseconds: 400),
    this.ballColor = const Color(0xFF393E46), //Colors.black,
    this.labelColor = Colors.white,
    this.barColor = const Color(0xFF222831), //Colors.blueAccent,
    this.barHeight = 70,
    this.ballSize = 50,
  }) : super(key: key);

  @override
  State<RollingRow> createState() => RollingRowState();
}

class RollingRowState extends State<RollingRow> with TickerProviderStateMixin {
  late AnimationController control;

  late Animation<double> rot;
  late Animation<double> trasl;

  double end = 22;

  double begin = 0;

  int index = 0;

  @override
  void initState() {
    super.initState();

    control = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    rot = Tween<double>(
      begin: 0,
      end: math.pi,
    ).animate(control);

    trasl = Tween<double>(
      begin: begin,
      end: end,
    ).animate(control);
    control.forward();
  }

  void changeIndex(int selectIndex, BuildContext context) {
    var space = MediaQuery.of(context).size.width / widget.sizeList.length - 2;

    if (index < selectIndex) {
      var forward = selectIndex - index;

      moveForward(space, forward);
    } else {
      var backward = index - selectIndex;
      moveBackward(space, backward);
    }
    index = selectIndex;

    setState(() {});
  }

  void moveForward(double space, int forwardT) {
    control = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    begin = end;
    end = end + space * forwardT;

    rot = Tween<double>(
      begin: 0,
      end: math.pi,
    ).animate(control);

    trasl = Tween<double>(
      begin: begin,
      end: end,
    ).animate(control);

    control.forward();

    setState(() {});
  }

  void moveBackward(double space, int backwardT) {
    control = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    begin = end;

    if (index == 0) {
      end = 22;
    }
    end = begin - space * backwardT;

    rot = Tween<double>(
      begin: 0,
      end: math.pi,
    ).animate(control);

    trasl = Tween<double>(
      begin: begin,
      end: end,
    ).animate(control);

    control.forward();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: AnimatedBuilder(
            animation: control,
            builder: (_, child) => Stack(children: <Widget>[
              Container(
                margin: const EdgeInsets.all(16.0),
                height: widget.barHeight,
                decoration: BoxDecoration(
                    color: widget.barColor,
                    borderRadius: BorderRadius.circular(16.0)),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    widget.sizeList.length,
                    (index) => GestureDetector(
                      onTap: () => changeIndex(index, context),
                      child: Container(
                        color: Colors.transparent,
                        height: 50,
                        width: 60,
                        child: Center(
                          child: Text(widget.sizeList[index],
                              style: TextStyle(
                                color: widget.labelColor,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 25,
                left: trasl.value,
                child: Transform(
                  transform: Matrix4.rotationZ(rot.value),
                  alignment: Alignment.center,
                  child: Container(
                    height: widget.ballSize,
                    width: widget.ballSize,
                    decoration: BoxDecoration(
                      color: widget.ballColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Transform.rotate(
                          angle: -math.pi,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.sizeList[index],
                              style: TextStyle(color: widget.labelColor),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
