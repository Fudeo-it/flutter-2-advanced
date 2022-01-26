import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("url_launcher"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            const url = "https://google.it";

            if (await canLaunch(url)) {
              launch(url);
            }
          },
          child: Text("Apri google.it"),
        ),
      ),
    );
  }
}
