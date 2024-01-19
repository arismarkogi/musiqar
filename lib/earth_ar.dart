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
  double _scale = 1.0;

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


  void _updateScale(double newScale) {
    setState(() {
      _scale = newScale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experience AR')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      //CameraPreview(_controller),
                      Transform.scale(
                        scale: _scale,
                        child: ModelViewer(
                          src: widget.modelAsset,
                          alt: 'Augmented Reality',
                          ar: true,
                          autoRotate: true,
                          iosSrc:
                              'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
                          disableZoom: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Slider(
                    value: _scale,
                    min: 0.2, 
                    max: 2.0,
                    onChanged: _updateScale,
                  ),
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
