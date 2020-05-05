import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_confinement/services/geolocator_services.dart';
import 'package:my_confinement/services/places_services.dart';
import 'package:my_confinement/views/compass.dart';
import 'package:my_confinement/views/posts.dart';
import 'package:my_confinement/views/todolist.dart';
import 'package:my_confinement/views/velomap.dart';
import 'package:my_confinement/widgets/menu.dart';
import 'package:provider/provider.dart';

import 'models/place.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers : [
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position, Future<List<Place>>>(
          update: (context,position,places){
            return (position != null) ? placesService.getPlaces( position.latitude, position.longitude) : null;
          },
        )
      ],
        child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        routes: <String, WidgetBuilder>{
          "/todolist": (BuildContext context) => new TodoList(),
          "/compass": (BuildContext context) => new Compass(),
          "/velomap": (BuildContext context) => new VeloMap(),
          "/posts": (BuildContext context) => new Posts()
        }
          
        ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      body: TodoList()// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  
}

