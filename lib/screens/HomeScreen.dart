import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_gallery/blocs/photos/photos_bloc.dart';
import 'package:un_gallery/widgets/PhotoTile.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PhotosBloc _photosBloc;

  @override
  void initState() {
    super.initState();

    _photosBloc = BlocProvider.of<PhotosBloc>(context);
    print("Init Home Screen");
    _photosBloc.add(PhotosFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photos"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: BlocBuilder<PhotosBloc, PhotosState>(
              builder: (context, state) {
                if (state is PhotosError) {
                  return _centerMessage(state.error);
                }

                if (state is PhotosLoaded) {
                  if (state.photos.isEmpty) {
                    return _centerMessage("No Photos");
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 2
                          : 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return PhotoTile(
                        photo: state.photos[index],
                        key: ValueKey(state.photos[index].id),
                      );
                    },
                    itemCount: state.photos.length,
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _centerMessage(String message) {
    return Center(
      child: Text(message),
    );
  }
}
