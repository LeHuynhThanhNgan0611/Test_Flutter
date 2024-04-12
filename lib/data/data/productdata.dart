import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:provider_app/data/model/productmodel.dart';

class ReadData {
  Future<List<ProductModel>> loadData() async {
    var data = await rootBundle.loadString("assets/files/productlist.json");
    var dataJson = jsonDecode(data);
    return (dataJson["data"] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
