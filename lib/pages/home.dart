import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacksitest/buttons/add_button.dart';
import 'package:jacksitest/database.dart';
import 'package:jacksitest/state_management/products_bloc.dart';
import 'package:jacksitest/cards/category_card.dart';

import '../buttons/show_all_button.dart';
import '../models/product.dart';
import '../cards/product_card.dart';
import 'new_product.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<void> initDatabase;
  Axis cardDirection = Axis.horizontal;
  @override
  void initState() {
    Database.homeContext = context;
    initDatabase = Database.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المنتجات"),
        actions: [
          AddBtn(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NewProduct()));
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: initDatabase,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "التصنيفات",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 110,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            const ShowAllButton(),
                            Row(
                              children: List.generate(
                                Database.categories.length,
                                (index) {
                                  return CategoryCard(category: Database.categories[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(top: 10, end: 15),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          child: TextButton.icon(
                            style: const ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.redAccent)),
                            onPressed: () {
                              setState(() {
                                cardDirection = cardDirection == Axis.horizontal ? Axis.vertical : Axis.horizontal;
                              });
                            },
                            icon: const ImageIcon(AssetImage("assets/images/grid.png")),
                            label: cardDirection == Axis.horizontal
                                ? const Text("تغيير عرض المنتجات الى افقي")
                                : const Text("تغيير عرض المنتجات الى عمودي"),
                          ),
                        )
                      ],
                    ),
                    BlocBuilder<ProductsBloc, ProductsState>(
                      builder: (context, state) {
                        List<Product> products = state.products;
                        products.sort((b, a) => a.id.compareTo(b.id));
                        if (products.isEmpty) {
                          return SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: Center(child: TextButton(
                                style: ButtonStyle(textStyle: MaterialStatePropertyAll(Theme.of(context).textTheme.bodyMedium)),
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NewProduct()));
                                }, child: const Text("أضف المنتجات لتظهر في الصفحة"))));
                        }
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                          itemCount: products.length,
                          itemBuilder: (_, index) {
                            final product = products[index];
                            return ProductCard(product: product, direction: cardDirection);
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: cardDirection == Axis.horizontal ? 1 : 2,
                            childAspectRatio: cardDirection == Axis.horizontal ? 2.5 : 0.7,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
