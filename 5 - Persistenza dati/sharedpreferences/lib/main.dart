import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    SharedPreferences.getInstance().then((sharedPreferences) {
      final enabled = sharedPreferences.getBool("home_page.settings.dark_mode");
      setState(() {
        darkModeEnabled = enabled ?? false;
      });
    });
  }

  void onDarkModeToggle(bool enabled) async {
    setState(() {
      darkModeEnabled = enabled;
    });

    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool("home_page.settings.dark_mode", darkModeEnabled);
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
