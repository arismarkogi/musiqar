import 'package:flutter/material.dart';
import 'profile_settings.dart';
import 'homepage.dart';
import 'menu_page.dart';
import 'widgets/bio.dart';
//import 'widgets/info.dart';
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


  

Widget info(String name, Uint8List userImage) {
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
                  image: AssetImage('assets/piano.jpg'),
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
                name,
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
          ),
        ],
      ),

    body: GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(userId: userId)));
        }
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              FutureBuilder(
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
              ),

              SizedBox(height: 100),
              Bio(userData['bio']),
            ],
          ),
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
                //onUserDataChanged: _updateUserData,
              ),
            ),
          );
        },
        child: Icon(Icons.mode_edit),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }
  }

*/
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
          ),
        ],
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(userId: userId)));
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                info(userData['name'], userImage),
                SizedBox(height: 100),
                Bio(userData['bio']),
              ],
            ),
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
                //onUserDataChanged: _updateUserData,
              ),
            ),
          );
        },
        child: Icon(Icons.mode_edit),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }
      },
    );
  }
}

*/