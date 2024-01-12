<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'widgets/custom_input.dart';
import 'widgets/custom_desc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'data/database_helper.dart';
import 'dart:typed_data';
import 'widgets/save_button.dart';
import 'package:vibration/vibration.dart';

class ProfileSettings extends StatefulWidget {
  final int userId;

  ProfileSettings({required this.userId});

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  File? selectedImage;

  @override
  void initState() {
    super.initState();

    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();
    Map<String, dynamic> userData =
        users.firstWhere((user) => user['id'] == widget.userId);

    setState(() {
      nameController.text = userData['name'] ?? '';
      surnameController.text = userData['surname'] ?? '';
      emailController.text = userData['email'] ?? '';
      dobController.text = userData['dateofbirth'] ?? '';
      bioController.text = userData['bio'] ?? '';
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
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
      ),
      body: Stack(
        children: [
          Positioned(
            left: 10,
            top: 10,
            child: selectedImage != null
                ? Image.file(
                    selectedImage!,
                    height: 94,
                    width: 87,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/piano.jpg',
                    height: 94,
                    width: 87,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            top: 90,
            left: 90,
            child: EditIconContainer(onEditPressed: _pickImage),
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
            child: customInput('New Password', passwordController,
                isPassword: true, context: context),
          ),
          Positioned(
            top: 390,
            left: 150,
            child: customInput('Date of Birth', dobController,
                isDate: true, context: context),
          ),
          Positioned(
            top: 450,
            left: 150,
            child: customdesc('Short Bio', bioController),
          ),
          Positioned(
            bottom: 10,
            left: 120,
            right: 120,
            child: SaveButton(
              onPressed: () async {
                try {
                  if (passwordController.text.trim().isEmpty) {
                                Vibration.vibrate(duration: 500);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Please enter a value for Password.'),
                                  ),
                                );
                              }
                  else{
                  if (selectedImage != null) {
                    List<int> imageBytes = await selectedImage!.readAsBytes();

                    await DatabaseHelper().updateUser({
                      'id': widget.userId,
                      'name': nameController.text,
                      'surname': surnameController.text,
                      'email': emailController.text,
                      'password': passwordController.text,
                      'dateofbirth': dobController.text,
                      'bio': bioController.text,
                      'image_url': Uint8List.fromList(imageBytes),
                    });
                  } else {
                    await DatabaseHelper().updateUser({
                      'id': widget.userId,
                      'name': nameController.text,
                      'surname': surnameController.text,
                      'email': emailController.text,
                      'password': passwordController.text,
                      'dateofbirth': dobController.text,
                      'bio': bioController.text,
                    });
                  }

                  print('Changes saved');

                  await _fetchUserData();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(userId: widget.userId)),
                  );
                  }
                } catch (e) {
                  print('Error during user data update: $e');
                }
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
    constraints: BoxConstraints(minWidth: 150),
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
  final VoidCallback onEditPressed;

  const EditIconContainer({
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEditPressed,
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



=======
/*
import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/custom_input.dart';
import 'widgets/custom_desc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  File? selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
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

      ),
    body: SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 10,
            child: selectedImage != null
                ? Image.file(
                    selectedImage!,
                    height: 94,
                    width: 87,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/piano.jpg',
                    height: 94,
                    width: 87,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            top: 90,
            left: 90,
            child: EditIconContainer(onEditPressed: _pickImage),
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
            top: 450,
            left: 150,
            child: customdesc('Short Bio', bioController),
          ),
          Positioned(
            bottom: 10,
            left: 120,
            right: 120,
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
    constraints: BoxConstraints(minWidth: 150),
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
  final VoidCallback onEditPressed;

  const EditIconContainer({
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEditPressed,
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
*/

import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/custom_input.dart';
import 'widgets/custom_desc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'data/database_helper.dart';
import 'dart:typed_data';
import 'widgets/save_button.dart';

class ProfileSettings extends StatefulWidget {
  final int userId;

  ProfileSettings({required this.userId});

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  File? selectedImage;

  @override
  void initState() {
    super.initState();

    // Fetch user data based on the user ID
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();
    Map<String, dynamic> userData =
        users.firstWhere((user) => user['id'] == widget.userId);

    setState(() {
      nameController.text = userData['name'] ?? '';
      surnameController.text = userData['surname'] ?? '';
      emailController.text = userData['email'] ?? '';
      dobController.text = userData['dateofbirth'] ?? '';
      // passwordController.text = userData['password'] ?? '';
      bioController.text = userData['bio'] ?? '';
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
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
      ),
      body: Stack(
        children: [
          Positioned(
            left: 10,
            top: 10,
            child: selectedImage != null
                ? Image.file(
                    selectedImage!,
                    height: 94,
                    width: 87,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/piano.jpg',
                    height: 94,
                    width: 87,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            top: 90,
            left: 90,
            child: EditIconContainer(onEditPressed: _pickImage),
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
            child: customInput('New Password', passwordController,
                isPassword: true, context: context),
          ),
          Positioned(
            top: 390,
            left: 150,
            child: customInput('Date of Birth', dobController,
                isDate: true, context: context),
          ),
          Positioned(
            top: 450,
            left: 150,
            child: customdesc('Short Bio', bioController),
          ),
          Positioned(
            bottom: 10,
            left: 120,
            right: 120,
            child: SaveButton(
              onPressed: () async {
                try {
                  if (selectedImage != null) {
                    List<int> imageBytes = await selectedImage!.readAsBytes();

                    await DatabaseHelper().updateUser({
                      'id': widget.userId,
                      'name': nameController.text,
                      'surname': surnameController.text,
                      'email': emailController.text,
                      'password': passwordController.text,
                      'dateofbirth': dobController.text,
                      'bio': bioController.text,
                      'image': Uint8List.fromList(imageBytes),
                    });
                  } else {
                    // Update the user data without changing the image
                    await DatabaseHelper().updateUser({
                      'id': widget.userId,
                      'name': nameController.text,
                      'surname': surnameController.text,
                      'email': emailController.text,
                      'password': passwordController.text,
                      'dateofbirth': dobController.text,
                      'bio': bioController.text,
                    });
                  }

                  print('Changes saved');

                  await _fetchUserData();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(userId: widget.userId)),
                  );
                } catch (e) {
                  print('Error during user data update: $e');
                }
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
    constraints: BoxConstraints(minWidth: 150),
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
  final VoidCallback onEditPressed;

  const EditIconContainer({
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEditPressed,
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
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
