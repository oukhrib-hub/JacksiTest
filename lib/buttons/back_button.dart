import 'package:flutter/material.dart';

class BackBtn extends StatelessWidget {
  final VoidCallback onTap;
  const BackBtn({
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
        child: const Padding(
          padding:  EdgeInsetsDirectional.only(start: 8),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }
}