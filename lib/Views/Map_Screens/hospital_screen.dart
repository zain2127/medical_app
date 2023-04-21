import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NearbyHospitals extends StatefulWidget {
  @override
  _NearbyHospitalsState createState() => _NearbyHospitalsState();
}

class _NearbyHospitalsState extends State<NearbyHospitals> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set();
  var _location = Location();
  LocationData? _currentLocation;
  LatLng? currentLatLng;


  void _onMapCreated(GoogleMapController controller)async{
    _controller.complete(controller);
  }

 Future<LatLng?>_getCurrentLocation() async {
    try {
      var locationData = await _location.getLocation();
      setState(() {
        _currentLocation = locationData;
        currentLatLng=LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
      });
     await _getNearbyHospitals();
     return currentLatLng!;
    } catch (e) {
      print('Could not get location: $e');
      return null;
    }
  }

 Future<void> _getNearbyHospitals() async {
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentLocation!.latitude},${_currentLocation!.longitude}&radius=2000&type=hospital&key=AIzaSyAywNYr7AK39rXkrhLtWU-xNGT-SQ4VAHc';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var place in jsonData['results']) {
        String name = place['name'];
        double lat = place['geometry']['location']['lat'];
        double lng = place['geometry']['location']['lng'];
        String address = place['hospital'];
        setState(() {
          _markers.add(
            Marker(
              markerId: MarkerId(name),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: name, snippet: address),
            ),
          );
        });
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
   // future=_getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Hospitals'),
      ),
      body: FutureBuilder<LatLng?>(
        future: _getCurrentLocation(),
        builder: (context, snapshot) =>
          (snapshot.connectionState==ConnectionState.done)?
          (snapshot.hasData)?
           GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(_currentLocation!.latitude!,_currentLocation!.longitude! ),
              zoom: 14,
            ),
            myLocationEnabled: true,
            markers: _markers,
          ):const  Text("Error while loading map")
              :const Center(child: CircularProgressIndicator())

      ),
    );
  }
}