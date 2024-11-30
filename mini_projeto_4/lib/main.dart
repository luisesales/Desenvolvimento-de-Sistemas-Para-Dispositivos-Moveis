import 'package:mini_projeto_4/pages/product_detail_page.dart';
import 'package:mini_projeto_4/pages/product_form_page.dart';
import 'package:mini_projeto_4/pages/product_cart_page.dart';
import 'package:mini_projeto_4/pages/products_overview_page.dart';
import 'package:mini_projeto_4/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/product_list.dart';
import 'model/cart.dart'; // Importe o modelo de Cart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ProductList()), // Provedor para os produtos
        ChangeNotifierProvider(
            create: (_) => Cart()), // Provedor para o carrinho
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ThemeData()
              .copyWith()
              .colorScheme
              .copyWith(primary: Colors.pink, secondary: Colors.orangeAccent),
        ),
        home: ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.PRODUCT_FORM: (context) => const ProductFormPage(),
          AppRoutes.PRODUCT_CART: (context) => const ProductCartPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
