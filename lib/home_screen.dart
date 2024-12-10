import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController _googleMapController;

  Position? position;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final LatLng _destination = const LatLng(23.808639, 90.357718);

  @override
  void initState() {
    super.initState();
    listenCurrentLocation();

    _markers.add(
      Marker(
        markerId: const MarkerId('newLocation'),
        position: _destination,
        infoWindow: InfoWindow(title: 'Destination', snippet: '$_destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  Future<void> listenCurrentLocation() async {
    final isGranted = await isLocationPermissionGranted();
    if (isGranted) {
      final isServiceEnabled = await checkGPSServiceEnable();
      if (isServiceEnabled) {
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            timeLimit: Duration(seconds: 5),
            accuracy: LocationAccuracy.bestForNavigation,
          ),
        ).listen((pos) {
          setState(() {
            position = pos;

            _markers.removeWhere((m) => m.markerId.value == 'currentLocation');
            _markers.add(
              Marker(
                markerId: const MarkerId('currentLocation'),
                position: LatLng(position!.latitude, position!.longitude),
                infoWindow:
                    InfoWindow(title: 'My current location', snippet: '$position'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
              ),
            );

            _addPolyline();
          });
        });
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      final result = await requestLocationPermission();
      if (result) {
        getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }
  }

  void _addPolyline() {
    if (position != null) {
      _polylines.clear();
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: [
            LatLng(position!.latitude, position!.longitude),
            _destination
          ],
          color: Colors.blue,
          width: 5,
        ),
      );
    }
  }

  Future<void> getCurrentLocation() async {
    final isGranted = await isLocationPermissionGranted();
    if (isGranted) {
      final isServiceEnabled = await checkGPSServiceEnable();
      if (isServiceEnabled) {
        Position p = await Geolocator.getCurrentPosition();
        setState(() {
          position = p;
          _markers.removeWhere((m) => m.markerId.value == 'currentLocation');
          _markers.add(
            Marker(
              markerId: const MarkerId('currentLocation'),
              position: LatLng(position!.latitude, position!.longitude),
              infoWindow:
                  InfoWindow(title: 'My current location', snippet: '$position'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
            ),
          );

          _addPolyline();
        });
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      final result = await requestLocationPermission();
      if (result) {
        getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }
  }

  Future<bool> isLocationPermissionGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> checkGPSServiceEnable() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Location Tracker'),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        compassEnabled: true,
        trafficEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          tilt: 6.5,
          target: LatLng(position!.latitude, position!.longitude),
          zoom: 17,
        ),
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          _googleMapController = controller;
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentLocation();
          if (position != null) {
            _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position!.latitude, position!.longitude),
                  zoom: 17,
                ),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
