import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const route = "/user/profile";

  final ProfilePageArgs args;

  const ProfilePage({
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ProfilePage: ${args.name}"),
      ),
    );
  }
}

class ProfilePageArgs {
  final String name;

  const ProfilePageArgs({required this.name});
}
