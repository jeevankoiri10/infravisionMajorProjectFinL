import 'package:flutter/material.dart';

class ImageFullScreenPage extends StatelessWidget {
  final String imageUrl;

  ImageFullScreenPage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Full Screen Image')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: imageUrl,
            child: Image.network(imageUrl),
          ),
        ),
      ),
    );
  }
}
