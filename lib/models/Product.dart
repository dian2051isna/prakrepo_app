class Product {
  final String productId;
  final String name;
  final int price;
  final String imageUrl;

  Product({
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as List;

    return Product(
      productId: json['product_id'],
      name: json['name'],
      price: json['price'],
      imageUrl: images[0]['image_path'],
    );
  }
}
