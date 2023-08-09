import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacksitest/state_management/products_bloc.dart';

import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  final bool activeBorder;
  const CategoryCard({super.key, required this.category, required this.onTap, this.activeBorder = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProductsBloc>().fetchProducts(category: category.name);
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.all(5),
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 7,spreadRadius: 1
          ),
        ],
          border: activeBorder?Border.all(color: Theme.of(context).primaryColor,width: 2):null
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/images/${category.image}", fit: BoxFit.cover)),
              ),
            ),
            const SizedBox(height: 3),
            Text(category.name),
          ],
        ),
      ),
    );
  }
}
