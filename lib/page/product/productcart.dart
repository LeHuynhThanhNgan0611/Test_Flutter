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
  int totalQuantity = 0;
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
                          offset: const Offset(0, 3),
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
                              const Icon(Icons.image),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.lst[index].name ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                NumberFormat('###,###.###')
                                    .format(value.lst[index].price),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                value.lst[index].des!,
                                style: const TextStyle(
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
                              icon: const Icon(Icons.add),
                              color: Colors.teal,
                            ),
                            Text(
                              '${value.lst[index].quantity}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                value.decrementItemQuantity(value.lst[index]);
                              },
                              icon: const Icon(Icons.remove),
                              color: Colors.teal,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                value.removeItem(value.lst[index]);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, // Màu nền của nút
                              ),
                              child: const Icon(
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
                    const Text(
                      'Tổng tiền: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      calculateTotal(context), // Tính tổng tiền
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Xóa tất cả các sản phẩm khỏi giỏ hàng
                        Provider.of<ProductsVM>(context, listen: false)
                            .clearAllItems();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red, // Màu nền của nút "Xóa tất cả"
                      ),
                      child: const Text(
                        'Xóa tất cả',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Thực hiện thanh toán
                        _performPayment(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.teal, // Màu nền của nút "Thanh toán"
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.shopping_cart, color: Colors.white),
                          const SizedBox(width: 10),
                          Text(
                            'Đặt hàng ($totalQuantity)', // Hiển thị số lượng sản phẩm
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
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

  void _performPayment(BuildContext context) {
    // Thực hiện thanh toán ở đây

    // Hiển thị thông báo thanh toán thành công
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.teal,
                  size: 50,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Đặt hàng thành công",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Cảm ơn bạn đã đặt hàng.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng hộp thoại
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
