import 'package:flutter/material.dart';
import 'profile_settings.dart';
import 'homepage.dart';
import 'menu_page.dart';
import 'widgets/bio.dart';
import 'data/database_helper.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatelessWidget {
  final int userId;

  ProfilePage({required this.userId});

  Future<Map<String, dynamic>> _fetchUserData() async {
    List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();
    return users.firstWhere((user) => user['id'] == userId) ?? {};
  }

<<<<<<< HEAD
  Widget info(String name, Uint8List userImage, int points) {
=======
  Widget info(String name, Uint8List userImage) {
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
    return Container(
      width: 340,
      height: 144.24,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 106,
              height: 108,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(userImage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 92.24,
            top: 71.76,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(0.28),
              child: Container(
                width: 54,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
<<<<<<< HEAD
                    image: points < 100
                        ? AssetImage('assets/logo3.png'):
                        points > 200 ? AssetImage('assets/piano.jpg')
                        : AssetImage('assets/logo2.png'),
=======
                    image: AssetImage('assets/piano.jpg'),
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 137,
            top: 2,
            child: Container(
              width: 197,
              height: 86,
              decoration: ShapeDecoration(
                color: Color(0xFFFAFAFA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(43.0),
                  side: BorderSide(
                    width: 1,
                    color: Colors.black,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 137,
            top: 2,
            child: Container(
              width: 197,
              height: 86,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text(
<<<<<<< HEAD
                  "Hey $name",
=======
                  name,
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    letterSpacing: 0.50,
                  ),
                  softWrap: true,
                ),
              ),
            ),
<<<<<<< HEAD
=======
          ),
        ],
      ),
    );
  }

/*

@override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return _buildProfilePage(snapshot.data!, context);
        }
      },
    );
  }

Widget _buildProfilePage(Map<String, dynamic> userData, BuildContext context) {
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(userId: userId)));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
=======
*/
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          return Text('Error: ${snapshot.error}');
        } else {
          return _buildProfilePage(snapshot.data!, context);
        }
      },
    );
  }

  Widget _buildProfilePage(
      Map<String, dynamic> userData, BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
<<<<<<< HEAD
        if (details.primaryDelta! > 20) {
=======
        if (details.primaryDelta! > 0) {
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MenuPage(userId: userId)),
          );
<<<<<<< HEAD
        }
      },
      child: Scaffold(
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
=======
        }
      },
      child: Scaffold(
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
                      builder: (context) => MenuPage(userId: userId)));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                _buildProfileInfo(userData),
                SizedBox(height: 100),
                Bio(userData['bio']),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileSettings(
                  userId: userData['id'],
                ),
              ),
            );
          },
          child: Icon(Icons.mode_edit),
          backgroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildProfileInfo(Map<String, dynamic> userData) {
    return FutureBuilder(
      future: _loadUserImage(userData['image']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return info(userData['name'], snapshot.data! as Uint8List);
        }
      },
    );
  }

  Future<Uint8List> _loadUserImage(dynamic imageData) async {
    if (imageData == null) {
      final ByteData data = await rootBundle.load('assets/piano.jpg');
      return data.buffer.asUint8List();
    } else if (imageData is Uint8List) {
      return imageData;
    } else {
      // Handle other cases if needed
      return Uint8List(0); // Return an empty Uint8List as a fallback
    }
  }
}




/*
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Map<String, dynamic> userData = snapshot.data as Map<String, dynamic>;
          Uint8List userImage;

          if (userData['image'] == null) {
            final ByteData data = await rootBundle.load('assets/piano.jpg');
            userImage = data.buffer.asUint8List();
          } else {
            userImage = userData['image'];
          }
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
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuPage(userId: userId)));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                _buildProfileInfo(userData),
                SizedBox(height: 100),
                Bio(userData['bio']),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileSettings(
                  userId: userData['id'],
                ),
              ),
            );
          },
          child: Icon(Icons.mode_edit),
          backgroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildProfileInfo(Map<String, dynamic> userData) {
    return FutureBuilder(
      future: _loadUserImage(userData['image_url']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return info(userData['name'], snapshot.data! as Uint8List,
              userData['points']);
        }
      },
    );
  }

  Future<Uint8List> _loadUserImage(dynamic imageData) async {
    if (imageData == null) {
      final ByteData data = await rootBundle.load('assets/piano.jpg');
      return data.buffer.asUint8List();
    } else if (imageData is Uint8List) {
      return imageData;
    } else {
      return Uint8List(0);
    }
  }
}
