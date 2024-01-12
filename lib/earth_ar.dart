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
