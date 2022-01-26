import 'package:flutter/material.dart';
import 'package:routing/model/photo.dart';
import 'package:routing/page/photo_detail.dart';

class HomePage extends StatelessWidget {
  static const route = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          children: [
            Text(
              "ART",
              style: TextStyle(
                letterSpacing: 10,
              ),
            ),
            Text(
              "Dove l'uomo tocca il cielo",
              style: TextStyle(
                fontSize: 11,
                color: Colors.white54,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            PhotoDetailPage.route,
            arguments: PhotoDetailPageArgs(
              photoUrl: photos[index],
            ),
          ),
          child: Image.network(
            photos[index],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
