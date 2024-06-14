import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../locationservices/location_utils.dart';

class DisplayMapsView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _DisplayMapsViewState();
  }

}

class _DisplayMapsViewState extends State<DisplayMapsView> with WidgetsBindingObserver{
  late GoogleMapController _mapController;
  late LatLng _initialLocation;
  GpsStatus? _gpsStatus;

  @override
  void initState() {
    super.initState();
    //_weatherData = WeatherRepository().fetchWeatherData(city);
    //WeatherRepository().fetchWeatherData(city);
    WidgetsBinding.instance!.addObserver(this);
    _getUserLocation();

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("App lifecycle changed $state");
    if (state == AppLifecycleState.resumed && _gpsStatus != null) {
      // App resumed and GPS is enabled, refetch location
      setState(() {

      });
      _getUserLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather'),
        ),
        body: FutureBuilder(
          future: _getUserLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              if(snapshot.hasError){

                _gpsStatus = snapshot.error as GpsStatus;
                if(_gpsStatus == GpsStatus.permissionUnavailable){
                  return Column(
                    children: [
                      const Icon(Icons.gps_off, color: Colors.red),
                      Text('GPS is disabled on your device.'),
                      ElevatedButton(
                        onPressed: () async {
                          await Geolocator.openLocationSettings();
                        },
                        child: const Text('Enable GPS'),
                      ),
                    ],
                  );
                }
                else if(_gpsStatus ==  GpsStatus.disabled){
                  return Column(
                    children: [
                      const Icon(Icons.gps_off, color: Colors.red),
                      Text('GPS is disabled on your device.'),
                      ElevatedButton(
                        onPressed: () async {
                          await Geolocator.openLocationSettings();
                        },
                        child: const Text('Enable GPS'),
                      ),
                    ],
                  );
                }
                else{
                  return const SizedBox();
                }
              }
              else{
                return Stack(
                  children: [
                    // Google Map widget
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _initialLocation ?? const LatLng(0, 0), // Default to (0, 0) if location unavailable
                        zoom: 16,
                      ),
                      onMapCreated: (controller) => _mapController = controller,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false, // Optional: disable zoom controls for full-screen experience
                    ),
                    // Optional: Center the user location button (adjust position as needed)
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
                        child: FloatingActionButton(
                          onPressed: () => _centerUserLocation(),
                          child: const Icon(Icons.gps_fixed),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }

  void _centerUserLocation() async {
    final locationData = await LocationUtils().determinePosition(); // Replace with your location fetching method
    if (locationData != null) {
      final center = LatLng(locationData?.latitude ?? 0.0, locationData.longitude ?? 0.0);
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: center, zoom: 16),
      ));
    }
  }

  Future<LatLng> _getUserLocation() async {
    print("Trying to get location now");
    final locationData = await LocationUtils().determinePosition().onError((error, stackTrace){
      return Future.error(error!);
    }); // Replace with your location fetching method
    if (locationData != null) {
      print("Latitude ${locationData.latitude}");
      _initialLocation = LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
    }
    return Future.value(_initialLocation);
  }
}

enum GpsStatus {
  enabled,
  disabled,
  permissionUnavailable,
}
