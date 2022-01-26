import 'package:flutter/material.dart';
import 'package:routing/page/home_page.dart';
import 'package:routing/page/photo_detail.dart';

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
          HomePage.route: (_) => HomePage(),
          PhotoDetailPage.route: (context) => PhotoDetailPage(
                args: settings.arguments as PhotoDetailPageArgs,
              ),
        };

        return MaterialPageRoute(builder: routes[settings.name]!);
      },
    );
  }
}
