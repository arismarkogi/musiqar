import 'dart:async';
import 'dart:io';
import 'earth_ar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicSelectionScreen extends StatelessWidget {
  Future<List<CameraDescription>> getCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Experience Musical Instruments'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select your favorite musical instrument and experience it in the magical world of augmented reality.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 4, 58, 46),
                fontSize: 22,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w800,
                height: 1.2,
                letterSpacing: 0.50,
              ),
              softWrap: true,
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () async {
                List<CameraDescription> cameras = await getCameras();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CombinedScreen(
                      camera: cameras.first,
                      musicAsset: 'Blue.mp3',
                      modelAsset: 'assets/Grand.glb',
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
                      modelAsset: 'assets/saxophone.glb',
                    ),
                  ),
                );
              },
              child: Text('Saxophone'),
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
                      musicAsset: 'tuba.mp3',
                      modelAsset: 'assets/tuba.glb',
                    ),
                  ),
                );
              },
              child: Text('Tuba'),
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
                      musicAsset: 'violin.mp3',
                      modelAsset: 'assets/violin.glb',
                    ),
                  ),
                );
              },
              child: Text('Violin'),
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
                      musicAsset: 'guitar.mp3',
                      modelAsset: 'assets/guitar.glb',
                    ),
                  ),
                );
              },
              child: Text('Guitar'),
            ),
          ],
        ),
      ),
    );
  }
}
