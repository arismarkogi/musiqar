import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'homepage.dart';
import 'data/database_helper.dart';
import 'widgets/sline.dart';
import 'widgets/custom_input.dart';
import 'widgets/signin_button.dart';
import 'profile_settings.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vibration/vibration.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();

  var userID = 1;

  bool validateInputs(BuildContext context) {
    if (signInEmailController.text.isEmpty ||
        signInPasswordController.text.isEmpty) {
      Vibration.vibrate(duration: 1000);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 1),
        ),
      );
      return false;
    }
    return true;
  }

  void signIn(BuildContext context) async {
    String email = signInEmailController.text;
    String password = signInPasswordController.text;

    List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();
    bool isUserValid = users
        .any((user) => user['email'] == email && user['password'] == password);

    if (isUserValid) {
      Map<String, dynamic> userData =
          users.firstWhere((user) => user['email'] == email);

      setState(() {
        userID = userData['id'];
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuPage(userId: userData['id']),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect username or password.'),
        ),
      );
    }
  }

  void signUp(BuildContext context) async {
    String email = signUpEmailController.text;
    String password = signUpPasswordController.text;
    String cpassword = signUpConfirmPasswordController.text;

    if (password != cpassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match!!!'),
        ),
      );
      return;
    }

    int userId = await DatabaseHelper()
        .insertUser({'email': email, 'password': password});

    if (userId == 0) {
      print('Failed to insert user into the database');
      return;
    }

    List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();
    Map<String, dynamic> userData =
        users.firstWhere((user) => user['id'] == userId);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileSettings(
          userId: userId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xFFFEF7FF),
        title: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 150,
            height: 50,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MenuPage(
                          userId: userID,
                        )));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuPage(userId: userID)));
            }
          },
          child: Center(
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
                  customInput('Email', signInEmailController, context: context),
                  SizedBox(height: 16),
                  customInput('Password', signInPasswordController,
                      isPassword: true, context: context),
                  SizedBox(height: 16),
                  singinbutton(
                    onPressed: () {
                      if (validateInputs(context)) {
                        signIn(context);
                      }
                    },
                    buttonText: 'Sign in',
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
                  customInput('Email', signUpEmailController, context: context),
                  SizedBox(height: 16),
                  customInput('Password', signUpPasswordController,
                      isPassword: true, context: context),
                  SizedBox(height: 16),
                  customInput(
                      'Confirm Password', signUpConfirmPasswordController,
                      isPassword: true, context: context),
                  SizedBox(height: 16),
                  singinbutton(
                    onPressed: () => signUp(context),
                    buttonText: 'Sign up',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
