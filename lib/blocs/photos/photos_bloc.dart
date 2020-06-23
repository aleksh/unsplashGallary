import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:un_gallery/models/models.dart';
import 'package:http/http.dart' as http;

part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final String _endpoint =
      "https://api.unsplash.com/photos?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9";
  final http.Client httpClient = http.Client();

  @override
  PhotosState get initialState => PhotosInitial();

  @override
  Stream<PhotosState> mapEventToState(
    PhotosEvent event,
  ) async* {
    if (event is PhotosFetch) {
      yield PhotosInitial();

      try {
        final photos = await _fetchPhotos();
        yield PhotosLoaded(photos: photos);
      } catch (error) {
        // test it
        print(error.toString());
        yield PhotosError(error: error.toString());
      }
    }
  }

  Future<List<Photo>> _fetchPhotos() async {
    final response = await httpClient.get(_endpoint);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List data = json.decode(response.body);

      return data
          .map((rawPhoto) => Photo(
                id: rawPhoto['id'].toString(),
                color: int.parse(
                    rawPhoto['color'].toString().replaceAll('#', '0xff')),
                author: rawPhoto['user']['username'].toString(),
                smallImage: rawPhoto['urls']['small'].toString(),
                image: rawPhoto['urls']['regular'].toString(),                
              ))
          .toList();
    } else {
      throw Exception('Error fetching Photos');
    }
  }
}
