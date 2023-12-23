import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/custom_input.dart';

class ProfileSettings extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();


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

      ),
    body: Stack(
        children: [
          // Image at the top-left
          Positioned(
            left: 10,
            top: 10,
            child: Image.asset(
              'assets/piano.jpg', // Replace with your image path
              height: 94,
              width: 87,
              fit: BoxFit.cover, // Adjust as needed
            ),
          ),
          // Container with edit icon at the bottom-right corner
          Positioned(
            top: 90,
            left: 90,
            child: EditIconContainer(),
          ),
          Positioned(
            top: 150,
            left: 150,
            child: customInput('Name', nameController, context: context),
          ),
          Positioned(
            top: 210,
            left: 150,
            child: customInput('Surname', surnameController, context: context),
          ),
          Positioned(
            top: 270,
            left: 150,
            child: customInput('Email', emailController, context: context),
          ),
          Positioned(
            top: 330,
            left: 150,
            child: customInput('New Password', passwordController, isPassword: true, context: context),
          ),
          Positioned(
            top: 390,
            left: 150,
            child: customInput('Date of Birth', dobController, isDate: true, context: context),
          ),
          Positioned(
            bottom: 10,
            left: 185,
            right: 185,
            child: Save_button(
              onPressed: () {
                print('Changes saved');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              buttonText: 'Save Changes',
            ),
          ),

        ],
      ),
    );
  }
}


Widget Save_button({
  required VoidCallback onPressed,
  required String buttonText,
  Widget? child,
}) {
  return Container(
    constraints: BoxConstraints(minWidth: 92),
    child: Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Color(0xFF6750A4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              if (child != null) SizedBox(width: 6),
              if (child != null) child,
            ],
          ),
        ),
      ),
    ),
  );
}


class EditIconContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the home page
        Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
      },
      child: Stack(
        children: [
          Container(
            width: 37,
            height: 40,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border(
                left: BorderSide(),
                top: BorderSide(),
                right: BorderSide(width: 8),
                bottom: BorderSide(width: 7),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Center(
              child: Icon(Icons.mode_edit),
            ),
          ),
        ],
      ),
    );
  }
}
