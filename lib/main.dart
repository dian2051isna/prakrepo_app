import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:pert3/pages/camera_page.dart';
import 'package:pert3/pages/home_page.dart';
import 'package:pert3/pages/pick_gambar.dart';
import 'package:pert3/pages/product_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    cameras = await availableCameras();
  } catch (e) {
    debugPrint("Camera tidak tersedia $e");
  }

  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belajar Flutter',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.lightGreenAccent),
      ),
      // home: const MyHomePage(title: 'Flutter - Pertemuan 3'),
      // home: const ProductPage(),
      // home: const CameraPage(),
      home: const PickImageScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _usernameController = TextEditingController();
  bool _showPassword = true;
  bool _checkBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .center,
            spacing: 20,
            children: [
              Container(
                height: 250,
                width: 250,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.all(10),
                child: Image.asset('asset/logo_login.png'),
              ),
              Row(
                mainAxisAlignment: .start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(hintText: "Username"),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      print("Button Diklik");
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: _showPassword
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                ),
                obscureText: _showPassword,
                obscuringCharacter: "*",
              ),
              Row(
                children: [
                  Checkbox(
                    value: _checkBox,
                    onChanged: (bool? value) {
                      setState(() {
                        _checkBox = !_checkBox;
                      });
                    },
                  ),
                  Text("Ingat saya"),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 80,
                                  ),
                                  SizedBox(height: 16),
                                  Text("Login Berhasil !!!"),
                                ],
                              ),
                            );
                          },
                        );
                        // kasih jeda 2 detik
                        await Future.delayed(Duration(seconds: 2));
                        // cek apakah
                        if (context.mounted) {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                username: _usernameController.text,
                              ),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateColor.resolveWith(
                          (states) => Colors.blue,
                        ),
                        fixedSize: WidgetStatePropertyAll(
                          Size(double.infinity, 50),
                        ),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Penambahan',
      //   backgroundColor: Colors.grey,
      //   // child: const Icon(Icons.add),
      //   child: const Icon(Icons.upcoming),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.navigate_before),
      //       label: 'Back',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.manage_search_rounded),
      //       label: 'Apa saja',
      //     ),
      //   ],
      // ),
    );
  }
}


// List<CameraDescription> cameras = [];
// Run | Debug | Profile
// void main() async (
// WidgetsFlutterBinding.ensureInitialized();
// try{
// cameras await availableCameras();
// catch(e){
// debugPrint("Camera tidak tersedia Se");
// runApp
// DevicePreview(enabled: IkReleaseMode, builder: (context) => const MyApp()),
// );