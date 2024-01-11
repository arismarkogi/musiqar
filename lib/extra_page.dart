import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class AR extends StatefulWidget {
  const AR({super.key});

  @override
  State<AR> createState() => _AR();
}

class _AR extends State<AR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ModelViewer(
          src: 'assets/piano3d.glb',
          alt: "A 3D model",
          autoPlay: true,
          autoRotate: false,
          cameraControls: true,
        ),
      ),
    );
  }
}
