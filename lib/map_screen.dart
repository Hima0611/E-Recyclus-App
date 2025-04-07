import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  final String apiKey = 'YOUR_GOOGLE_MAPS_API_KEY'; // Replace with your key
  Set<Marker> _markers = {};

  Future<void> _searchPlace() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: apiKey,
      mode: Mode.overlay,
      language: "en",
      components: [Component(Component.country, "IN")],
    );

    if (p != null) {
      final places = GoogleMapsPlaces(apiKey: apiKey);
      PlacesDetailsResponse detail =
      await places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));

      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(p.placeId!),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: detail.result.name),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Waste Recycling Centers"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchPlace,
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(28.6139, 77.2090), // New Delhi
          zoom: 12,
        ),
        markers: _markers,
        onMapCreated: (controller) => mapController = controller,
      ),
    );
  }
}
