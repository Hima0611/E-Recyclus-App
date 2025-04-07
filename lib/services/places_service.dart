import 'package:http/http.dart' as http;
import 'dart:convert';

class PlacesService {
  static const String apiKey = 'AIzaSyB_lS9T1sC52_anjg_97fOei6UC2NxYW94';

  static Future<List<Map<String, dynamic>>> fetchNearbyEwasteCenters(
      double lat, double lng) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=$lat,$lng&radius=5000&type=recycling_center&keyword=ewaste&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        List<Map<String, dynamic>> places = [];
        for (var result in data['results']) {
          places.add({
            'name': result['name'],
            'lat': result['geometry']['location']['lat'],
            'lng': result['geometry']['location']['lng']
          });
        }
        return places;
      }
    }
    return [];
  }
}