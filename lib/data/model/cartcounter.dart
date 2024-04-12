import 'package:flutter/material.dart';

class CartCounter extends StatelessWidget {
  const CartCounter({super.key, required this.count});
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(color: Colors.red[800], shape: BoxShape.circle),
      child: Center(
          child: Text(
        count,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      )),
    );
  }
}
