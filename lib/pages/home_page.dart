import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime tanggalSekarang = DateTime(2026, 4, 17);
  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? tanggalDipilih = await showDatePicker(
      context: context,
      firstDate: DateTime(2006, 1, 1),
      lastDate: DateTime(2045, 1, 2),
    );
    if (tanggalDipilih != null) {
      setState(() {
        tanggalSekarang = tanggalDipilih;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Column(children: [Text('Welcome, ${widget.username}!')]),
          Text("$tanggalSekarang"),
          ElevatedButton(
            onPressed: () {
              _pilihTanggal(context);
            },
            child: Text("Select Date"),
          ),
        ],
      ),
    );
  }
}
