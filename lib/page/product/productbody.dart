import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/conf/const.dart';
import 'package:provider_app/data/model/product_viewmodel.dart';
import 'package:provider_app/data/model/productmodel.dart';

Widget itemGridView(ProductModel productModel) {
  bool isFavorite = false;

  return Container(
    margin: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(
                urlProductImg + productModel.img!,
                height: 100,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              productModel.name ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              NumberFormat('###,###.###').format(productModel.price),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 15),
            Consumer<ProductsVM>(
              builder: (context, value, child) => ElevatedButton(
                onPressed: () {
                  value.add(productModel);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Màu nền của button
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(
                        15.0,
                      ), // Chỉ áp dụng border cho 2 góc dưới của button
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ), // Icon "Add"
                      SizedBox(width: 8),
                      Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ), // Text "Add"
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 244, 222, 54),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: const Text(
              '15%',
              style: TextStyle(
                color: Color.fromARGB(255, 26, 25, 25),
                fontSize: 12,
              ),
            ),
          ),
        ),
        const Positioned(
          top: 0,
          right: 0,
          child: FavoriteButton(), // Sử dụng FavoriteButton ở đây
        ),
      ],
    ),
  );
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: _isFavorite ? Colors.red : Colors.grey,
      ),
    );
  }
}
