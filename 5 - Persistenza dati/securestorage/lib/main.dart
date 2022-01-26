import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool darkModeEnabled = false;

  @override
  void initState() {
    super.initState();

    final storage = FlutterSecureStorage();
    storage.read(key: "home_page.settings.dark_mode").then((enabled) {
      setState(() {
        darkModeEnabled = enabled == "true";
      });
    });
  }

  void onDarkModeToggle(bool enabled) async {
    setState(() {
      darkModeEnabled = enabled;
    });

    final storage = FlutterSecureStorage();
    storage.write(key: "home_page.settings.dark_mode", value: enabled.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SharedPreferences"),
        ),
        body: Column(
          children: [
            SwitchListTile(
              value: darkModeEnabled,
              secondary: Icon(Icons.monochrome_photos),
              title: Text("Abilita tema scuro"),
              onChanged: onDarkModeToggle,
            ),
          ],
        ));
  }
}
