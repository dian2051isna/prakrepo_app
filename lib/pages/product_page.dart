import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pert3/models/Product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>> fetchProduct() async {
    final url = Uri.parse("https://api.dianeka.web.id/api/products");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);

        List<dynamic> data = body['data'] ?? [];
        return data.map((product) => Product.fromJson(product)).toList();
      } else {
        throw Exception("Gagal mengambil data produk ${response.statusCode}");
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan $e');
    }
  }

  // SAMPAI SINI YG PERLU DIKULIK, KARENA DIAMBIL DARI WEBSITENYA EKA
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman Produk")),
      body: FutureBuilder<List<Product>>(
        future: fetchProduct(),
        builder: (context, snapshot) {
          // Evaluasi status snapshot
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi kesalahan pada server: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData) {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                // Akses data menggunakan mekanisme indeks
                final item = products[index];
                return ListTile(
                  leading: Image.network(
                    item.imageUrl,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Rp ${item.price}'),
                );
              },
            );
          }
          return const Center(child: Text('Tidak ada produk tersedia.'));
        },
      ),
    );
  }
}
