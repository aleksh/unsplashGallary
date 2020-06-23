import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:un_gallery/models/models.dart';

class PhotoScreen extends StatelessWidget {
  final Photo photo;
  static const routeName = "/photo";

  PhotoScreen({this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(photo.author),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: photo.image,
                placeholder: (context, url) => const Center(
                  child: const CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
