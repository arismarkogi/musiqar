import 'package:flutter/material.dart';

class SwipeRightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe Right Page'),
      ),
      body: Center(
        child: Text(
          'Swipe right to go back!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
