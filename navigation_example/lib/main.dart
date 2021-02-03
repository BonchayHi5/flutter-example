import 'package:flutter/material.dart';
import 'route/router.dart' as router;
import 'constant/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: router.generateRoute,
      //  / initialRoute: HomeScreenView,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                //this is simple page navigation
                Navigator.of(context).pushNamed(
                  SecondScreenView,
                  arguments: 'argument',
                );
              },
              child: Text('Navigation to Second Page can be back'),
            ),
            RaisedButton(
              onPressed: () {
                //this is simple page navigation
                Navigator.pushReplacementNamed(context, SecondScreenView);
              },
              child: Text('Navigation to Second Page cannot back '),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final String argument;
  SecondPage({this.argument});
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seconde Page'),
      ),
      body: Center(child: Text('${widget.argument} pass from homePage')),
    );
  }
}
