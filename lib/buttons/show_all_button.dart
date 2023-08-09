import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacksitest/state_management/products_bloc.dart';

class ShowAllButton extends StatelessWidget {
  final bool activeBorder;
  final VoidCallback onTap;
  const ShowAllButton({

    super.key, this.activeBorder = false, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.read<ProductsBloc>().fetchProducts();
        onTap();
      },
      child: Container(
        margin: const EdgeInsetsDirectional.only(end: 3),
        padding: const EdgeInsets.all(5),
        width: 100,
        decoration: BoxDecoration(
          border: activeBorder?Border.all(color: Theme.of(context).primaryColor,width: 2):null,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 7,spreadRadius: 1
          ),
        ]
        ),
        child: Column(
          children: [
            Expanded(child: Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(10)),
              child: Center(child: Image.asset("assets/images/allcat.png"),),
            )),
            const SizedBox(height: 3),
            const Text("عرض الكل"),
          ],
        ),
      ),
    );
  }
}