import 'package:flutter/widgets.dart';
import 'package:provider_app/data/model/productmodel.dart';

class ProductsVM with ChangeNotifier {
  List<ProductModel> lst = [];
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

  // Thêm phương thức incrementItemQuantity để tăng số lượng của một mục
  void incrementItemQuantity(ProductModel productModel) {
    productModel.quantity++;
    notifyListeners();
  }

  // Thêm phương thức decrementItemQuantity để giảm số lượng của một mục
  void decrementItemQuantity(ProductModel productModel) {
    if (productModel.quantity > 0) {
      productModel.quantity--;
      notifyListeners();
    }
  }

  // Thêm phương thức removeItem để xóa một mục cụ thể khỏi danh sách
  void removeItem(ProductModel productModel) {
    lst.remove(productModel);
    notifyListeners();
  }

  // xóa vị trí
  del(int index) {
    lst.removeAt(index);
    notifyListeners();
  }
}
