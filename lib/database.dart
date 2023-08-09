import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacksitest/state_management/products_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/category.dart';
import 'models/product.dart';

class Database {
  static late BuildContext homeContext;
  static late SharedPreferences prefs;
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    if (homeContext.mounted) {
      homeContext.read<ProductsBloc>().fetchProducts();
    }
  }

  static List<Product> products = [];

  static Future<List<Product>> getAllProducts() async {
    List<String> list = prefs.getStringList("products") ?? [];
    products = list.map((e) => Product.fromJson(e)).toList();
    return products;
  }

  static Future<void> addNewProduct(Product product) async {
    products.add(product);
    final stringList = products.map((e) => e.toJson()).toList();
    prefs.setStringList("products", stringList);
  }

  static List<Category> categories = [
    Category(name: "تصنيف 1", image: "cat1.png", id: 1),
    Category(name: "تصنيف 2", image: "cat2.png", id: 2),
    Category(name: "تصنيف 3", image: "cat3.png", id: 3),
  ];
}
