import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacksitest/buttons/back_button.dart';
import 'package:jacksitest/database.dart';
import 'package:jacksitest/models/product.dart';
import 'package:jacksitest/state_management/products_bloc.dart';

import '../buttons/add_image_button.dart';
import '../buttons/add_product_button.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({super.key});

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  String? category;
  List<String> images = [];
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  final formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اضافة منتجات"),
        leadingWidth: 80,
        leading: BackBtn(onTap: () {
          Navigator.of(context).pop();
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Row(
                              children: List.generate(images.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: Stack(
                                        alignment: AlignmentDirectional.topEnd,
                                        children: [
                                          Image.file(
                                            File(images[index]),
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  images.removeAt(index);
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.red.withOpacity(0.75), shape: BoxShape.circle),
                                                child: const Icon(Icons.close, color: Colors.white, size: 20),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                );
                              }),
                            ),
                            Row(
                              children: List.generate(images.length < 4 ? 4 - images.length : 4, (index) {
                                return Container(
                                  margin: const EdgeInsets.all(4),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.05), spreadRadius: 1, blurRadius: 3)
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (validateMode != AutovalidateMode.disabled && images.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "يجب اضافة صورة على الأقل",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    AddImageButton(
                      onImagePIcked: (path) {
                        setState(() {
                          images.add(path);
                        });
                        debugPrint("onImagePIcked path === $path");
                      },
                    ),
                    const SizedBox(height: 10),
                    Form(
                      autovalidateMode: validateMode,
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("اسم المنتج"),
                          const SizedBox(height: 5),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: "اسم المنتج",
                            ),
                            validator: (value) {
                              if (nameController.text.isEmpty) {
                                return "اسم المنتج مطلوب";
                              }
                              return null;
                            },
                          ),
                          const Text("اسم المتجر"),
                          const SizedBox(height: 5),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: storeNameController,
                            decoration: const InputDecoration(
                              hintText: "اسم المتجر",
                            ),
                            validator: (value) {
                              if (storeNameController.text.isEmpty) {
                                return "اسم المتجر مطلوب";
                              }
                              return null;
                            },
                          ),
                          const Text("السعر"),
                          const SizedBox(height: 5),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            controller: priceController,
                            validator: (value) {
                              if (priceController.text.isEmpty) {
                                return "السعر مطلوب";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: "السعر",
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("التصنيف"),
                              const SizedBox(height: 5),
                              PopupMenuButton(
                                onCanceled: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                },
                                onSelected: (value) {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  setState(() {
                                    category = value;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  height: 55,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey.shade300, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          category ?? "التصنيف",
                                          style: const TextStyle(color: Colors.blue),
                                        ),
                                        Container(
                                            margin: const EdgeInsetsDirectional.only(end: 10),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Colors.blue, width: 2)),
                                            child: const Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color: Colors.blue,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                itemBuilder: (_) {
                                  return List.generate(Database.categories.length, (index) {
                                    return PopupMenuItem(
                                      value: Database.categories[index].name,
                                      child: Text(Database.categories[index].name),
                                    );
                                  });
                                },
                              ),
                              if (validateMode != AutovalidateMode.disabled && category == null)
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "يجب اختيار التصنيف",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AddProductButton(
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (formKey.currentState!.validate() && images.isNotEmpty && category != null) {
                    Product product = Product(
                      id: '${DateTime.now().millisecondsSinceEpoch}',
                      name: nameController.text,
                      store: storeNameController.text,
                      images: images,
                      price: num.tryParse(priceController.text) ?? 0,
                      category: category ?? "",
                    );
                    await context.read<ProductsBloc>().addNewProduct(product);

                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  } else {
                    setState(() {
                      validateMode = AutovalidateMode.onUserInteraction;
                      if (category != null) {
                        scrollController.jumpTo(scrollController.position.maxScrollExtent);
                      }
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
