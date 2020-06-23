part of 'photos_bloc.dart';

abstract class PhotosState extends Equatable {
  const PhotosState();

  @override
  List<Object> get props => [];
}

class PhotosInitial extends PhotosState {}

class PhotosLoaded extends PhotosState {
  final List<Photo> photos;

  const PhotosLoaded({@required this.photos});

  @override
  List<Object> get props => [photos];

  @override
  String toString() => 'Photos Loaded { photos: ${photos.length}}';
}

class PhotosError extends PhotosState {
  final String error;

  const PhotosError({this.error});

  @override
  String toString() => 'Photos Error { error: $error}';
}
