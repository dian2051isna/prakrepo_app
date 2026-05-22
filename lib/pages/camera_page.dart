import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<CameraDescription> cameras = [];
  CameraController? controller;

  Future<void> setupCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller!.initialize();
  }

  // nanti coba dibuat skenario try and catch, semisal kamera gak kedetek atau gak tersedia
  Future<void> takePicture() async {
    final image = await controller!.takePicture();
    print('Foto tersimpan di ${image.path}');
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return CameraPreview(controller!);
  }
}


// class MainCameraState extends State<MainCamera> {
//    @override
//    Widget build(BuildContext context) {
//      return Container(
//        child: IconButton (onPressed:
//        () => Navigator.push(context,
//        MaterialPageRoute (builder: (_) => PreviewCamera (cameras: cameras))
//        ), icon: Icon(Icons.camera_alt)), // IconButton
//       ); // Container
//     }