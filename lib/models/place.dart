import 'package:my_confinement/models/geometry.dart';

class Place{
  final String name;
  final double rating;
  final int userRatingCount;
  final String vicinity;
  final Geometry geometry;


  Place({this.name,this.rating, this.userRatingCount, this.vicinity, this.geometry});

  Place.fromJson(Map<dynamic, dynamic>parsedJson)
  : name = parsedJson['name'],
  rating = (parsedJson['rating'] != null) ? parsedJson['rating'].toDouble() : null,
  userRatingCount = (parsedJson['user_rating_total'] != null) ? parsedJson['user_rating_total'] : null,
  vicinity = parsedJson['vicinity'],
  geometry = Geometry.fromJson(parsedJson['geometry']);

}