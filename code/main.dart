import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Page App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.teal, // Accent color for buttons
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.blueGrey), // Text color
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange, // App bar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Home Page!',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Button color
              ),
              child: Text('Go to Second Page'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Button color
              ),
              child: Text('Go to Third Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal, // App bar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Second Page!',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous page
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Button color
              ),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue, // App bar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Third Page!',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous page
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Button color
              ),
              child: Text('Go Back'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Button color
              ),
              child: Text('Go to Second Page'),
            ),
          ],
        ),
      ),
    );
  }
}
