import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/data/model/product_viewmodel.dart';
import 'package:provider_app/page/mainpage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsVM(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Mainpage(),
      ),
    );
  }
}
