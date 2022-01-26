import 'package:flutter/material.dart';
import 'package:push_named/page/profile_page.dart';

class HomePage extends StatelessWidget {
  static const route = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: Center(
        child: TextButton(
          child: Text("Profilo utente"),
          onPressed: () {
            Navigator.pushNamed(
              context,
              ProfilePage.route,
              arguments: ProfilePageArgs(name: "Marco"),
            );
          },
        ),
      ),
    );
  }
}
