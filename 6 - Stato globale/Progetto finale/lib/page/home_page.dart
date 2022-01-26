import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stato_globale/bloc/shopping_cart_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShoppingCartBloc>(context).add(ShoppingCartBlocEventInit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar(),
      body: Stack(
        children: [
          sectionProducts(),
          floatingButton(),
        ],
      ),
    );
  }

  AppBar appBar() => AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "LUIGI'S",
              style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            Text(
              "Spedizione gratuita per ordini > 50€",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );

  Widget sectionProducts() => BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(builder: (context, state) {
        if (state is ShoppingCartBlocStateLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          final products = (state as ShoppingCartBlocStateLoaded).products;

          return GridView.builder(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 100),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(products[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    products[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "€ ${products[index].price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 8),
                  MaterialButton(
                    onPressed: () {
                      BlocProvider.of<ShoppingCartBloc>(context).add(
                        ShoppingCartBlocEventToggle(products[index]),
                      );
                    },
                    minWidth: double.infinity,
                    height: 40,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                    child: Text(
                      products[index].inShoppingCart ? "Rimuovi" : "Aggiungi",
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });

  Widget floatingButton() => BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(builder: (context, state) {
        if (state is ShoppingCartBlocStateLoading) {
          return SizedBox();
        } else {
          final products = (state as ShoppingCartBlocStateLoaded).products;
          final productsInShoppingCart = products.where((it) => it.inShoppingCart).toList();

          if (productsInShoppingCart.isEmpty) {
            return SizedBox();
          } else {
            return Positioned(
              bottom: 32,
              left: 16,
              right: 16,
              child: MaterialButton(
                onPressed: () => Navigator.pushNamed(context, "/checkout"),
                minWidth: double.infinity,
                height: 50,
                color: Colors.yellow.shade700,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "Completa acquisto (${productsInShoppingCart.length})",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }
        }
      });
}
