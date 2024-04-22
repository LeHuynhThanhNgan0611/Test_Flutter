import 'dart:js';

import 'package:flutter/widgets.dart';
import 'package:provider_app/data/model/productmodel.dart';

class ProductsVM with ChangeNotifier {
  List<ProductModel> lst = [];
  // int totalQuantity = 0;
  //thêm 1 item vào danh sách
  add(ProductModel mo) {
    lst.add(mo);
    notifyListeners();
  }

  // Thêm phương thức clearAllItems để xóa tất cả các mục trong danh sách
  void clearAllItems() {
    lst.clear();
    notifyListeners();
  }

  // void _updateTotalQuantity() {
  //   int total = 0;
  //   for (var product in lst) {
  //     total += product.quantity;
  //   }
  //   totalQuantity = total;
  // }

// Thêm phương thức incrementItemQuantity để tăng số lượng của một mục
  void incrementItemQuantity(ProductModel productModel) {
    productModel.quantity++;
    // _updateTotalQuantity(); // Cập nhật tổng số lượng sản phẩm
    notifyListeners();
  }

// Thêm phương thức decrementItemQuantity để giảm số lượng của một mục
  void decrementItemQuantity(ProductModel productModel) {
    if (productModel.quantity > 0) {
      productModel.quantity--;
      // _updateTotalQuantity(); // Cập nhật tổng số lượng sản phẩm
      notifyListeners();
    }
  }

// Thêm phương thức removeItem để xóa một mục cụ thể khỏi danh sách
  void removeItem(ProductModel productModel) {
    lst.remove(productModel);
    // _updateTotalQuantity(); // Cập nhật tổng số lượng sản phẩm
    notifyListeners();
  }

  // xóa vị trí
  del(int index) {
    lst.removeAt(index);
    notifyListeners();
  }
}
