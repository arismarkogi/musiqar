import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;



class ARScreen extends StatefulWidget {
  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Flutter App'),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addARNode();
  }

  void _addARNode() {
    final node = ArCoreNode(
      shape: ArCoreSphere(
        materials: [ArCoreMaterial(color: Colors.blue)],
        radius: 0.1,
      ),
      position: vector.Vector3(0.0, 0.0, -1.5),
      rotation: vector.Vector4(0.0, 0.0, 0.0, 0.0),
    );

    arCoreController.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
