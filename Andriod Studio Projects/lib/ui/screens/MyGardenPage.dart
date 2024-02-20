import 'package:flutter/material.dart';

class MyGardenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Garden"),
      ),
      body: Center(
        child: Text("Welcome to My Garden!"),
      ),
    );
  }
}
