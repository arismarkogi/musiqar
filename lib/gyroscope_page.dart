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
        title: Text('Gyroscope Question'),
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
