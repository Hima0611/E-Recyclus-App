import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';
import '../services/places_service.dart';

class EwasteMapScreen extends StatefulWidget {
  @override
  _EwasteMapScreenState createState() => _EwasteMapScreenState();
}

class _EwasteMapScreenState extends State<EwasteMapScreen> {
  GoogleMapController? mapController;
  Set<Marker> _markers = {};

  void _loadEwasteCenters() async {
    Position position = await LocationService.getUserLocation();
    List<Map<String, dynamic>> places =
    await PlacesService.fetchNearbyEwasteCenters(
        position.latitude, position.longitude);

    setState(() {
      for (var place in places) {
        _markers.add(
          Marker(
            markerId: MarkerId(place['name']),
            position: LatLng(place['lat'], place['lng']),
            infoWindow: InfoWindow(title: place['name']),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadEwasteCenters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("E-Waste Recycling Centers")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(28.6139, 77.2090), // Default: New Delhi
          zoom: 12,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}