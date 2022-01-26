import 'package:flutter/material.dart';
import 'package:push_named/page/home_page.dart';
import 'package:push_named/page/profile_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.route,
      onGenerateRoute: (settings) {
        final routes = {
          HomePage.route: (context) => HomePage(),
          ProfilePage.route: (context) => ProfilePage(
                args: settings.arguments as ProfilePageArgs,
              ),
        };

        return MaterialPageRoute(builder: routes[settings.name]!);
      },
    );
  }
}
