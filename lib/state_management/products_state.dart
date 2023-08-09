part of 'products_bloc.dart';

@immutable
sealed class ProductsState {
  final List<Product> products;

  const ProductsState(this.products);
}

final class ProductsInitial extends ProductsState {
  const ProductsInitial(super.products);
}
final class Productsloading extends ProductsState {
  const Productsloading(super.products);
}
final class Productsloaded extends ProductsState {
  const Productsloaded(super.products);
  
}
