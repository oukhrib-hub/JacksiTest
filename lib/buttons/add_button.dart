import 'package:flutter/material.dart';

class AddBtn extends StatelessWidget {
   final VoidCallback onTap;
  const AddBtn({
    super.key, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2, spreadRadius: 1),
          ],
        ),
        height: 40,
        width: 40,
        child: const Icon(Icons.add),
      ),
    );
  }
}