
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_confinement/models/place.dart';
import 'package:my_confinement/services/geolocator_services.dart';
import 'package:my_confinement/services/marker_services.dart';
import 'package:my_confinement/widgets/menu.dart';
import 'package:provider/provider.dart';

class VeloMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();

    return FutureProvider(
      create: (context) => placesProvider,
        child: new Scaffold(
        drawer: Menu(),  
        appBar: new AppBar(
          title: Text("Maps"),
        ),
        body: (currentPosition != null)
            ? Consumer<List<Place>>(
                builder: (_, places, __) {
                  var markers = (places != null) ? markerService.getMarkers(places) : List<Marker>();
                  return Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 2  ,
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(currentPosition.latitude,
                                  currentPosition.longitude),
                              zoom: 16.0),
                          zoomGesturesEnabled: true,
                          markers: Set<Marker>.of(markers),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: (places != null) ? places.length : null,
                            itemBuilder: (context, index) {
                              return FutureProvider(
                                create : (context) => geoService.getDistance(
                                  currentPosition.latitude, 
                                  currentPosition.longitude, 
                                  places[index].geometry.location.lat, 
                                  places[index].geometry.location.lng),
                                child: Card(
                                  child: ListTile(
                                    title: Text(places[index].name),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                      (places[index].rating != null) ? Row(children: <Widget>[
                                        RatingBarIndicator(
                                          rating: places[index].rating,
                                          itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber,),
                                          itemCount: 5,
                                          itemSize: 10.0,
                                          direction: Axis.horizontal,
                                        )
                                      ],): Row(),
                                      Consumer<double>(
                                        builder: (context, meter, wiget){
                                          return (meter != null)
                                          ? Text('${places[index].vicinity} \u00b7 ${meter.round()}')
                                          : Container();
                                        },
                                      )
                                    ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}