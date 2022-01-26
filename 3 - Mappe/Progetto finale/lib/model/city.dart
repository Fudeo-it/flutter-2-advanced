import 'package:google_maps_flutter/google_maps_flutter.dart';

class ModelCity {
  final String name;
  final LatLng coordinates;

  const ModelCity({
    required this.name,
    required this.coordinates,
  });
}

final cities = [
  ModelCity(
    name: "Paris",
    coordinates: LatLng(48.8566, 2.3522),
  ),
  ModelCity(
    name: "Rome",
    coordinates: LatLng(41.9028, 12.4964),
  ),
];
