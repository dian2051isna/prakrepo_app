import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PreviewCamera extends StatefulWidget {
  final List<CameraDescription> cameras;

  const PreviewCamera({Key? key, required this.cameras}) : super(key: key);

  @override
  State<PreviewCamera> createState() => _PreviewCameraState();
}

class _PreviewCameraState extends State<PreviewCamera> {
  late CameraController _cameraController;
  late Future<void> _initializeCameraController;
  int _kameraIndex = 0;

  @override
  void InitState() {
    super.initState();
    _initCamera(cameras[_kameraIndex]);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _initCamera(CameraController cameraController) {
    _cameraController = CameraController(cameraController, ResolutionPreset.high);
    _initializeCameraController = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kamera")),
      body: 
        FutureBuilder<void>(
          future: _initializeCameraController, 
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if (snapshot.hasError){
              return const Center(child: Text("Terjadi error"));
            }
            return Stack(children: [CameraPreview(_cameraController)]),

          })
    );
  }
}
