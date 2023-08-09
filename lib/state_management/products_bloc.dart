import 'package:bloc/bloc.dart';
import 'package:jacksitest/database.dart';
import 'package:meta/meta.dart';

import '../models/product.dart';

part 'products_state.dart';

class ProductsBloc extends Cubit<ProductsState> {
  ProductsBloc() : super(const ProductsInitial([]));

  Future<void> fetchProducts({String? category}) async {
    emit(Productsloading(state.products));
    List<Product> products = await Database.getAllProducts();
    if (category != null) {
      products = products.where((element) => element.category == category).toList();
    }
    emit(Productsloaded(products));
  }

  Future<void> addNewProduct(Product product) async {
    await Database.addNewProduct(product);
    emit(Productsloaded(Database.products));
  }
}
