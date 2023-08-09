import 'package:flutter/material.dart';

class AddProductButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddProductButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(10)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              "اضافه المنتج",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}