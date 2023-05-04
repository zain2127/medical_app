import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NearbyClinic extends StatefulWidget {
  const NearbyClinic({super.key});

  @override
  _NearbyClinicState createState() => _NearbyClinicState();
}

class _NearbyClinicState extends State<NearbyClinic> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  Position? _currentLocation;
  LatLng? currentLatLng;
  late var future;

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
  }

  Future<LatLng?> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _currentLocation = position;
      currentLatLng =
          LatLng(_currentLocation!.latitude, _currentLocation!.longitude);
      await _getNearbyHospitals();
      return currentLatLng!;
    } catch (e) {
      print('Could not get location: $e');
      return null;
    }
  }

  Future<void> _getNearbyHospitals() async {
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentLocation!.latitude},${_currentLocation!.longitude}&radius=2000&type=hospitals&key=AIzaSyAqco1nAu3kgi5xOSS69My79r7EnR1lwFs';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var place in jsonData['results']) {
        String url =
            'https://maps.googleapis.com/maps/api/place/details/json?place_id=${place["place_id"]}&key=AIzaSyAqco1nAu3kgi5xOSS69My79r7EnR1lwFs';
        var res = await http.get(Uri.parse(url));
        if (res.statusCode == 200) {
          String name = place['name'];
          double lat = place['geometry']['location']['lat'];
          double lng = place['geometry']['location']['lng'];
          var addressJsonData = json.decode(res.body);
          String component = "";
          for (var address in addressJsonData["result"]["address_components"]) {
            component += address['long_name'];
          }
          String address = component;

          _markers.add(
            Marker(
              markerId: MarkerId(name),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: name, snippet: address),
            ),
          );
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    future = _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Clinics'),
      ),
      body: FutureBuilder<LatLng?>(
          future: future,
          builder: (context, snapshot) =>
          (snapshot.connectionState == ConnectionState.done)
              ? (snapshot.hasData)
              ? GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(_currentLocation!.latitude!,
                  _currentLocation!.longitude!),
              zoom: 14,
            ),
            myLocationEnabled: true,
            markers: _markers,
          )
              : const Text("Error while loading map")
              : const Center(child: CircularProgressIndicator())),
    );
  }
}
