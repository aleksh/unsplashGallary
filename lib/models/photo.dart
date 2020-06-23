import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Photo extends Equatable {
  final String id;
  final int color;
  final String author;
  final String smallImage;
  final String image;

  const Photo({
    @required this.id,
    @required this.color,
    @required this.author,
    @required this.smallImage,
    @required this.image,
  });

  @override
  List<Object> get props => [id, color, author, smallImage, image];

  @override
  String toString() => 'Photo { id: $id}';
}
