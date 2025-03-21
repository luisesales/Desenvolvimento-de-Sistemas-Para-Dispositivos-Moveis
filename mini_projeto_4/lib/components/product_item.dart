import 'package:mini_projeto_4/model/cart.dart';
import 'package:mini_projeto_4/model/product_list.dart';
import 'package:mini_projeto_4/utils/app_routes.dart';
import 'package:mini_projeto_4/model/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //PEGANDO CONTEUDO PELO PROVIDER
    //
    final product = context.watch<Product>();

    return ClipRRect(
      //corta de forma arredondada o elemento de acordo com o BorderRaius
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
          },
        ),
        header: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Provider.of<Cart>(context, listen: false).addProduto(product);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {
              //adicionando metodo ao clique do botão
              product.toggleFavorite();
              Provider.of<ProductList>(context, listen: false)
                  .saveProduct(product.toMapForm());
            },
            //icon: Icon(Icons.favorite),
            //pegando icone se for favorito ou não
            icon: Consumer<Product>(
              builder: (context, product, child) => Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
            ),
            //isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              onPressed: () => Provider.of<ProductList>(context, listen: false)
                  .removeProduct(product),
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}
