import 'dart:async';
import 'package:flutter/services.dart' as services;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/model/city.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final googleMapsController = Completer<GoogleMapController>();
  Set<Marker> googleMapsMarkers = {};
  Set<Circle> googleMapsCircles = {};
  List<ModelCity> filteredCities = cities;

  @override
  void initState() {
    super.initState();

    setState(() {
      googleMapsMarkers = cities.map((city) {
        return Marker(
          markerId: MarkerId(city.name),
          position: city.coordinates,
          infoWindow: InfoWindow(title: city.name),
        );
      }).toSet();

      googleMapsCircles = cities.map((city) {
        return Circle(
          circleId: CircleId(city.name),
          center: city.coordinates,
          radius: 500,
          fillColor: Colors.blue.withAlpha(50),
          strokeWidth: 1,
          strokeColor: Colors.blue.withAlpha(200),
        );
      }).toSet();
    });
  }

  void onQueryChanged(String query) {
    setState(() {
      filteredCities = cities.where((city) => city.name.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void navigateToCity(ModelCity city) async {
    final controller = await googleMapsController.future;

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: city.coordinates,
          zoom: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          map(),
          searchBar(),
        ],
      ),
    );
  }

  Widget map() => Expanded(
        child: GoogleMap(
          markers: googleMapsMarkers,
          circles: googleMapsCircles,
          initialCameraPosition: CameraPosition(
            target: filteredCities[0].coordinates,
            zoom: 15,
          ),
          myLocationButtonEnabled: false,
          onMapCreated: (GoogleMapController controller) async {
            // Style: https://snazzymaps.com/style/38/shades-of-grey
            final mapStyle = await services.rootBundle.loadString("assets/google_maps_style.json");
            await controller.setMapStyle(mapStyle);

            googleMapsController.complete(controller);
          },
        ),
      );

  Widget searchBar() => FloatingSearchBar(
      hint: "Vai ad una città",
      onQueryChanged: onQueryChanged,
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                filteredCities.length,
                (index) => ListTile(
                  onTap: () => navigateToCity(
                    filteredCities[index],
                  ),
                  title: Text(
                    filteredCities[index].name,
                  ),
                ),
              ),
            ),
          ),
        );
      });
}
