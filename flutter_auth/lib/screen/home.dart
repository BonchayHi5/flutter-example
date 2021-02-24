import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  final String response;
  Home(this.response);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Success!!'),
              SizedBox(height: 20.0),
              Text(response),
          ],),
        ),
      ),
    );
  }
}