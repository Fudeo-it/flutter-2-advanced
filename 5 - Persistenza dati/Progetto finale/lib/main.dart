import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:persistenza_dati/page/home_page.dart';
import 'package:persistenza_dati/repository/savedQuotesRepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final savedQuotesRepository = SavedQuotesRepository();
  await savedQuotesRepository.initialize();
  GetIt.I.registerSingleton(savedQuotesRepository);

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
