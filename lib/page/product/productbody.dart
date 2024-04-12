import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/conf/const.dart';
import 'package:provider_app/data/model/product_viewmodel.dart';
import 'package:provider_app/data/model/productmodel.dart';

Widget itemGridView(ProductModel productModel) {
  return Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Image.asset(
          urlProductImg + productModel.img!,
          height: 100,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
        ),
      ),
      SizedBox(height: 8),
      Text(
        productModel.name ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 5),
      Text(
        NumberFormat('###,###.###').format(productModel.price),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
      ),
      SizedBox(height: 20),
      Consumer<ProductsVM>(
        builder: (context, value, child) => ElevatedButton(
          onPressed: () {
            value.add(productModel);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.teal, // Màu nền của button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(
                    15.0), // Chỉ áp dụng border cho 2 góc dưới của button
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white, size: 24), // Icon "Add"
                SizedBox(width: 8),
                Text('Add',
                    style: TextStyle(color: Colors.white)), // Text "Add"
              ],
            ),
          ),
        ),
      ),
    ]),
  );
}
