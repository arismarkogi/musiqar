import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Figma to Flutter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
        centerTitle: true, // Center the title
        title: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 120, // Adjust the width as needed
            height: 40, // Adjust the height as needed
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
              },
              child: Text('Sign in'),
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
        centerTitle: true, // Center the title
        title: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 120, // Adjust the width as needed
            height: 40, // Adjust the height as needed
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Second Page!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the Home Page
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}


class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController  = TextEditingController();

  Widget customInput(String labelText, TextEditingController controller) {
  return Container(
    width: 210,
    height: 56,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 210,
          height: 56,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: Color(0xFFE0E0E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Add TextField for input
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: labelText, // Use the provided labelText
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF49454F),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget  sline(){
  return Container(
    width: 288,
    decoration: ShapeDecoration(
    shape: RoundedRectangleBorder(
    side: BorderSide(
    width: 1,
    strokeAlign: BorderSide.strokeAlignCenter,
    color: Color(0xFFCAC4D0),
    ),
    ),
    ),
    );
}

Widget singinbutton({required VoidCallback onPressed, required String buttonText, Widget? child}) {
  return Container(
    width: 92,
    height: 40,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFFB3261E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.10,
                letterSpacing: 0.10,
              ),
            ),
            if (child != null) SizedBox(width: 6), // Add some space between text and additional child
            if (child != null) child,
          ],
        ),
      ),
    ),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true, // Center the title
      title: Center(
        child: Image.asset(
          'assets/logo.png',
           width: 150, // Adjust the width as needed
           height: 50, // Adjust the height as needed
        ),
      ),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SIGN IN',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 0.04,
                letterSpacing: 0.50,
              ),
            ),
            SizedBox(height: 30),
            // Input boxes
            customInput('Email', emailController),
            SizedBox(height: 16),
            customInput('Password', passwordController),
            SizedBox(height: 16),
            // Sign-in button
            singinbutton(
              onPressed: () {
                // Perform sign-in logic here
                String email = emailController.text;
                String password = passwordController.text;

                // Add your authentication logic (e.g., validate credentials)
                // For simplicity, we're just printing the entered email and password
                print('Email: $email');
                print('Password: $password');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              buttonText: 'Sign in', // Specify the text for the button
            ),
            SizedBox(height: 16),
            sline(),
            const SizedBox(height: 25),

            Text(
              'SIGN UP',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 0.04,
                letterSpacing: 0.50,
              ),
            ),
            SizedBox(height: 30),
            // Input boxes
            customInput('Email', emailController),
            SizedBox(height: 16),
            customInput('Password', passwordController),
            SizedBox(height: 16),
            customInput('Confirm Password', cpasswordController),
            SizedBox(height: 16),
            // Sign-in button
            singinbutton(
              onPressed: () {
                // Perform sign-in logic here
                String email = emailController.text;
                String password = passwordController.text;
                String cpassword = cpasswordController.text;

                // Add your authentication logic (e.g., validate credentials)
                // For simplicity, we're just printing the entered email and password
                print('Email: $email');
                print('Password: $password');
                print('Cpassword: $cpassword');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              buttonText: 'Sign up', // Specify the text for the button
            ),
          ],
        ),
      ),
    ),
  );
}



}
