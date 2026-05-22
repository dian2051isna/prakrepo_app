import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({super.key});

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  File? gambar;
  Future pick(ImageSource sumber) async {
    final gbr = await ImagePicker().pickImage(source: sumber);

    if (gbr != null) {
      setState(() {
        gambar = File(gbr.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ambil Gambar")),
      body: Center(
        child: Column(
          children: [
            gambar != null
                ? Image.file(gambar!, height: 200, width: 200)
                : Text("Tidak ada gambar!"),

            // Kamera
            ElevatedButton(
              onPressed: () => pick(ImageSource.camera),
              child: Text("Kamera"),
            ),

            // Galeri
            ElevatedButton(
              onPressed: () => pick(ImageSource.gallery),
              child: Text("Galeri"),
            ),
          ],
        ),
      ),
    );
  }
}
