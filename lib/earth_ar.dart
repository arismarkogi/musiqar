<<<<<<< HEAD
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:audioplayers/audioplayers.dart';

class BackgroundMusicPlayer {
  static AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> play(String musicAsset) async {
    await _audioPlayer.play(AssetSource(musicAsset));
  }

  static Future<void> pause() async {
    await _audioPlayer.pause();
  }

  static Future<void> stop() async {
    await _audioPlayer.stop();
  }
}

class CombinedScreen extends StatefulWidget {
  final CameraDescription camera;
  final String musicAsset;
  final String modelAsset;

  const CombinedScreen({
    Key? key,
    required this.camera,
    required this.musicAsset,
    required this.modelAsset,
  }) : super(key: key);

  @override
  _CombinedScreenState createState() => _CombinedScreenState();
}

class _CombinedScreenState extends State<CombinedScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    BackgroundMusicPlayer.play(widget.musicAsset);
  }

  @override
  void dispose() {
    _controller.dispose();
    BackgroundMusicPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Combined Screen')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.center,
              children: [
                CameraPreview(_controller),
                ModelViewer(
                  //src: 'assets/piano3d.glb',
                  src: widget.modelAsset,
                  alt: 'A 3D model of a piano',
                  ar: true,
                  autoRotate: true,
                  iosSrc:
                      'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
                  disableZoom: true,
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
=======
/*import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class Earth_AR extends StatefulWidget {
  const Earth_AR({super.key});

  @override
  State<Earth_AR> createState() => _Earth_ARState();
}

class _Earth_ARState extends State<Earth_AR> {
  ArCoreController? arCoreController;

  void onArCoreViewCreated(ArCoreController controller) {
  try {
    arCoreController = controller;
    print("ARCore initialized successfully");

    earthMap(arCoreController!);
  } catch (e) {
    print("Exception in onArCoreViewCreated: $e");
  }
}

Future<void> earthMap(ArCoreController coreController) async {
  try {
    final ByteData EarthMap = await rootBundle.load("assets/earth_map.jpg");

    final material = ArCoreMaterial(
        color: Colors.white, textureBytes: EarthMap.buffer.asUint8List());

    final sphere = ArCoreSphere(
      materials: [material],
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector64.Vector3(0, 0, -1.5),
    );
    arCoreController!.addArCoreNode(node);
  } catch (e) {
    print("Exception in earthMap: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(onArCoreViewCreated: onArCoreViewCreated),
    );
  }
}


*/

/*
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class CombinedScreen extends StatefulWidget {
  final CameraDescription camera;

  const CombinedScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _CombinedScreenState createState() => _CombinedScreenState();
}

class _CombinedScreenState extends State<CombinedScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Combined Screen')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.center,
              children: [
                CameraPreview(_controller),
                ModelViewer(
                  src: 'assets/piano3d.glb',
                  alt: 'A 3D model of a piano',
                  ar: true,
                  autoRotate: true,
                  iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
                  disableZoom: true,
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            if (!mounted) return;
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen1(imagePath: image.path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}


class DisplayPictureScreen1 extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen1({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}


*/

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:audioplayers/audioplayers.dart';

class BackgroundMusicPlayer {
  static AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> play(String musicAsset) async {
    await _audioPlayer.play(AssetSource(musicAsset));
  }

  static Future<void> pause() async {
    await _audioPlayer.pause();
  }

  static Future<void> stop() async {
    await _audioPlayer.stop();
  }
}

class CombinedScreen extends StatefulWidget {
  final CameraDescription camera;
  final String musicAsset;
  final String modelAsset;

  const CombinedScreen({
    Key? key,
    required this.camera,
    required this.musicAsset,
    required this.modelAsset,
  }) : super(key: key);

  @override
  _CombinedScreenState createState() => _CombinedScreenState();
}

class _CombinedScreenState extends State<CombinedScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    BackgroundMusicPlayer.play(widget.musicAsset);
  }

  @override
  void dispose() {
    _controller.dispose();
    BackgroundMusicPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Combined Screen')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.center,
              children: [
                CameraPreview(_controller),
                ModelViewer(
                  //src: 'assets/piano3d.glb',
                  src: widget.modelAsset,
                  alt: 'A 3D model of a piano',
                  ar: true,
                  autoRotate: true,
                  iosSrc:
                      'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
                  disableZoom: true,
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            if (!mounted) return;
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    DisplayPictureScreen1(imagePath: image.path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen1 extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen1({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
