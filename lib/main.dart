import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_gallery/blocs/photos/photos_bloc.dart';
import 'package:un_gallery/screens/HomeScreen.dart';
import 'package:un_gallery/screens/PhotoScreen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PhotosBloc>.value(value: PhotosBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gallery Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          PhotoScreen.routeName: (ctx) =>
              PhotoScreen(photo: settings.arguments),
          HomeScreen.routeName: (ctx) => HomeScreen(),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
