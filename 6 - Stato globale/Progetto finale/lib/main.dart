import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stato_globale/bloc/shopping_cart_bloc.dart';
import 'package:stato_globale/page/checkout_page.dart';
import 'package:stato_globale/page/home_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ShoppingCartBloc()),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (_) => HomePage(),
        "/checkout": (_) => CheckoutPage(),
      },
    );
  }
}
