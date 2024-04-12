import 'package:flutter/material.dart';
import 'package:provider_app/data/data/productdata.dart';
import 'package:provider_app/data/model/productmodel.dart';
import 'package:provider_app/page/product/productbody.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ProductModel> lstProduct = [];

  Future<String> loadProdList() async {
    lstProduct = await ReadData().loadData();
    return '';
  }

  @override
  void initState() {
    super.initState;
    loadProdList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: loadProdList(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    if (index >= lstProduct.length) {
                      return Container();
                    }
                    return itemGridView(lstProduct[index]);
                  });
            }),
      ),
    );
  }
}
