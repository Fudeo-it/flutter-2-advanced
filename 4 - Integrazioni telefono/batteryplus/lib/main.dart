import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

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
        title: Text("battery_plus"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            final battery = Battery();
            if (await battery.batteryLevel > 5) {
              print("Esegui processo di scanning: ${await battery.batteryLevel}");
            }
          },
          child: Text("Avvia processo scanning qr code"),
        ),
      ),
    );
  }
}
