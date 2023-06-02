import 'package:flutter/material.dart';

class SubmittedProves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submitted Proves'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 6, // Replace with the actual number of images
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Handle tap on the image
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDetailsScreen(
                    imageUrl:
                        'https://example.com/image$index.jpg', // Replace with the image URL
                  ),
                ),
              );
            },
            child: Image.network(
              'https://example.com/image$index.jpg', // Replace with the image URL
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

class ImageDetailsScreen extends StatelessWidget {
  final String imageUrl;

  ImageDetailsScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Details'),
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
