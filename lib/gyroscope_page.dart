<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: GyroscopeExample(),
    );
  }
}

class GyroscopeExample extends StatefulWidget {
  @override
  _GyroscopeExampleState createState() => _GyroscopeExampleState();
}

class _GyroscopeExampleState extends State<GyroscopeExample> {
  double _gyroX = 0.0;
  double _gyroY = 0.0;
  double _gyroZ = 0.0;

  @override
  void initState() {
    super.initState();

    gyroscopeEventStream().listen((GyroscopeEvent event) {
      setState(() {
        _gyroX = event.x;
        _gyroY = event.y;
        _gyroZ = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gyroscope Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gyroscope Data:'),
            Text('X: $_gyroX'),
            Text('Y: $_gyroY'),
            Text('Z: $_gyroZ'),
          ],
        ),
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart'; // Import the sensors package

// THIS PAGE IS TO TEST HOW THE GYROSCOPE WORKS




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define the app's theme
      theme: ThemeData(
        primarySwatch: Colors.green, // Set the app's primary theme color
      ),
      debugShowCheckedModeBanner: false,
      home: GyroscopeExample(), // Use GyroscopeExample as the home screen
    );
  }
}

class GyroscopeExample extends StatefulWidget {
  @override
  _GyroscopeExampleState createState() => _GyroscopeExampleState();
}

class _GyroscopeExampleState extends State<GyroscopeExample> {
  // Declare variables to store gyroscope data
  double _gyroX = 0.0;
  double _gyroY = 0.0;
  double _gyroZ = 0.0;

  @override
  void initState() {
    super.initState();

    // Listen to gyroscope data stream
    gyroscopeEventStream().listen((GyroscopeEvent event) {
      setState(() {
        _gyroX = event.x;
        _gyroY = event.y;
        _gyroZ = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gyroscope Example'), // Set the app bar title
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gyroscope Data:'), // Display a label
            Text('X: $_gyroX'), // Display gyroscope X data
            Text('Y: $_gyroY'), // Display gyroscope Y data
            Text('Z: $_gyroZ'), // Display gyroscope Z data
          ],
        ),
      ),
    );
  }
}
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
