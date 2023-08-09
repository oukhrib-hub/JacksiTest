import 'dart:io';

import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.direction,
  });
  final Axis direction;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(vertical: 5,horizontal: direction == Axis.horizontal ?0:5),
      //height: direction == Axis.horizontal ? 120 : 300,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Flex(
        direction: direction,
        children: [
          if (direction == Axis.horizontal)
            Builder(
              builder: (context) {
                if(product.images.isNotEmpty) {
                  return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(product.images.first),
                    width:120,
                    height:120,
                    fit: BoxFit.cover,
                  ),
                );
                }else{
                  return Container();
                }
              }
            ),
          if (direction == Axis.vertical)
            Expanded(
              child: Builder(
                builder: (context) {
                  if(product.images.isNotEmpty) {
                    return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(product.images.first),
                      width:double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                  }else{
                    return Container();
                  }
                }
              ),
            ),
          if (direction == Axis.horizontal)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Row(
                    children: [
                      Text(product.price.toString(),
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20)),
                      const SizedBox(width: 5),
                      const Text("دولار")
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(5)),
                    child: Text(product.store, style: const TextStyle(color: Colors.grey)),
                  )
                ],
              ),
            ),
          ),
          if (direction == Axis.vertical)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Text(product.price.toString(),
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20)),
                    const SizedBox(width: 5),
                    const Text("دولار")
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(5)),
                  child: Text(product.store, style: const TextStyle(color: Colors.grey)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
