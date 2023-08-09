import 'dart:convert';

class Product {
  final String id;
  final String name;
  final String store;
  final List<String> images;
  final num price;
  final String category;

  Product({required this.id,required this.name, required this.store, required this.images, required this.price, required this.category});

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'store': store,
      'images': images,
      'price': price,
      'category': category,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id:map['id']??'',
      name: map['name'] ?? '',
      store: map['store'] ?? '',
      images: List<String>.from(map['images']??[]),
      price: map['price']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  Product copyWith({
    String? id,
    String? name,
    String? store,
    List<String>? images,
    num? price,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      store: store ?? this.store,
      images: images ?? this.images,
      price: price ?? this.price,
      category: category ?? this.category,
    );
  }
}
