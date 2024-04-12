import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/conf/const.dart';
import 'package:provider_app/data/model/product_viewmodel.dart';
import 'package:provider_app/data/model/productmodel.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({Key? key});

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<ProductsVM>(
              builder: (context, value, child) => ListView.builder(
                itemCount: value.lst.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          urlProductImg + value.lst[index].img!,
                          height: 80,
                          width: 80,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.lst[index].name ?? '',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                NumberFormat('###,###.###')
                                    .format(value.lst[index].price),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                value.lst[index].des!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                value.incrementItemQuantity(value.lst[index]);
                              },
                              icon: Icon(Icons.add),
                              color: Colors.teal,
                            ),
                            Text(
                              '${value.lst[index].quantity}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                value.decrementItemQuantity(value.lst[index]);
                              },
                              icon: Icon(Icons.remove),
                              color: Colors.teal,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                value.removeItem(value.lst[index]);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red, // Màu nền của nút
                              ),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            color: Colors.grey.shade200,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng tiền: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${calculateTotal(context)}', // Tính tổng tiền
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Xóa tất cả các sản phẩm khỏi giỏ hàng
                        Provider.of<ProductsVM>(context, listen: false)
                            .clearAllItems();
                      },
                      child: Text(
                        'Xóa tất cả',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Màu nền của nút "Xóa tất cả"
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Thanh toán
                      },
                      child: Text(
                        'Thanh toán',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal, // Màu nền của nút "Thanh toán"
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String calculateTotal(BuildContext context) {
    var total = 0;
    for (var product in Provider.of<ProductsVM>(context).lst) {
      total += (product.price ?? 0) * (product.quantity ?? 0);
    }
    return NumberFormat('###,###.###').format(total);
  }
}
