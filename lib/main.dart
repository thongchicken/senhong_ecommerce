import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senhongecommerce/navigator_controller.dart';
import 'package:senhongecommerce/provider/cart_provider.dart';
import 'package:senhongecommerce/provider/product_provider.dart';
import 'package:senhongecommerce/screen/login_screen.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_product) => ProductProvider()),
        ChangeNotifierProvider(create: (_cart) => CartProvider())
      ],
      child: MaterialApp(
        title: "Sen Hồng",
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        debugShowCheckedModeBanner: false,
        home: NavigatorController(),

      ),
    );
  }
}
