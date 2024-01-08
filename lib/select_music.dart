import 'dart:async';
import 'dart:io';
import 'earth_ar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:audioplayers/audioplayers.dart';

<<<<<<< HEAD
class MusicSelectionScreen extends StatelessWidget {
=======



class MusicSelectionScreen extends StatelessWidget {

>>>>>>> 3d15553 (update)
  Future<List<CameraDescription>> getCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await availableCameras();
  }
<<<<<<< HEAD

=======
  
>>>>>>> 3d15553 (update)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music and 3D Model Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                List<CameraDescription> cameras = await getCameras();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CombinedScreen(
                      camera: cameras.first,
<<<<<<< HEAD
                      musicAsset: 'Blue.mp3',
                      modelAsset: 'assets/piano3d.glb',
=======
                      musicAsset: 'Blue.mp3', // Default music for piano
                      modelAsset: 'assets/piano3d.glb', // Default 3D model for piano
>>>>>>> 3d15553 (update)
                    ),
                  ),
                );
              },
              child: Text('Piano'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                List<CameraDescription> cameras = await getCameras();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CombinedScreen(
                      camera: cameras.first,
                      musicAsset: 'saxophone.m4a',
<<<<<<< HEAD
                      modelAsset: 'assets/saxophone.glb',
=======
                      modelAsset: 'assets/saxophone.glb', 
>>>>>>> 3d15553 (update)
                    ),
                  ),
                );
              },
              child: Text('Saxophone'),
            ),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 3d15553 (update)
