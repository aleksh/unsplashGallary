import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:un_gallery/models/models.dart';
import 'package:un_gallery/screens/PhotoScreen.dart';

class PhotoTile extends StatelessWidget {
  final Photo photo;

  PhotoTile({Key key, @required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(PhotoScreen.routeName, arguments: photo);
          },
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: photo.smallImage,
                placeholder: (context, url) => const Center(
                  child: const CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  height: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Author: ${photo.author}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  decoration: const BoxDecoration(color: Colors.black54),
                ),
              ),
            ],
          )),
    );
  }
}
