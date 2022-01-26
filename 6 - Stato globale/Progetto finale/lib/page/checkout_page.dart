import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stato_globale/bloc/shopping_cart_bloc.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ShoppingCartBloc, ShoppingCartBlocState>(
      listener: (context, state) {
        final products = (state as ShoppingCartBlocStateLoaded).products;
        final productsInShoppingCart = products.where((it) => it.inShoppingCart).toList();

        if (productsInShoppingCart.isEmpty) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: appBar(),
        body: CustomScrollView(
          slivers: [
            sectionProductList(),
            sectionCostRecap(),
          ],
        ),
      ),
    );
  }

  AppBar appBar() => AppBar(
        backgroundColor: Colors.grey.shade100,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Checkout",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );

  Widget sectionProductList() => BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(builder: (context, state) {
        final products = (state as ShoppingCartBlocStateLoaded).products;
        final productsInShoppingCart = products.where((it) => it.inShoppingCart).toList();

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(productsInShoppingCart[index].imageUrl),
                ),
                title: Text(
                  productsInShoppingCart[index].name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "€ ${productsInShoppingCart[index].price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    BlocProvider.of<ShoppingCartBloc>(context).add(
                      ShoppingCartBlocEventToggle(productsInShoppingCart[index]),
                    );
                  },
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            childCount: productsInShoppingCart.length,
          ),
        );
      });

  Widget sectionCostRecap() => BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(builder: (context, state) {
        final products = (state as ShoppingCartBlocStateLoaded).products;
        final productsInShoppingCart = products.where((it) => it.inShoppingCart).toList();

        final subtotal = productsInShoppingCart.map((it) => it.price).sum;
        final tax = subtotal * 0.2;
        final total = subtotal + tax;

        return SliverToBoxAdapter(
          child: Column(
            children: [
              CheckoutRow(
                text: "Sottotale",
                value: subtotal,
              ),
              CheckoutRow(
                text: "IVA",
                value: tax,
              ),
              ListTile(
                dense: true,
                title: Text(
                  "Totale",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "€ ${total.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: double.infinity,
                  height: 50,
                  color: Colors.yellow.shade700,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Acquista",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

class CheckoutRow extends StatelessWidget {
  final String text;
  final double value;

  const CheckoutRow({
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
        ),
      ),
      trailing: Text(
        "€ ${value.toStringAsFixed(2)}",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
